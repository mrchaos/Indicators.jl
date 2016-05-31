VERSION >= v"0.4.0" && __precompile__(true)

module Indicators

export
    runmean, runsum, runvar, runsd, runcov, runcor, runmax, runmin, runmad,
    wilder_sum, mode, diffn, lag,
    sma, trima, wma, ema, kama, mama, hma, swma, dema, tema, alma,
    mlr_beta, mlr_slope, mlr_intercept, mlr, mlr_se, mlr_ub, mlr_lb, mlr_bands, mlr_rsq,
    momentum, roc, macd, rsi, adx, psar, kst, wpr, cci, stoch, smi,
    bbands, tr, atr, keltner

include("run.jl")
include("ma.jl")
include("reg.jl")
include("mom.jl")
include("vol.jl")

# pkglist(dir::AbstractString=Pkg.dir()) = setdiff(readdir(dir), [".cache","METADATA","META_BRANCH","REQUIRE"])
# isinstalled(pkg::AbstractString; dir::AbstractString=Pkg.dir()) = pkg in pkglist(dir)
# if isinstalled("Temporal")
#     using Temporal
#     include("temporal.jl")
# end

end
