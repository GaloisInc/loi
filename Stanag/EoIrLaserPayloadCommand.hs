{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

module Stanag.EoIrLaserPayloadCommand where

import Ivory.Language
import Stanag.Packing

eoIrLaserPayloadCommandInstance :: MemArea (Stored Uint32)
eoIrLaserPayloadCommandInstance = area "eoIrLaserPayloadCommandInstance" (Just (ival 0))

[ivoryFile|Stanag/EoIrLaserPayloadCommand.ivory|]
