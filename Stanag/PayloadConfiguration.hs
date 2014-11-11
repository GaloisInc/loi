{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

module Stanag.PayloadConfiguration where

import Ivory.Language
import Stanag.Packing

payloadConfigurationInstance :: MemArea (Stored Uint32)
payloadConfigurationInstance = area "payloadConfigurationInstance" (Just (ival 0))

[ivoryFile|Stanag/PayloadConfiguration.ivory|]
