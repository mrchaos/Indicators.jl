using Indicators
using Temporal
using Base.Test

const n = 1_000
const x0 = 50.0

x = cumsum(randn(n)) + x0
ohlc = cumsum(randn(n,4)) + x0
hlc = ohlc[:,2:3]

# moving average functions
@test size(mama(x), 1) == n
@test size(mama(x), 2) == 2

@test size(sma(x), 1) == n
@test size(sma(x), 2) == 1

@test size(ema(x), 1) == n
@test size(ema(x), 2) == 1

@test size(wma(x), 1) == n
@test size(wma(x), 2) == 1

@test size(hma(x), 1) == n
@test size(hma(x), 2) == 1

@test size(trima(x), 1) == n
@test size(trima(x), 2) == 1

@test size(mma(x), 1) == n
@test size(mma(x), 2) == 1

@test size(tema(x), 1) == n
@test size(tema(x), 2) == 1

@test size(dema(x), 1) == n
@test size(dema(x), 2) == 1

@test size(swma(x), 1) == n
@test size(swma(x), 2) == 1

@test size(kama(x), 1) == n
@test size(kama(x), 2) == 1

@test size(alma(x), 1) == n
@test size(alma(x), 2) == 1

@test size(zlema(x), 1) == n
@test size(zlema(x), 2) == 1

#TODO: run.jl
#TODO: mom.jl
#TODO: reg.jl
#TODO: patterns.jl
#TODO: temporal.jl
#TODO: trendy.jl
#TODO: utils.jl
#TODO: vol.jl


