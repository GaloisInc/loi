{-# LANGUAGE DataKinds #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}
module Stanag.LOIMap where

import Ivory.Language

[ivory|
struct LOIMap {
 uint32_t msg;
 uint32_t req;
}
|]

mLOIMap :: MemArea (Array 88 (Struct "LOIMap"))
mLOIMap = area "mLOIMap" (Just (iarray [
        istruct [ msg .= ival 1, req .= ival 15 ],
        istruct [ msg .= ival 20, req .= ival 15 ],
        istruct [ msg .= ival 21, req .= ival 15 ],
        istruct [ msg .= ival 40, req .= ival 12 ],
        istruct [ msg .= ival 41, req .= ival 12 ],
        istruct [ msg .= ival 42, req .= ival 12 ],
        istruct [ msg .= ival 43, req .= ival 12 ],
        istruct [ msg .= ival 44, req .= ival 12 ],
        istruct [ msg .= ival 45, req .= ival 12 ],
        istruct [ msg .= ival 46, req .= ival 12 ],
        istruct [ msg .= ival 47, req .= ival 12 ],
        istruct [ msg .= ival 48, req .= ival 12 ],
        istruct [ msg .= ival 100, req .= ival 13 ],
        istruct [ msg .= ival 101, req .= ival 13 ],
        istruct [ msg .= ival 102, req .= ival 13 ],
        istruct [ msg .= ival 103, req .= ival 12 ],
        istruct [ msg .= ival 104, req .= ival 13 ],
        istruct [ msg .= ival 105, req .= ival 12 ],
        istruct [ msg .= ival 106, req .= ival 13 ],
        istruct [ msg .= ival 107, req .= ival 12 ],
        istruct [ msg .= ival 108, req .= ival 12 ],
        istruct [ msg .= ival 109, req .= ival 13 ],
        istruct [ msg .= ival 110, req .= ival 13 ],
        istruct [ msg .= ival 200, req .= ival 2 ],
        istruct [ msg .= ival 201, req .= ival 2 ],
        istruct [ msg .= ival 202, req .= ival 2 ],
        istruct [ msg .= ival 203, req .= ival 2 ],
        istruct [ msg .= ival 204, req .= ival 2 ],
        istruct [ msg .= ival 205, req .= ival 2 ],
        istruct [ msg .= ival 206, req .= ival 2 ],
        istruct [ msg .= ival 207, req .= ival 2 ],
        istruct [ msg .= ival 300, req .= ival 3 ],
        istruct [ msg .= ival 301, req .= ival 3 ],
        istruct [ msg .= ival 302, req .= ival 3 ],
        istruct [ msg .= ival 303, req .= ival 3 ],
        istruct [ msg .= ival 304, req .= ival 3 ],
        istruct [ msg .= ival 305, req .= ival 3 ],
        istruct [ msg .= ival 306, req .= ival 3 ],
        istruct [ msg .= ival 307, req .= ival 2 ],
        istruct [ msg .= ival 308, req .= ival 2 ],
        istruct [ msg .= ival 400, req .= ival 15 ],
        istruct [ msg .= ival 401, req .= ival 15 ],
        istruct [ msg .= ival 402, req .= ival 15 ],
        istruct [ msg .= ival 403, req .= ival 15 ],
        istruct [ msg .= ival 404, req .= ival 15 ],
        istruct [ msg .= ival 500, req .= ival 15 ],
        istruct [ msg .= ival 501, req .= ival 15 ],
        istruct [ msg .= ival 502, req .= ival 15 ],
        istruct [ msg .= ival 503, req .= ival 15 ],
        istruct [ msg .= ival 600, req .= ival 14 ],
        istruct [ msg .= ival 700, req .= ival 14 ],
        istruct [ msg .= ival 800, req .= ival 12 ],
        istruct [ msg .= ival 801, req .= ival 12 ],
        istruct [ msg .= ival 802, req .= ival 12 ],
        istruct [ msg .= ival 803, req .= ival 12 ],
        istruct [ msg .= ival 804, req .= ival 12 ],
        istruct [ msg .= ival 805, req .= ival 12 ],
        istruct [ msg .= ival 806, req .= ival 12 ],
        istruct [ msg .= ival 900, req .= ival 12 ],
        istruct [ msg .= ival 1000, req .= ival 15 ],
        istruct [ msg .= ival 1001, req .= ival 15 ],
        istruct [ msg .= ival 1100, req .= ival 15 ],
        istruct [ msg .= ival 1101, req .= ival 15 ],
        istruct [ msg .= ival 1200, req .= ival 15 ],
        istruct [ msg .= ival 1201, req .= ival 15 ],
        istruct [ msg .= ival 1202, req .= ival 15 ],
        istruct [ msg .= ival 1203, req .= ival 15 ],
        istruct [ msg .= ival 1300, req .= ival 15 ],
        istruct [ msg .= ival 1301, req .= ival 15 ],
        istruct [ msg .= ival 1302, req .= ival 15 ],
        istruct [ msg .= ival 1303, req .= ival 15 ],
        istruct [ msg .= ival 1304, req .= ival 15 ],
        istruct [ msg .= ival 1400, req .= ival 15 ],
        istruct [ msg .= ival 1401, req .= ival 15 ],
        istruct [ msg .= ival 1402, req .= ival 15 ],
        istruct [ msg .= ival 1403, req .= ival 15 ],
        istruct [ msg .= ival 1500, req .= ival 12 ],
        istruct [ msg .= ival 1501, req .= ival 12 ],
        istruct [ msg .= ival 1600, req .= ival 12 ],
        istruct [ msg .= ival 2000, req .= ival 12 ],
        istruct [ msg .= ival 2001, req .= ival 12 ],
        istruct [ msg .= ival 2002, req .= ival 13 ],
        istruct [ msg .= ival 2004, req .= ival 13 ],
        istruct [ msg .= ival 2005, req .= ival 13 ],
        istruct [ msg .= ival 2013, req .= ival 13 ],
        istruct [ msg .= ival 2014, req .= ival 13 ],
        istruct [ msg .= ival 2244, req .= ival 12 ],
        istruct [ msg .= ival 2441, req .= ival 12 ]
    ]))

loiMapModule :: Module
loiMapModule = package "loiMapModule" $ do
   defStruct (Proxy :: Proxy "LOIMap")
   defMemArea mLOIMap
