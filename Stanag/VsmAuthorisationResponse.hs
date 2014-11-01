{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

module Stanag.VsmAuthorisationResponse where

import Ivory.Language
import Stanag.Packing

vsmAuthorisationResponseInstance :: MemArea (Stored Uint32)
vsmAuthorisationResponseInstance = area "vsmAuthorisationResponseInstance" (Just (ival 0))

[ivoryFile|Stanag/VsmAuthorisationResponse.ivory|]
