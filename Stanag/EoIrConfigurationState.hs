{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}

module Stanag.EoIrConfigurationState where

import Ivory.Language
import Stanag.Packing
import Util.Logger

eoIrConfigurationStateInstance :: MemArea (Stored Uint32)
eoIrConfigurationStateInstance = area "eoIrConfigurationStateInstance" (Just (ival 0))

[ivoryFile|Stanag/EoIrConfigurationState.ivory|]
