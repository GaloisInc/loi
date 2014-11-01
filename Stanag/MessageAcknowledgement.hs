{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

module Stanag.MessageAcknowledgement where

import Ivory.Language
import Stanag.Packing

messageAcknowledgementInstance :: MemArea (Stored Uint32)
messageAcknowledgementInstance = area "messageAcknowledgementInstance" (Just (ival 0))

[ivoryFile|Stanag/MessageAcknowledgement.ivory|]
