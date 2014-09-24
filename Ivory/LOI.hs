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
import Ivory.Stdlib.Maybe

import qualified MessageAcknowledgement   as M
import qualified CucsAuthorisationRequest as C
import qualified VsmAuthorisationResponse as V


-- For CucsAuthorisationRequest idd field

-- instance MaybeType "maybe_StanagVsmAuthorizationResponse" StanagVsmAuthorizationResponse where
--   maybeValueLabel = m_auth
--   maybeValidLabel = m_valid

-- [ivoryFile|loi.ivory|]

-- loiModule :: Module
-- loiModule = package "loiModule" $ do
--   depend packing
  -- memcpy
