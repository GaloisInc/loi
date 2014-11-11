{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

module Stanag.PayloadSteeringCommand where

import Ivory.Language
import Stanag.Packing

payloadSteeringCommandInstance :: MemArea (Stored Uint32)
payloadSteeringCommandInstance = area "payloadSteeringCommandInstance" (Just (ival 0))

[ivoryFile|Stanag/PayloadSteeringCommand.ivory|]
