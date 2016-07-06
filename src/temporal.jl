# Methods for porting Indicators.jl functions to TS objects from Temporal.jl package

###### run.jl ######
mode{V}(x::TS{V}) = mode(x.values)
runmean{V,T}(x::TS{V,T}, n::Int64=10, cumulative::Bool=true) = ts(runmean(x.values, n, cumulative), x.index, :RunMean)
runsum{V,T}(x::TS{V,T}, n::Int64=10, cumulative::Bool=true) = ts(runsum(x.values, n, cumulative), x.index, :RunSum)
runmad{V,T}(x::TS{V,T}, n::Int64=10, cumulative::Bool=true) = ts(runmad(x.values, n, cumulative), x.index, :RunMAD)
runvar{V,T}(x::TS{V,T}, n::Int64=10, cumulative::Bool=true) = ts(runvar(x.values, n, cumulative), x.index, :RunVar)
runmax{V,T}(x::TS{V,T}, n::Int64=10, cumulative::Bool=true) = ts(runmax(x.values, n, cumulative), x.index, :RunMax)
runmin{V,T}(x::TS{V,T}, n::Int64=10, cumulative::Bool=true) = ts(runmin(x.values, n, cumulative), x.index, :RunMin)
runsd{V,T}(x::TS{V,T}, n::Int64=10, cumulative::Bool=true) = ts(runsd(x.values, n, cumulative), x.index, :RunSD)
wilder_sum{V,T}(x::TS{V,T}, n::Int64=10) = ts(runsum(x.values, n), x.index, :WilderSum)
function runcov{V,T}(x::TS{V,T}, y::TS{V,T}, n::Int64=10, cumulative::Bool=true)
    @assert size(x,2) == 1 || size(y,2) == 1 "Arguments x and y must both be univariate (have only one column)."
    z = [x y]
    return ts(runcov(z[:,1], z[:,2], n, cumulative), x.index, :RunCov)
end
function runcor{V,T}(x::TS{V,T}, y::TS{V,T}, n::Int64=10, cumulative::Bool=true)
    @assert size(x,2) == 1 || size(y,2) == 1 "Arguments x and y must both be univariate (have only one column)."
    z = [x y]
    ts(runcor(z[:,1], z[:,2], n, cumulative), x.index, :RunCor)
end

##### ma.jl ######
sma{V,T}(x::TS{V,T}, n::Int64=10) = ts(sma(x.values, n), x.index, :SMA)
hma{V,T}(x::TS{V,T}, n::Int64=10) = ts(hma(x.values, n), x.index, :HMA)
mma{V,T}(x::TS{V,T}, n::Int64=10) = ts(mma(x.values, n), x.index, :MMA)
swma{V,T}(x::TS{V,T}, n::Int64=10) = ts(swma(x.values, n), x.index, :SWMA)
kama{V,T}(x::TS{V,T}, n::Int64=10, nfast::Float64=0.6667, nslow::Float64=0.0645) = ts(kama(x.values, n, nfast, nslow), x.index, :KAMA)
alma{V,T}(x::TS{V,T}, n::Int64=9, offset::Float64=0.85, sigma::Float64=6.0) = ts(kama(x.values, n, offset, sigma), x.index, :ALMA)
trima{V,T}(x::TS{V,T}, n::Int64=10; args...) = ts(trima(x.values, n; args...), x.index, :TRIMA)
wma{V,T}(x::TS{V,T}, n::Int64=10; args...) = ts(wma(x.values, n; args...), x.index, :WMA)
ema{V,T}(x::TS{V,T}, n::Int64=10; args...) = ts(ema(x.values, n; args...), x.index, :EMA)
dema{V,T}(x::TS{V,T}, n::Int64=10; args...) = ts(dema(x.values, n; args...), x.index, :DEMA)
tema{V,T}(x::TS{V,T}, n::Int64=10; args...) = ts(tema(x.values, n; args...), x.index, :TEMA)
mama{V,T}(x::TS{V,T}, fastlimit::Float64=0.5, slowlimit::Float64=0.05) = ts(mama(x.values, fastlimit, slowlimit), x.index, [:MAMA, :FAMA])

##### reg.jl ######
mlr_beta{V,T}(y::TS{V,T}, n::Int64=10) = ts(mlr_beta(y.values, n), y.index, :Beta)
mlr_slope{V,T}(y::TS{V,T}, n::Int64=10) = ts(mlr_slope(y.values, n), y.index, :Slope)
mlr_intercept{V,T}(y::TS{V,T}, n::Int64=10) = ts(mlr_intercept(y.values, n), y.index, :Intercept)
mlr{V,T}(y::TS{V,T}, n::Int64=10) = ts(mlr(y.values, n), y.index, :MLR)
mlr_se{V,T}(y::TS{V,T}, n::Int64=10) = ts(mlr_se(y.values, n), y.index, :StdErr)
mlr_ub{V,T}(y::TS{V,T}, n::Int64=10, se::Float64=2.0) = ts(mlr_ub(y.values, n, se), y.index, :UB)
mlr_lb{V,T}(y::TS{V,T}, n::Int64=10, se::Float64=2.0) = ts(mlr_lb(y.values, n, se), y.index, :LB)
mlr_bands{V,T}(y::TS{V,T}, n::Int64=10, se::Float64=2.0) = ts(mlr_bands(y.values, n, se), y.index, [:LB, :MLR, :UB])
mlr_rsq{V,T}(y::TS{V,T}, n::Int64=10) = ts(mlr_rsq(y.values, n), y.index, :RSquared)

##### mom.jl ######
momentum{V,T}(x::TS{V,T}, n::Int64=1) = ts(momentum(x.values, n), x.index, :Momentum)
roc{V,T}(x::TS{V,T}, n::Int64=1) = ts(roc(x.values, n), x.index, :ROC)
macd{V,T}(x::TS{V,T}, nfast::Int64=12, nslow::Int64=26, nsig::Int64=9; args...) = ts(macd(x.values, nfast, nslow, nsig; args...), x.index, [:MACD, :Signal, :Histogram])
rsi{V,T}(x::TS{V,T}, n::Int64=10; args...) = ts(rsi(x.values, n; args...), x.index, :RSI)
adx{V,T}(hlc::TS{V,T}, n::Int64=10; args...) = ts(adx(hlc.values, n; args...), hlc.index, [:DiPlus, :DiMinus, :ADX])
psar{V,T}(x::TS{V,T}, af::Float64=0.02, af_max::Float64=0.2, af_min::Float64=0.02) = ts(psar(x.values, af, af_max, af_min), x.index, :SMA)
kst{V,T}(x::TS{V,T}, nroc::Vector{Int64}=[10,15,20,30], navg::Vector{Int64}=[10,10,10,15]; args...) = ts(kst(x.values, nroc, navg; args...), x.index, :KST)
wpr{V,T}(hlc::TS{V,T}, n::Int64=14) = ts(wpr(hlc.values, n), hlc.index, :WPR)
cci{V,T}(hlc::TS{V,T}, n::Int64=20, c::Float64=0.015; args...) = ts(cci(hlc.values, n, c; args...), hlc.index, :WPR)
stoch{V,T}(hlc::TS{V,T}, nK::Int64=14, nD::Int64=3; args...) = ts(stoch(hlc.values, nK, nD; args...), hlc.index, [:Stochastic, :Signal])
smi{V,T}(hlc::TS{V,T}, n::Int64=13, nFast::Int64=2, nSlow::Int64=25, nSig::Int64=9; args...) = ts(smi(hlc.values, n, nFast, nSlow, nSig; args...), hlc.index, [:SMI, :Signal])

##### vol.jl ######
bbands{V,T}(x::TS{V,T}, n::Int64=10, sigma::Float64=2.0; args...) = ts(bbands(x.values, n, sigma; args...), x.index, [:LB, :MA, :UB])
tr{V,T}(x::TS{V,T}, n::Int64=2) = ts(tr(x.values, n), x.index, :TR)
atr{V,T}(x::TS{V,T}, n::Int64=14) = ts(atr(x.values, n), x.index, :ATR)
keltner{V,T}(hlc::TS{V,T}, nema::Int64=20, natr::Int64=10, mult::Int64=2) = ts(keltner(hlc.values, nema, natr, mult), hlc.index, [:LB, :MA, :UB])

##### trendy.jl #####
maxlocal{V,T}(x::TS{V,T}; args...) = ts(maxlocal(x.values; args...), x.index, :Peaks)
minlocal{V,T}(x::TS{V,T}; args...) = ts(minlocal(x.values; args...), x.index, :Valleys)
support{V,T}(x::TS{V,T}; args...) = ts(support(x.values; args...), x.index, :Support)
resistance{V,T}(x::TS{V,T}; args...) = ts(resistance(x.values; args...), x.index, :Resistance)
