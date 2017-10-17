using Indicators
using Temporal
using Base.Test

const N = 1_000
const X0 = 50.0

x = cumsum(randn(N)) + X0
ohlc = cumsum(randn(N,4)) + X0
hlc = ohlc[:,2:3]

count_nans(x) = sum(isnan.(x))

# moving average functions
tmp = mama(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 2
@test count_nans(tmp) != N

tmp = sma(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = ema(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = wma(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = hma(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = trima(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = mma(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = tema(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = dema(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = swma(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = kama(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = alma(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = zlema(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N


#TODO: run.jl

#TODO: mom.jl
#TODO: reg.jl
#TODO: patterns.jl
#TODO: temporal.jl
#TODO: trendy.jl
#TODO: utils.jl
#TODO: vol.jl


