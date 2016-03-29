VERSION >= v"0.4.0" && __precompile__(true)

module Indicators

export
    runmean, runsum, runvar, runsd, runcov, runcor, runmax, runmin, runmad,
    wilder_sum, mode, diffn, lag,
    sma, trima, wma, ema, kama, mama, hma, swma, dema, tema, alma,
    mlr_beta, mlr_slope, mlr_intercept, mlr, mlr_se, mlr_ub, mlr_lb, mlr_bands, mlr_rsq,
    roc, macd, rsi, adx, psar, kst, wpr, cci,
    bbands, tr, atr, keltner

include("run.jl")
include("ma.jl")
include("reg.jl")
include("mom.jl")
include("vol.jl")

end
