{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
-- Due to coverage condition on fundeps
{-# LANGUAGE UndecidableInstances #-}

module VsmAuthorizationResponse where

import Ivory.Language

import Types
import Packing

[ivoryFile|VsmAuthorizationResponse.ivory|]

validResponse :: Ref s (Struct "maybe_VsmAuthorizationResponse") -> Ivory eff IBool
validResponse ref = return =<< deref (ref ~> valid)

setValidResponse :: Ref s (Struct "maybe_VsmAuthorizationResponse") -> Ivory eff ()
setValidResponse ref = store (ref ~> valid) true

setInvalidResponse :: Ref s (Struct "maybe_VsmAuthorizationResponse") -> Ivory eff ()
setInvalidResponse ref = store (ref ~> valid) false

-- mapSetVSM :: Ref s (Struct "maybe_VsmAuthorizationResponse") -> Ref s (Struct "VsmAuthorizationResponse") -> Ivory eff ()
-- mapSetVSM ref = store (ref ~> valid) true
