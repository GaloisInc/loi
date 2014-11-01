{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

module Stanag.CucsAuthorisationRequest where

import Ivory.Language
import Stanag.Packing

cucsAuthorisationRequestInstance :: MemArea (Stored Uint32)
cucsAuthorisationRequestInstance = area "cucsAuthorisationRequestInstance" (Just (ival 0))

[ivoryFile|Stanag/CucsAuthorisationRequest.ivory|]
