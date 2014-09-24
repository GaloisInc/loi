{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}

module Packing where

import Ivory.Language
import Types

import Ivory.Serialize

packIxAdd ix0 ix1 = ix0 + twosComplementRep (fromIx ix1)

[ivoryFile|packing.ivory|]
