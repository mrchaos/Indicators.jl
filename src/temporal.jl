# Methods for porting Indicators.jl functions to TS objects from Temporal.jl package

###### run.jl ######
mode{V}(x::TS{V}) = mode(x.values)
runmean{V,T}(x::TS{V,T}; args...) = ts(runmean(x.values; args...), x.index, :RunMean)
runsum{V,T}(x::TS{V,T}; args...) = ts(runsum(x.values; args...), x.index, :RunSum)
runmad{V,T}(x::TS{V,T}; args...) = ts(runmad(x.values; args...), x.index, :RunMAD)
runvar{V,T}(x::TS{V,T}; args...) = ts(runvar(x.values; args...), x.index, :RunVar)
runmax{V,T}(x::TS{V,T}; args...) = ts(runmax(x.values; args...), x.index, :RunMax)
runmin{V,T}(x::TS{V,T}; args...) = ts(runmin(x.values; args...), x.index, :RunMin)
runsd{V,T}(x::TS{V,T}; args...) = ts(runsd(x.values; args...), x.index, :RunSD)
wilder_sum{V,T}(x::TS{V,T}; args...) = ts(runsum(x.values; args...), x.index, :WilderSum)
function runcov{V,T}(x::TS{V,T}, y::TS{V,T}; args...)
    @assert size(x,2) == 1 || size(y,2) == 1 "Arguments x and y must both be univariate (have only one column)."
    z = [x y]
    return ts(runcov(z[:,1], z[:,2], n, cumulative), x.index, :RunCov)
end
function runcor{V,T}(x::TS{V,T}, y::TS{V,T}; args...)
    @assert size(x,2) == 1 || size(y,2) == 1 "Arguments x and y must both be univariate (have only one column)."
    z = [x y]
    ts(runcor(z[:,1], z[:,2], n, cumulative), x.index, :RunCor)
end

##### ma.jl ######
sma{V,T}(x::TS{V,T}; args...) = ts(sma(x.values; args...), x.index, :SMA)
hma{V,T}(x::TS{V,T}; args...) = ts(hma(x.values; args...), x.index, :HMA)
mma{V,T}(x::TS{V,T}; args...) = ts(mma(x.values; args...), x.index, :MMA)
swma{V,T}(x::TS{V,T}; args...) = ts(swma(x.values; args...), x.index, :SWMA)
kama{V,T}(x::TS{V,T}; args...) = ts(kama(x.values; args...), x.index, :KAMA)
alma{V,T}(x::TS{V,T}; args...) = ts(kama(x.values; args...), x.index, :ALMA)
trima{V,T}(x::TS{V,T}; args...) = ts(trima(x.values; args...), x.index, :TRIMA)
wma{V,T}(x::TS{V,T}; args...) = ts(wma(x.values; args...), x.index, :WMA)
ema{V,T}(x::TS{V,T}; args...) = ts(ema(x.values; args...), x.index, :EMA)
dema{V,T}(x::TS{V,T}; args...) = ts(dema(x.values; args...), x.index, :DEMA)
tema{V,T}(x::TS{V,T}; args...) = ts(tema(x.values; args...), x.index, :TEMA)
mama{V,T}(x::TS{V,T}; args...) = ts(mama(x.values; args...), x.index, [:MAMA, :FAMA])

##### reg.jl ######
mlr_beta{V,T}(y::TS{V,T}; args...) = ts(mlr_beta(y.values; args...), y.index, [:Intercept, :Slope])
mlr_slope{V,T}(y::TS{V,T}; args...) = ts(mlr_slope(y.values; args...), y.index, :Slope)
mlr_intercept{V,T}(y::TS{V,T}; args...) = ts(mlr_intercept(y.values; args...), y.index, :Intercept)
mlr{V,T}(y::TS{V,T}; args...) = ts(mlr(y.values; args...), y.index, :MLR)
mlr_se{V,T}(y::TS{V,T}; args...) = ts(mlr_se(y.values; args...), y.index, :StdErr)
mlr_ub{V,T}(y::TS{V,T}; args...) = ts(mlr_ub(y.values; args...), y.index, :UB)
mlr_lb{V,T}(y::TS{V,T}; args...) = ts(mlr_lb(y.values; args...), y.index, :LB)
mlr_bands{V,T}(y::TS{V,T}; args...) = ts(mlr_bands(y.values; args...), y.index, [:LB, :MLR, :UB])
mlr_rsq{V,T}(y::TS{V,T}; args...) = ts(mlr_rsq(y.values; args...), y.index, :RSquared)

##### mom.jl ######
momentum{V,T}(x::TS{V,T}; args...) = ts(momentum(x.values; args...), x.index, :Momentum)
roc{V,T}(x::TS{V,T}; args...) = ts(roc(x.values; args...), x.index, :ROC)
macd{V,T}(x::TS{V,T}; args...) = ts(macd(x.values; args...), x.index, [:MACD, :Signal, :Histogram])
rsi{V,T}(x::TS{V,T}; args...) = ts(rsi(x.values; args...), x.index, :RSI)
adx{V,T}(hlc::TS{V,T}; args...) = ts(adx(hlc.values; args...), hlc.index, [:DiPlus, :DiMinus, :ADX])
psar{V,T}(x::TS{V,T}; args...) = ts(psar(x.values; args...), x.index, :PSAR)
kst{V,T}(x::TS{V,T}; args...) = ts(kst(x.values; args...), x.index, :KST)
wpr{V,T}(hlc::TS{V,T}; args...) = ts(wpr(hlc.values; args...), hlc.index, :WPR)
cci{V,T}(hlc::TS{V,T}; args...) = ts(cci(hlc.values; args...), hlc.index, :CCI)
stoch{V,T}(hlc::TS{V,T}; args...) = ts(stoch(hlc.values; args...), hlc.index, [:Stochastic, :Signal])
smi{V,T}(hlc::TS{V,T}; args...) = ts(smi(hlc.values; args...), hlc.index, [:SMI, :Signal])

##### vol.jl ######
bbands{V,T}(x::TS{V,T}; args...) = ts(bbands(x.values; args...), x.index, [:LB, :MA, :UB])
tr{V,T}(hlc::TS{V,T}; args...) = ts(tr(hlc.values; args...), hlc.index, :TR)
atr{V,T}(hlc::TS{V,T}; args...) = ts(atr(hlc.values; args...), hlc.index, :ATR)
keltner{V,T}(hlc::TS{V,T}; args...) = ts(keltner(hlc.values; args...), hlc.index, [:LB, :MA, :UB])

##### trendy.jl #####
maxima{V,T}(x::TS{V,T}; args...) = ts(maxima(x.values; args...), x.index, :Maxima)
minima{V,T}(x::TS{V,T}; args...) = ts(minima(x.values; args...), x.index, :Minima)
support{V,T}(x::TS{V,T}; args...) = ts(support(x.values; args...), x.index, :Support)
resistance{V,T}(x::TS{V,T}; args...) = ts(resistance(x.values; args...), x.index, :Resistance)
