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

import qualified MessageAcknowledgement   as M
import qualified CucsAuthorisationRequest as C
import qualified VsmAuthorizationResponse as V
import Types
import Packing

-- loi.ivory

mStations :: MemArea (Array 32 (Struct "StationStatus"))
mStations = area "mStations" Nothing

mVehicle :: MemArea (Struct "StationStatus")
mVehicle = area "mVehicle" Nothing

-- Must be == max_NUM_CUCS
mActiveCucs :: MemArea (Array 6 (Struct "VsmAuthorizationResponse"))
mActiveCucs = area "mActiveCucs" (Just (iarray (replicate 6 response)))
  where
  response = istruct [V.cucsId .= ival 0]

noResponse :: MemArea (Struct "VsmAuthorizationResponse")
noResponse = area "noResponse" (Just (istruct [V.cucsId .= ival 0]))

--typesModule :: Module

[ivoryFile|loi.ivory|]

loiModule :: Module
loiModule = package "loiModule" $ do
   depend typesModule
   depend packing
   depend M.messageacknowledgement
   depend C.cucsauthorisationrequest
   depend V.vsmauthorizationresponse
   depend loi
   defMemArea mStations
   defMemArea mVehicle
   defMemArea mActiveCucs
   defMemArea noResponse

allModules :: [Module]
allModules = [ loi, packing, typesModule, loiModule, M.messageacknowledgement, C.cucsauthorisationrequest, V.vsmauthorizationresponse ]


main = void $ runCompiler allModules initialOpts { constFold = True, includeDir = "output", srcDir = "output"  }

