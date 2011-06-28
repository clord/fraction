module Main where
import Data.Ratio

type Row = (Integer, Integer)
type Matrix = (Row, Row)

calc v ((a, b), (c, d)) = ((a * (truncate v) + b, a),
                           (c * (truncate v) + d, c))

num = fst . fst
den = fst . snd

frac d = d - ((fromInteger . truncate) d)


fraction' :: Double -> Matrix -> [Matrix]
fraction' value a | (abs . frac) value < 1.0e-5 = [calc value a]
fraction' value a = a : fraction' (1.0 / (frac value)) (calc value a)


deconstruct :: Double -> Matrix -> (Rational,Double)
deconstruct value matrix = (ratio, ((fromRational ratio) - value))
                      where ratio = (num matrix) % (den matrix)

initial = ((1,0),(0,1))

fraction :: Double -> [(Rational, Double)]
fraction value = map (deconstruct value) $
                   filter ((0 /=) . den) $
                   takeWhile ((32 >) . den) $
                   fraction' value initial




-- Test it out
main = putStrLn $ show $ fraction 0.4389756
