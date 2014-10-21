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

struct StationStatus {
 int32_t next;
 bool nextValid;
 bool overriden;
 ix_t 6 authIdx;
}

|]

typesModule :: Module
typesModule = package "typesModule" $ do
    defStruct (Proxy :: Proxy "ivory_string_LOI")
    defStruct (Proxy :: Proxy "StationStatus")
	

