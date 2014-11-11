{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}

module Stanag.PayloadConfiguration where

import Ivory.Language
import Stanag.Packing
import Util.Logger

payloadConfigurationInstance :: MemArea (Stored Uint32)
payloadConfigurationInstance = area "payloadConfigurationInstance" (Just (ival 0))

[ivoryFile|Stanag/PayloadConfiguration.ivory|]
