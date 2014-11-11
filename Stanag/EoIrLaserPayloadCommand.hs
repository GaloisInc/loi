{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}

module Stanag.EoIrLaserPayloadCommand where

import Ivory.Language
import Stanag.Packing
import Util.Logger

eoIrLaserPayloadCommandInstance :: MemArea (Stored Uint32)
eoIrLaserPayloadCommandInstance = area "eoIrLaserPayloadCommandInstance" (Just (ival 0))

[ivoryFile|Stanag/EoIrLaserPayloadCommand.ivory|]
