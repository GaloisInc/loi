{-# LANGUAGE DataKinds #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}

module Util.Logger where

import Ivory.Language

logHeader :: String
logHeader = "nothing.h"

logger :: Def('[Sint32, IString] :-> ())
logger = importProc "logger" logHeader

loggeri :: Def('[Sint32, IString, Sint32] :-> ())
loggeri = importProc "loggeri" logHeader

loggerii :: Def('[Sint32, IString, Sint32, Sint32] :-> ())
loggerii = importProc "loggerii" logHeader

loggeriii :: Def('[Sint32, IString, Sint32, Sint32, Sint32] :-> ())
loggeriii = importProc "loggeriii" logHeader

