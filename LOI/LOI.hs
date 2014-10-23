{-# LANGUAGE DataKinds #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}

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

[ivory|
struct StationStatus {
 int32_t next;
 bool nextValid;
 bool overriden;
 ix_t 6 authIdx;
}
|]

mStations :: MemArea (Array 32 (Struct "StationStatus"))
mStations = area "mStations" Nothing

mVehicle :: MemArea (Struct "StationStatus")
mVehicle = area "mVehicle" Nothing

-- Must be == max_NUM_CUCS
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
   defMemArea mStations
   defMemArea mVehicle
   defMemArea mActiveCucs
   defStruct (Proxy :: Proxy "StationStatus")

allModules :: [Module]
allModules = [ loiloi, stanagpacking, loiModule, loiMapModule, M.stanagmessageacknowledgement, C.stanagcucsauthorisationrequest, V.stanagvsmauthorisationresponse ]


main = void $ runCompiler allModules initialOpts { constFold = True, includeDir = "output", srcDir = "output"  }
