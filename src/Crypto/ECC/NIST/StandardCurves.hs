-----------------------------------------------------------------------------
-- |
-- Module      :  Crypto.ECC.NIST.StandardCurves
-- Copyright   :  (c) Marcel Fourné 20[09..14]
-- License     :  BSD3
-- Maintainer  :  Marcel Fourné (mail@marcelfourne.de)
-- Stability   :  experimental
-- Portability :  Good
-- 
-- ECC NIST Standard Curves, taken from NISTReCur.pdf[http://csrc.nist.gov/groups/ST/toolkit/documents/dss/NISTReCur.pdf]
-- NB: The rigidity of the curve parameters may be manipulatable, for more
--     information see http://safecurves.cr.yp.to/rigid.html
--     Therein mentioned are only the NIST Prime Curves, because...
-- NB F2: Read up on solving the Discrete Logarithm Problem in fields of small characteristic (i.e. here: Binary Curves)
--        and then decide if the results are relevant to you.
-- Recommendation: If your need NIST Curves and you do not know which one, use the Prime Curves.
--
-----------------------------------------------------------------------------

{-# OPTIONS_GHC -O2 -fllvm -optlo-O3 -feager-blackholing #-}
{-# LANGUAGE DeriveDataTypeable #-}

module Crypto.ECC.NIST.StandardCurves
    where

import Prelude(Int,Integer,fromInteger)
import Crypto.ECC.NIST.Base (FPrime,fpfromInteger,F2,f2fromInteger)
import Crypto.Types (BitLength)
import Data.Typeable(Typeable)

-- | Datatype for defined Standard Curves
data StandardCurve = 
  -- Curves on Prime Fields
    StandardCurve {stdc_l::BitLength,stdc_p::FPrime,stdc_r::Integer,stdc_b::FPrime,stdc_xp::FPrime,stdc_yp::FPrime}
  -- Curves on Binary Fields (F2)
  | StandardCurveF2 {stdcF_l::BitLength,stdcF_p::F2,stdcF_r::Integer,stdcF_a::Int,stdcF_b::F2,stdcF_xp::F2,stdcF_yp::F2}
    deriving (Typeable)

-- Nist variety Curves over Prime Fields (large characteristic: p)

-- | NIST Prime Curve P-192
p192:: StandardCurve
p192 = StandardCurve {
         stdc_l = 192,
         stdc_p = fpfromInteger 192 6277101735386680763835789423207666416083908700390324961279,
         stdc_r = 6277101735386680763835789423176059013767194773182842284081,
         stdc_b = fpfromInteger 192 2455155546008943817740293915197451784769108058161191238065,
         stdc_xp = fpfromInteger 192 602046282375688656758213480587526111916698976636884684818,
         stdc_yp = fpfromInteger 192 174050332293622031404857552280219410364023488927386650641
       }

-- | NIST Prime Curve P-224
p224:: StandardCurve
p224 = StandardCurve {
         stdc_l = 224,
         stdc_p = fpfromInteger 224 26959946667150639794667015087019630673557916260026308143510066298881,
         stdc_r = 26959946667150639794667015087019625940457807714424391721682722368061,
         stdc_b = fpfromInteger 224 18958286285566608000408668544493926415504680968679321075787234672564,
         stdc_xp = fpfromInteger 224 19277929113566293071110308034699488026831934219452440156649784352033,
         stdc_yp = fpfromInteger 224 19926808758034470970197974370888749184205991990603949537637343198772
       }

-- | NIST Prime Curve P-256
p256:: StandardCurve
p256 = StandardCurve {
         stdc_l = 256,
         stdc_p = fpfromInteger 256 115792089210356248762697446949407573530086143415290314195533631308867097853951,
         stdc_r = 115792089210356248762697446949407573529996955224135760342422259061068512044369,
         stdc_b = fpfromInteger 256 41058363725152142129326129780047268409114441015993725554835256314039467401291,
         stdc_xp = fpfromInteger 256 48439561293906451759052585252797914202762949526041747995844080717082404635286,
         stdc_yp = fpfromInteger 256 36134250956749795798585127919587881956611106672985015071877198253568414405109
       }

-- | NIST Prime Curve P-384
p384:: StandardCurve
p384 = StandardCurve {
         stdc_l = 384,
         stdc_p = fpfromInteger 384 39402006196394479212279040100143613805079739270465446667948293404245721771496870329047266088258938001861606973112319,
         stdc_r = 39402006196394479212279040100143613805079739270465446667946905279627659399113263569398956308152294913554433653942643,
         stdc_b = fpfromInteger 384 27580193559959705877849011840389048093056905856361568521428707301988689241309860865136260764883745107765439761230575,
         stdc_xp = fpfromInteger 384 26247035095799689268623156744566981891852923491109213387815615900925518854738050089022388053975719786650872476732087,
         stdc_yp = fpfromInteger 384 8325710961489029985546751289520108179287853048861315594709205902480503199884419224438643760392947333078086511627871
       }

-- | NIST Prime Curve P-521
p521:: StandardCurve
p521 = StandardCurve {
         stdc_l = 521,
         stdc_p = fpfromInteger 521 6864797660130609714981900799081393217269435300143305409394463459185543183397656052122559640661454554977296311391480858037121987999716643812574028291115057151,
         stdc_r = 6864797660130609714981900799081393217269435300143305409394463459185543183397655394245057746333217197532963996371363321113864768612440380340372808892707005449,
         stdc_b = fpfromInteger 521 1093849038073734274511112390766805569936207598951683748994586394495953116150735016013708737573759623248592132296706313309438452531591012912142327488478985984,
         stdc_xp = fpfromInteger 521 2661740802050217063228768716723360960729859168756973147706671368418802944996427808491545080627771902352094241225065558662157113545570916814161637315895999846,
         stdc_yp = fpfromInteger 521 3757180025770020463545507224491183603594455134769762486694567779615544477440556316691234405012945539562144444537289428522585666729196580810124344277578376784
       }

-- Nist variety Curves over Binary Fields (small characteristic: 2; please refer to the new results of solving the Discrete Logarithm Problem in fields of small characterstic, "Cryptopocalypse", Joux et al.)

-- | NIST Binary Field Curve K-283
k283:: StandardCurve
k283 = StandardCurveF2 {
  stdcF_l = 283,
  stdcF_p = f2fromInteger 283 15541351137805832567355695254588151253139254712417116170014499277911234281641667989665,
  stdcF_r = 3885337784451458141838923813647037813284811733793061324295874997529815829704422603873,
  stdcF_a = 0,
  stdcF_b = f2fromInteger 283 1,
  stdcF_xp = f2fromInteger 283 9737095673315832344313391497449387731784428326114441977662399932694280557468376967222,
  stdcF_yp = f2fromInteger 283 3497201781826516614681192670485202061196189998012192335594744939847890291586353668697
  }

-- | NIST Binary Field Curve B-283
b283:: StandardCurve
b283 = StandardCurveF2 {
  stdcF_l = 283,
  stdcF_p = f2fromInteger 283 15541351137805832567355695254588151253139254712417116170014499277911234281641667989665,
  stdcF_r = 7770675568902916283677847627294075626569625924376904889109196526770044277787378692871,
  stdcF_a = 1,
  stdcF_b = f2fromInteger 283 4821813576056072374006997780399081180312270030300601270120450341205914644378616963829,
  stdcF_xp = f2fromInteger 283 11604587487407003699882500449177537465719784002620028212980871291231978603047872962643,
  stdcF_yp = f2fromInteger 283 6612720053854191978412609357563545875491153188501906352980899759345275170452624446196
  }
