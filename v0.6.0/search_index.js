var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "#Indicators.jl-1",
    "page": "Home",
    "title": "Indicators.jl",
    "category": "section",
    "text": "Indicators is a Julia package offering efficient implementations of many technical analysis indicators and algorithms. This work is inspired by the TTR package in R and the Python implementation of TA-Lib, and the ultimate goal is to implement all of the functionality of these offerings (and more) in Julia. This package has been written to be able to interface with both native Julia Array types, as well as the TS time series type from the Temporal package. Contributions are of course always welcome for wrapping any of these functions in methods for other types and/or packages out there, as are suggestions for other indicators to add to the lists below."
},

{
    "location": "ma/#",
    "page": "Moving Averages",
    "title": "Moving Averages",
    "category": "page",
    "text": ""
},

{
    "location": "ma/#Moving-Averages-1",
    "page": "Moving Averages",
    "title": "Moving Averages",
    "category": "section",
    "text": ""
},

{
    "location": "ma/#Example-1",
    "page": "Moving Averages",
    "title": "Example",
    "category": "section",
    "text": "using Temporal, Indicators, Plots\nX = quandl(\"CHRIS/CME_CL1\", rows=252, sort=\'d\')\nx = cl(X)\nx.fields[1] = :Crude\n\nmafuns = [sma, ema, wma, trima]\nm = hcat([f(x, n=40) for f in mafuns]...)\n\nplot(x, linewidth=3, color=:black)\nplot!(m, linewidth=2)\nsavefig(\"ma_example.svg\")  # hide(Image: )"
},

{
    "location": "ma/#Indicators.alma-Tuple{Array{Float64,N} where N}",
    "page": "Moving Averages",
    "title": "Indicators.alma",
    "category": "method",
    "text": "alma{Float64}(x::Array{Float64}; n::Int64=9, offset::Float64=0.85, sigma::Float64=6.0)::Array{Float64}\n\nArnaud-Legoux moving average (ALMA)\n\n\n\n\n\n"
},

{
    "location": "ma/#Indicators.dema-Tuple{Array{Float64,N} where N}",
    "page": "Moving Averages",
    "title": "Indicators.dema",
    "category": "method",
    "text": "dema(x::Array{Float64}; n::Int64=10, alpha=2.0/(n+1), wilder::Bool=false)::Array{Float64}\n\nDouble exponential moving average (DEMA)\n\n\n\n\n\n"
},

{
    "location": "ma/#Indicators.ema-Tuple{Array{Float64,N} where N}",
    "page": "Moving Averages",
    "title": "Indicators.ema",
    "category": "method",
    "text": "ema(x::Array{Float64}; n::Int64=10, alpha::Float64=2.0/(n+1.0), wilder::Bool=false)::Array{Float64}\n\nExponential moving average (EMA)\n\n\n\n\n\n"
},

{
    "location": "ma/#Indicators.hma-Tuple{Array{Float64,N} where N}",
    "page": "Moving Averages",
    "title": "Indicators.hma",
    "category": "method",
    "text": "hma(x::Array{Float64}; n::Int64=20)::Array{Float64}\n\nHull moving average (HMA)\n\n\n\n\n\n"
},

{
    "location": "ma/#Indicators.kama-Tuple{Array{Float64,N} where N}",
    "page": "Moving Averages",
    "title": "Indicators.kama",
    "category": "method",
    "text": "Kaufman adaptive moving average (KAMA)\n\n\n\n\n\n"
},

{
    "location": "ma/#Indicators.mama-Tuple{Array{Float64,N} where N}",
    "page": "Moving Averages",
    "title": "Indicators.mama",
    "category": "method",
    "text": "mama(x::Array{Float64}; fastlimit::Float64=0.5, slowlimit::Float64=0.05)::Matrix{Float64}\n\nMESA adaptive moving average (MAMA)\n\n\n\n\n\n"
},

{
    "location": "ma/#Indicators.mma-Tuple{Array{Float64,N} where N}",
    "page": "Moving Averages",
    "title": "Indicators.mma",
    "category": "method",
    "text": "mma(x::Array{Float64}; n::Int64=10)::Array{Float64}\n\nModified moving average (MMA)\n\n\n\n\n\n"
},

{
    "location": "ma/#Indicators.sma-Tuple{Array{Float64,N} where N}",
    "page": "Moving Averages",
    "title": "Indicators.sma",
    "category": "method",
    "text": "sma(x::Array{Float64}; n::Int64=10)::Array{Float64}\n\nSimple moving average (SMA)\n\n\n\n\n\n"
},

{
    "location": "ma/#Indicators.swma-Tuple{Array{Float64,N} where N}",
    "page": "Moving Averages",
    "title": "Indicators.swma",
    "category": "method",
    "text": "Sine-weighted moving average\n\n\n\n\n\n"
},

{
    "location": "ma/#Indicators.tema-Tuple{Array{Float64,N} where N}",
    "page": "Moving Averages",
    "title": "Indicators.tema",
    "category": "method",
    "text": "tema(x::Array{Float64}; n::Int64=10, alpha=2.0/(n+1), wilder::Bool=false)::Array{Float64}\n\nTriple exponential moving average (TEMA)\n\n\n\n\n\n"
},

{
    "location": "ma/#Indicators.trima-Tuple{Array{Float64,N} where N}",
    "page": "Moving Averages",
    "title": "Indicators.trima",
    "category": "method",
    "text": "trima(x::Array{Float64}; n::Int64=10, ma::Function=sma, args...)::Array{Float64}\n\nTriangular moving average (TRIMA)\n\n\n\n\n\n"
},

{
    "location": "ma/#Indicators.wma-Tuple{Array{Float64,N} where N}",
    "page": "Moving Averages",
    "title": "Indicators.wma",
    "category": "method",
    "text": "wma(x::Array{Float64}; n::Int64=10, wts::Array{Float64}=collect(1:n)/sum(1:n))::Array{Float64}\n\nWeighted moving average (WMA)\n\n\n\n\n\n"
},

{
    "location": "ma/#Indicators.zlema-Tuple{Array{Float64,N} where N}",
    "page": "Moving Averages",
    "title": "Indicators.zlema",
    "category": "method",
    "text": "zlema(x::Array{Float64}; n::Int=10, ema_args...)::Array{Float64}\n\nZero-lag exponential moving average (ZLEMA)\n\n\n\n\n\n"
},

{
    "location": "ma/#Reference-1",
    "page": "Moving Averages",
    "title": "Reference",
    "category": "section",
    "text": "Modules = [Indicators]\nPages = [\"ma.jl\"]"
},

{
    "location": "mom/#",
    "page": "Momentum Indicators",
    "title": "Momentum Indicators",
    "category": "page",
    "text": ""
},

{
    "location": "mom/#Momentum-Indicators-1",
    "page": "Momentum Indicators",
    "title": "Momentum Indicators",
    "category": "section",
    "text": ""
},

{
    "location": "mom/#Example-1",
    "page": "Momentum Indicators",
    "title": "Example",
    "category": "section",
    "text": "using Temporal, Indicators, Plots\nX = quandl(\"CHRIS/CME_CL1\", rows=252, sort=\'d\')\nx = cl(X)\nx.fields[1] = :Crude\n\nm = macd(x)\nr = rsi(x)\np = psar(hl(X))\n\nf1 = plot(x, linewidth=3, color=:black)\nscatter!(p, color=:blue, markersize=2)\nf2 = plot(m, linewidth=2, color=[:green :cyan :orange])\nhline!([0.0], linestyle=:dash, color=:grey, label=\"\")\nf3 = plot(r, linewidth=2, color=:gold)\nhline!([20, 80], linestyle=:dot, color=[:green, :red], label=\"\")\nplot(f1, f2, f3, layout=@layout[a{0.6h}; b{0.2h}; c{0.2h}])\nsavefig(\"mom_example.svg\")  # hide(Image: )"
},

{
    "location": "mom/#Indicators.adx-Tuple{Array{Float64,N} where N}",
    "page": "Momentum Indicators",
    "title": "Indicators.adx",
    "category": "method",
    "text": "adx(hlc::Array{Float64}; n::Int64=14, wilder=true)::Array{Float64}\n\nAverage directional index\n\nOutput\n\nColumn 1: DI+\nColumn 2: DI-\nColumn 3: ADX\n\n\n\n\n\n"
},

{
    "location": "mom/#Indicators.aroon-Tuple{Array{Float64,2}}",
    "page": "Momentum Indicators",
    "title": "Indicators.aroon",
    "category": "method",
    "text": "aroon(hl::Array{Float64,2}; n::Int64=25)::Array{Float64}\n\nAroon up/down/oscillator\n\nOutput\n\nColumn 1: Aroon Up\nColumn 2: Aroon Down\nColumn 3: Aroon Oscillator\n\n\n\n\n\n"
},

{
    "location": "mom/#Indicators.cci-Tuple{Array{Float64,2}}",
    "page": "Momentum Indicators",
    "title": "Indicators.cci",
    "category": "method",
    "text": "cci(hlc::Array{Float64,2}; n::Int64=20, c::Float64=0.015, ma::Function=sma)::Array{Float64}\n\nCommodity channel index\n\n\n\n\n\n"
},

{
    "location": "mom/#Indicators.donch-Tuple{Array{Float64,2}}",
    "page": "Momentum Indicators",
    "title": "Indicators.donch",
    "category": "method",
    "text": "donch(hl::Array{Float64,2}; n::Int64=10, inclusive::Bool=true)::Array{Float64}\n\nDonchian channel (if inclusive is set to true, will include current bar in calculations.)\n\nOutput\n\nColumn 1: Lowest low of last n periods\nColumn 2: Average of highest high and lowest low of last n periods\nColumn 3: Highest high of last n periods\n\n\n\n\n\n"
},

{
    "location": "mom/#Indicators.kst-Tuple{Array{Float64,N} where N}",
    "page": "Momentum Indicators",
    "title": "Indicators.kst",
    "category": "method",
    "text": "kst(x::Array{Float64};\n    nroc::Array{Int64}=[10,15,20,30], navg::Array{Int64}=[10,10,10,15],\n    wgts::Array{Int64}=collect(1:length(nroc)), ma::Function=sma)::Array{Float64}\n\n\nKST (Know Sure Thing) – smoothed and summed rates of change\n\n\n\n\n\n"
},

{
    "location": "mom/#Indicators.macd-Tuple{Array{Float64,N} where N}",
    "page": "Momentum Indicators",
    "title": "Indicators.macd",
    "category": "method",
    "text": "macd(x::Array{Float64}; nfast::Int64=12, nslow::Int64=26, nsig::Int64=9)::Array{Float64}\n\nMoving average convergence-divergence\n\nOutput\n\nColumn 1: MACD\nColumn 2: MACD Signal Line\nColumn 3: MACD Histogram\n\n\n\n\n\n"
},

{
    "location": "mom/#Indicators.momentum-Tuple{Array{Float64,N} where N}",
    "page": "Momentum Indicators",
    "title": "Indicators.momentum",
    "category": "method",
    "text": "momentum(x::Array{Float64}; n::Int64=1)::Array{Float64}\n\nMomentum indicator (price now vs price n periods back)\n\n\n\n\n\n"
},

{
    "location": "mom/#Indicators.psar-Tuple{Array{Float64,N} where N}",
    "page": "Momentum Indicators",
    "title": "Indicators.psar",
    "category": "method",
    "text": "psar(hl::Array{Float64}; af_min::Float64=0.02, af_max::Float64=0.2, af_inc::Float64=af_min)::Array{Float64}\n\nParabolic stop and reverse (SAR)\n\nArguments\n\nhl: 2D array of high and low prices in first and second columns respectively\naf_min: starting/initial value for acceleration factor\naf_max: maximum acceleration factor (accel factor capped at this value)\naf_inc: increment to the acceleration factor (speed of increase in accel factor)\n\n\n\n\n\n"
},

{
    "location": "mom/#Indicators.roc-Tuple{Array{Float64,N} where N}",
    "page": "Momentum Indicators",
    "title": "Indicators.roc",
    "category": "method",
    "text": "roc(x::Array{Float64}; n::Int64=1)::Array{Float64}\n\nRate of change indicator (percent change between i\'th observation and (i-n)\'th observation)\n\n\n\n\n\n"
},

{
    "location": "mom/#Indicators.rsi-Tuple{Array{Float64,N} where N}",
    "page": "Momentum Indicators",
    "title": "Indicators.rsi",
    "category": "method",
    "text": "rsi(x::Array{Float64}; n::Int64=14, ma::Function=ema, args...)::Array{Float64}\n\nRelative strength index\n\n\n\n\n\n"
},

{
    "location": "mom/#Indicators.smi-Tuple{Array{Float64,2}}",
    "page": "Momentum Indicators",
    "title": "Indicators.smi",
    "category": "method",
    "text": "smi(hlc::Array{Float64,2}; n::Int64=13, nFast::Int64=2, nSlow::Int64=25, nSig::Int64=9,\n    maFast::Function=ema, maSlow::Function=ema, maSig::Function=sma)::Matrix{Float64}\n\nSMI (stochastic momentum oscillator)\n\n\n\n\n\n"
},

{
    "location": "mom/#Indicators.stoch-Tuple{Array{Float64,2}}",
    "page": "Momentum Indicators",
    "title": "Indicators.stoch",
    "category": "method",
    "text": "stoch(hlc::Array{Float64,2}; nK::Int64=14, nD::Int64=3, kind::Symbol=:fast, ma::Function=sma, args...)::Matrix{Float64}\n\nStochastic oscillator (fast or slow)\n\n\n\n\n\n"
},

{
    "location": "mom/#Indicators.wpr-Tuple{Array{Float64,2}}",
    "page": "Momentum Indicators",
    "title": "Indicators.wpr",
    "category": "method",
    "text": "wpr(hlc::Array{Float64,2}, n::Int64=14)::Array{Float64}\n\nWilliams %R\n\n\n\n\n\n"
},

{
    "location": "mom/#Reference-1",
    "page": "Momentum Indicators",
    "title": "Reference",
    "category": "section",
    "text": "Modules = [Indicators]\nPages = [\"mom.jl\"]"
},

{
    "location": "vol/#",
    "page": "Volatility Indicators",
    "title": "Volatility Indicators",
    "category": "page",
    "text": ""
},

{
    "location": "vol/#Volatility-Indicators-1",
    "page": "Volatility Indicators",
    "title": "Volatility Indicators",
    "category": "section",
    "text": ""
},

{
    "location": "vol/#Indicators.atr-Tuple{Array{Float64,2}}",
    "page": "Volatility Indicators",
    "title": "Indicators.atr",
    "category": "method",
    "text": "atr(hlc::Matrix{Float64}; n::Int64=14)::Array{Float64}\n\nAverage true range (uses exponential moving average)\n\n\n\n\n\n"
},

{
    "location": "vol/#Indicators.bbands-Tuple{Array{Float64,N} where N}",
    "page": "Volatility Indicators",
    "title": "Indicators.bbands",
    "category": "method",
    "text": "bbands(x::Array{Float64}; n::Int64=10, sigma::Float64=2.0)::Matrix{Float64}\n\nBollinger bands (moving average with standard deviation bands)\n\nOutput\n\nColumn 1: lower band\nColumn 2: middle band\nColumn 3: upper band\n\n\n\n\n\n"
},

{
    "location": "vol/#Indicators.keltner-Tuple{Array{Float64,2}}",
    "page": "Volatility Indicators",
    "title": "Indicators.keltner",
    "category": "method",
    "text": "keltner(hlc::Matrix{Float64}; nema::Int64=20, natr::Int64=10, mult::Int64=2)::Matrix{Float64}\n\nKeltner bands\n\nOutput Column 1: lower band Column 2: middle band Column 3: upper band\n\n\n\n\n\n"
},

{
    "location": "vol/#Indicators.tr-Tuple{Array{Float64,2}}",
    "page": "Volatility Indicators",
    "title": "Indicators.tr",
    "category": "method",
    "text": "tr(hlc::Matrix{Float64})::Array{Float64}\n\nTrue range\n\n\n\n\n\n"
},

{
    "location": "vol/#Reference-1",
    "page": "Volatility Indicators",
    "title": "Reference",
    "category": "section",
    "text": "Modules = [Indicators]\nPages = [\"vol.jl\"]"
},

{
    "location": "reg/#",
    "page": "Regressions",
    "title": "Regressions",
    "category": "page",
    "text": ""
},

{
    "location": "reg/#Regression-Indicators-1",
    "page": "Regressions",
    "title": "Regression Indicators",
    "category": "section",
    "text": ""
},

{
    "location": "reg/#Indicators.mlr-Tuple{Array{Float64,N} where N}",
    "page": "Regressions",
    "title": "Indicators.mlr",
    "category": "method",
    "text": "Moving linear regression predictions\n\n\n\n\n\n"
},

{
    "location": "reg/#Indicators.mlr_bands-Tuple{Array{Float64,N} where N}",
    "page": "Regressions",
    "title": "Indicators.mlr_bands",
    "category": "method",
    "text": "Moving linear regression bands\n\nOutput:\n\nColumn 1: Lower bound\n\nColumn 2: Regression estimate\n\nColumn 3: Upper bound\n\n\n\n\n\n"
},

{
    "location": "reg/#Indicators.mlr_beta-Tuple{Array{Float64,N} where N}",
    "page": "Regressions",
    "title": "Indicators.mlr_beta",
    "category": "method",
    "text": "Moving linear regression intercept (column 1) and slope (column 2)\n\n\n\n\n\n"
},

{
    "location": "reg/#Indicators.mlr_intercept-Tuple{Array{Float64,N} where N}",
    "page": "Regressions",
    "title": "Indicators.mlr_intercept",
    "category": "method",
    "text": "Moving linear regression y-intercept\n\n\n\n\n\n"
},

{
    "location": "reg/#Indicators.mlr_lb-Tuple{Array{Float64,N} where N}",
    "page": "Regressions",
    "title": "Indicators.mlr_lb",
    "category": "method",
    "text": "Moving linear regression lower bound\n\n\n\n\n\n"
},

{
    "location": "reg/#Indicators.mlr_rsq-Tuple{Array{Float64,N} where N}",
    "page": "Regressions",
    "title": "Indicators.mlr_rsq",
    "category": "method",
    "text": "Moving linear regression R-squared or adjusted R-squared\n\n\n\n\n\n"
},

{
    "location": "reg/#Indicators.mlr_se-Tuple{Array{Float64,N} where N}",
    "page": "Regressions",
    "title": "Indicators.mlr_se",
    "category": "method",
    "text": "Moving linear regression standard errors\n\n\n\n\n\n"
},

{
    "location": "reg/#Indicators.mlr_slope-Tuple{Array{Float64,N} where N}",
    "page": "Regressions",
    "title": "Indicators.mlr_slope",
    "category": "method",
    "text": "Moving linear regression slope\n\n\n\n\n\n"
},

{
    "location": "reg/#Indicators.mlr_ub-Tuple{Array{Float64,N} where N}",
    "page": "Regressions",
    "title": "Indicators.mlr_ub",
    "category": "method",
    "text": "Moving linear regression upper bound\n\n\n\n\n\n"
},

{
    "location": "reg/#Reference-1",
    "page": "Regressions",
    "title": "Reference",
    "category": "section",
    "text": "Modules = [Indicators]\nPages = [\"reg.jl\"]"
},

{
    "location": "trendy/#",
    "page": "Trendlines",
    "title": "Trendlines",
    "category": "page",
    "text": ""
},

{
    "location": "trendy/#Trendlines-1",
    "page": "Trendlines",
    "title": "Trendlines",
    "category": "section",
    "text": ""
},

{
    "location": "trendy/#Reference-1",
    "page": "Trendlines",
    "title": "Reference",
    "category": "section",
    "text": "Modules = [Indicators]\nPages = [\"trendy.jl\"]"
},

{
    "location": "patterns/#",
    "page": "Patterns",
    "title": "Patterns",
    "category": "page",
    "text": ""
},

{
    "location": "patterns/#Chart-Patterns-1",
    "page": "Patterns",
    "title": "Chart Patterns",
    "category": "section",
    "text": ""
},

{
    "location": "patterns/#Indicators.renko-Tuple{Array{Float64,N} where N}",
    "page": "Patterns",
    "title": "Indicators.renko",
    "category": "method",
    "text": "Renko chart patterns\n\nMethods\n\nTraditional (Constant Box Size): renko(x::Array{Float64}; box_size::Float64=10.0)::Array{Int}\nATR Dynamic Box Size: renko(hlc::Matrix{Float64}; box_size::Float64=10.0, use_atr::Bool=false, n::Int=14)::Array{Int}\n\nOutput\n\nArray{Int} object of size Nx1 (where N is the number rows in x) where each element gives the Renko bar number of the corresponding row in x.\n\n\n\n\n\n"
},

{
    "location": "patterns/#Reference-1",
    "page": "Patterns",
    "title": "Reference",
    "category": "section",
    "text": "Modules = [Indicators]\nPages = [\"patterns.jl\"]"
},

]}
