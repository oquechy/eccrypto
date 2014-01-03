-----------------------------------------------------------------------------
-- |
-- Module      :  
-- Copyright   :  (c) Marcel Fourné 20[09..14]
-- License     :  BSD3
-- Maintainer  :  Marcel Fourné (mail@marcelfourne.de)
--
-- benchmarks
-- recommended:
-- $ ghc --make -threaded bench.hs
-- best performance measured with just 1 thread
--
-----------------------------------------------------------------------------
{-# OPTIONS_GHC -O2 -fllvm -optlo-O3 -feager-blackholing #-}

import Crypto.ECC.NIST.Base
import Crypto.ECC.NIST.StandardCurves
import Control.Monad.Random
import Criterion
import Criterion.Main
import qualified Data.F2 as F2

testfkt:: EC Integer -> ECPF Integer -> Integer -> Int -> ECPF Integer
testfkt c b k' n  = pmul c b ((toInteger (n-n)) + k')

testfktF2:: EC F2.F2 -> ECPF F2.F2 -> Integer -> Int -> ECPF F2.F2
testfktF2 c b k' n  = pmul c b ((toInteger (n-n)) + k')



main::IO ()
main = do
  let c1 = ECi (stdc_l p256) (stdc_a p256) (stdc_b p256) (stdc_p p256) (stdc_r p256)
      p1 = ECPp  (stdc_xp p256) (stdc_yp p256) 1
      k10' = 78260987815077071890976764339238653408132491773166348437934213365482899760747
      k11' = 2^254+2^253+2^252+2^251+2^250+2^249
      k12' = 2^254+2^200+2^150+2^100+2^50+1
      c2 = ECi (stdc_l p521) (stdc_a p521) (stdc_b p521) (stdc_p p521) (stdc_r p521)
      p2 = ECPp (stdc_xp p521) (stdc_yp p521) 1
      k20' = 1093849038073734274511112390766805569936207598951683748994586394495953116150735016013708737573759623248592132296706313309438452531591012912142327488478985984
      c3 = ECb (stdcF_l b283) (stdcF_a b283) (stdcF_b b283) (stdcF_p b283) (stdcF_r b283)
      p3 = ECPpF2 (stdcF_xp b283) (stdcF_yp b283) (fromInteger 1)
      k30' = 115792089210356248762697446949407573529996955224135760342422259061068512044368
      k31' = 2
      k32' = 3
      k33' = 2^282
  k13' <- evalRandIO $ getRandomR (1,stdc_p p256)
  k21' <- evalRandIO $ getRandomR (1,stdc_p p521)
  k34' <- evalRandIO $ getRandomR (1, F2.toInteger $ stdcF_p b283)
  defaultMain [ bench "NIST P-256" $ whnf (testfkt c1 p1 k13') 10
              , bench "NIST P-521" $ whnf (testfkt c2 p2 k21') 10
--              , bench "NIST B-283" $ whnf (testfktF2 c3 p3 k34') 10
              ]
