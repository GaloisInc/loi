{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}

module Packing where

import Ivory.Language
import Ivory.Stdlib.String
import Types

import Ivory.Serialize

packIxAdd :: ANat n => Uint32 -> Ix n -> Uint32
packIxAdd ix0 ix1 = ix0 + twosComplementRep (fromIx ix1)

[ivoryFile|packing.ivory|]
