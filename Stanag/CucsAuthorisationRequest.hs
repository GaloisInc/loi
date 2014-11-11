{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}

module Stanag.CucsAuthorisationRequest where

import Ivory.Language
import Stanag.Packing
import Util.Logger

cucsAuthorisationRequestInstance :: MemArea (Stored Uint32)
cucsAuthorisationRequestInstance = area "cucsAuthorisationRequestInstance" (Just (ival 0))

[ivoryFile|Stanag/CucsAuthorisationRequest.ivory|]
