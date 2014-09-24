{-# LANGUAGE DataKinds #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

module Types where

import Ivory.Language

type Idx = Ix 576
type Buf = Array 576 (Stored Uint8)

[ivory|
string struct LOI 10
|]
