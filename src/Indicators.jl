VERSION >= v"0.4.0" && __precompile__(true)

module Indicators

export
    runmean, runsum, wilder_sum, runvar, runsd, runcov, runmax, runmin, runmad, mode,
    sma, trima, wma, ema, mama, hma, swma, dema, tema,
    macd, rsi, adx, psar,
    bbands, tr, atr, keltner

include("run.jl")
include("ma.jl")
include("mom.jl")
include("vol.jl")

end
