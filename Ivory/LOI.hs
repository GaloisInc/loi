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

import Prelude hiding (return)
import Ivory.Language

-- foo :: Def ('[] :-> ())
-- foo = proc "foo" $ body $ retVoid

[ivory|
void foo()
{
  if(true) {}
  else {return;}
}

|]




-- [ivoryFile|src/loi.ivory|]
