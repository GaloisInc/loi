{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

module Stanag.EoIrLaserOperatingState where

import Ivory.Language
import Stanag.Packing

eoIrLaserOperatingStateInstance :: MemArea (Stored Uint32)
eoIrLaserOperatingStateInstance = area "eoIrLaserOperatingStateInstance" (Just (ival 0))

[ivoryFile|Stanag/EoIrLaserOperatingState.ivory|]
