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
import Ivory.Artifact

import qualified Paths_ivory_serialize           as P

import qualified Stanag.MessageAcknowledgement   as M
import qualified Stanag.CucsAuthorisationRequest as C
import qualified Stanag.VsmAuthorisationResponse as V

import Stanag.CucsAuthorisationRequest (c_LOI2, c_LOI3, c_LOI4, c_LOI5)
import Stanag.EoIrConfigurationState (eoIrConfigurationStateMsgNum)
import Stanag.EoIrLaserOperatingState (eoIrLaserOperatingStateMsgNum)
import Stanag.EoIrLaserPayloadCommand (eoIrLaserPayloadCommandMsgNum)
import Stanag.FieldConfigurationRequest (fieldConfigurationRequestMsgNum)
import Stanag.PayloadConfiguration (payloadConfigurationMsgNum)
import Stanag.PayloadSteeringCommand (payloadSteeringCommandMsgNum)

import Stanag.Packing
import Stanag.LOIMap
import Util.Logger
import Util.Time

glueHeader :: String
glueHeader = "loiglue.h"

sendToVehicle :: Def('[Ref s StanagBuf, Uint32] :-> ())
sendToVehicle = importProc "sendToVehicle" glueHeader

sendToStation :: Def('[Sint32, Ref s StanagBuf, Uint32] :-> ())
sendToStation = importProc "sendToStation" glueHeader

sendToCucs :: Def('[Ref s StanagBuf, Uint32] :-> ())
sendToCucs = importProc "sendToCucs" glueHeader


[ivory|
struct StationStatus {
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
   defStruct (Proxy :: Proxy "LOIConfig")
   -- temp mem areas to be defined in their own modules later
   defMemArea C.cucsAuthorisationRequestInstance
   defMemArea V.vsmAuthorisationResponseInstance
   defMemArea M.messageAcknowledgementInstance

allModules :: [Module]
allModules = [ loiloi
             , stanagpacking
             , loiModule
             , loiMapModule
             , M.stanagmessageacknowledgement
             , C.stanagcucsauthorisationrequest
             , V.stanagvsmauthorisationresponse
             ]

serializeHdr =
  artifactCabalFile P.getDataDir ("support/ivory_serialize_prim.h")

main = runCompiler
         allModules
         [serializeHdr]
         initialOpts
         { constFold = True
         , outDir = Just "out"
         }

