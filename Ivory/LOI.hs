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

module LOI where

import Ivory.Language

import qualified MessageAcknowledgement   as M
import qualified CucsAuthorisationRequest as C
import qualified VsmAuthorisationResponse as V


-- loi.ivory

mStations :: MemArea (Array 32 (Struct "Component"))
mStations = area "mStations" Nothing


{-# LINE 0 "loi.ivory" #-}
[ivoryFile|loi.ivory|]

-- loiModule :: Module
-- loiModule = package "loiModule" $ do
--   depend packing
  -- memcpy
