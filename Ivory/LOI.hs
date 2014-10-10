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

-- loi.ivory

mStations :: MemArea (Array 32 (Struct "Component"))
mStations = area "mStations" Nothing

mVehicle :: MemArea (Struct "Component")
mVehicle = area "mVehicle" Nothing

-- Must be == max_NUM_CUCS
responses :: MemArea (Array 6 (Struct "VsmAuthorizationResponse"))
responses = area "responses" (Just (iarray (replicate 6 response)))
  where
  response = istruct [V.cucsId .= ival 0]

nullResponse :: MemArea (Struct "VsmAuthorizationResponse")
nullResponse = area "response" (Just (istruct [V.cucsId .= ival 0]))

[ivoryFile|loi.ivory|]

loiModule :: Module
loiModule = package "loiModule" $ do
   depend M.messageacknowledgement
   depend C.cucsauthorisationrequest
   depend V.vsmauthorizationresponse
   depend loi

allModules :: [Module]
allModules = [ loi, loiModule, M.messageacknowledgement, C.cucsauthorisationrequest, V.vsmauthorizationresponse ]


main = void $ runCompiler allModules initialOpts { constFold = True, includeDir = "output", srcDir = "output"  }

