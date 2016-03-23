VERSION >= v"0.4.0" && __precompile__(true)

module Indicators

export
    runmean, runsum, runvar, runsd, runcov, runmax, runmin, runmad,
    wilder_sum, mode, diffn, lag,
    sma, trima, wma, ema, kama, mama, hma, swma, dema, tema,
    roc, macd, rsi, adx, psar,
    bbands, tr, atr, keltner

include("run.jl")
include("ma.jl")
include("mom.jl")
include("vol.jl")

end
