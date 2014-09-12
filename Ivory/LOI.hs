{-# LANGUAGE DataKinds #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}

--
-- Ivory LOI implementation.
--
-- Copyright (C) 2014, Galois, Inc.
-- All rights reserved.
--

module LOI where

import Prelude hiding (return, init)
import Ivory.Language
import Ivory.Serialize

-- memcpy :: Def ('[ IDouble
--                 , ConstRef s2 (CArray (Stored Uint8))
--                 , Sint32] :-> Sint32)
-- memcpy = importProc "memcpy" "string.h"

-- sizeOf :: Def ('[IDouble] :-> Sint32)
-- sizeOf = proc "sizeof" $ \d -> body $ do undefined

-- packDouble :: Def ('[IDouble, Ref s (CArray (Stored Uint8))] :-> ())
-- packDouble = proc "packDouble" $ \d ref -> body $ do undefined

foo :: Def ('[Ref s (Array 576 (Stored Uint8)), Uint32] :-> Sint32)
foo = proc "foo" $ \buf ix -> body $ do
  v <- unpack (constRef (toCArray buf)) ix
  ret v


-- type Buf = Array 576 (Stored Uint8)
type Idx = Ix 576

-- For CucsAuthorisationRequest idd field
[ivory|
string struct LOI 10
|]

packIxAdd ix0 ix1 = ix0 + twosComplementRep (fromIx ix1)

[ivoryFile|packing.ivory|]
[ivoryFile|CucsAuthorisationRequest.ivory|]
-- [ivoryFile|loi.ivory|]

-- loiModule :: Module
-- loiModule = package "loiModule" $ do
--   depend packing
  -- memcpy
