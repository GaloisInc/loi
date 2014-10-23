{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

module Stanag.Packing where

import Ivory.Language
import Ivory.Stdlib.String
import Ivory.Serialize

-- type StanagIdx = Ix 576
type StanagBuf = Array 576 (Stored Uint8)

packIxAdd :: ANat n => Uint32 -> Ix n -> Uint32
packIxAdd ix0 ix1 = ix0 + twosComplementRep (fromIx ix1)

[ivoryFile|Stanag/packing.ivory|]

