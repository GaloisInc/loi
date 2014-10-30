{-# LANGUAGE DataKinds #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}

--
-- Ivory LOI implementation.
--
-- Copyright (C) 2014, Galois, Inc.
-- All rights reserved.
--

module Main where

import Ivory.Language
import Ivory.Compile.C.CmdlineFrontend
import Control.Monad

import qualified Stanag.MessageAcknowledgement   as M
import qualified Stanag.CucsAuthorisationRequest as C
import qualified Stanag.VsmAuthorisationResponse as V
import Stanag.Packing
import Stanag.LOIMap

glueHeader :: String
glueHeader = "loiglue.h"

logger :: Def('[Sint32, IString] :-> ())
logger = importProc "logger" glueHeader

loggeri :: Def('[Sint32, IString, Sint32] :-> ())
loggeri = importProc "loggeri" glueHeader

loggerii :: Def('[Sint32, IString, Sint32, Sint32] :-> ())
loggerii = importProc "loggerii" glueHeader

loggeriii :: Def('[Sint32, IString, Sint32, Sint32, Sint32] :-> ())
loggeriii = importProc "loggeriii" glueHeader

timestamp :: Def('[] :-> IDouble)
timestamp = importProc "timestamp" glueHeader

sendToVehicle :: Def('[Ref s StanagBuf, Uint32] :-> ())
sendToVehicle = importProc "sendToVehicle" glueHeader

sendToStation :: Def('[Sint32, Ref s StanagBuf, Uint32] :-> ())
sendToStation = importProc "sendToStation" glueHeader

sendToCucs :: Def('[Ref s StanagBuf, Uint32] :-> ())
sendToCucs = importProc "sendToCucs" glueHeader


[ivory|
struct StationStatus {
 int32_t next; -- eventually will point to next component for passing data
 bool nextValid;
 bool overriden;
 int32_t authIdx; -- can be -1 for not valid
}

struct LOIConfig {
 uint16_t vehicleType;
 uint16_t vehicleSubType;
 int32_t  vehicleId;
}
|]


type StationIdx = Ix 32
mStations :: MemArea (Array 32 (Struct "StationStatus"))
mStations = area "mStations" (Just (iarray (replicate 32 station)))
  where
  station = istruct [ authIdx .= ival (-1), nextValid .= ival false, overriden .= ival false ]

mVehicle :: MemArea (Struct "StationStatus")
mVehicle = area "mVehicle" (Just (istruct [ authIdx .= ival (-1), nextValid .= ival false, overriden .= ival false ]))

mLOIConfig :: MemArea (Struct "LOIConfig")
mLOIConfig = area "mLOIConfig" (Just (istruct [ vehicleType .= ival 0, vehicleSubType .= ival 0, vehicleId .= ival 0 ]))

-- this size determines max number of CUCS that can be active
type CucsIdx = Ix 6
mActiveCucs :: MemArea (Array 6 (Struct "VsmAuthorisationResponse"))
mActiveCucs = area "mActiveCucs" (Just (iarray (replicate 6 response)))
  where
  response = istruct [V.cucsId .= ival 0]


[ivoryFile|LOI/loi.ivory|]


loiModule :: Module
loiModule = package "loiModule" $ do
   depend stanagpacking
   depend M.stanagmessageacknowledgement
   depend C.stanagcucsauthorisationrequest
   depend V.stanagvsmauthorisationresponse
   depend loiloi
   inclHeader glueHeader
   defMemArea mStations
   defMemArea mVehicle
   defMemArea mActiveCucs
   defMemArea mLOIConfig
   defStruct (Proxy :: Proxy "StationStatus")

allModules :: [Module]
allModules = [ loiloi, stanagpacking, loiModule, loiMapModule, M.stanagmessageacknowledgement, C.stanagcucsauthorisationrequest, V.stanagvsmauthorisationresponse ]


main = void $ runCompiler allModules initialOpts { constFold = True, includeDir = "output", srcDir = "output"  }

