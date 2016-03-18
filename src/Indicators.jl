VERSION >= v"0.4.0" && __precompile__(true)

module Indicators

export
    runmean, runsum, wilder_sum, runvar, runsd, runcov,
    sma, trima, wma, ema, mama, hma, swma, dema, tema,
    macd, rsi, adx,
    bbands, tr, atr, keltner

include("ma.jl")
include("mom.jl")
include("vol.jl")

end 
