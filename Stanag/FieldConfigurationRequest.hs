{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

module Stanag.FieldConfigurationRequest where

import Ivory.Language
import Stanag.Packing

fieldConfigurationRequestInstance :: MemArea (Stored Uint32)
fieldConfigurationRequestInstance = area "fieldConfigurationRequestInstance" (Just (ival 0))

[ivoryFile|Stanag/FieldConfigurationRequest.ivory|]
