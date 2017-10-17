using Indicators
using Temporal
using Base.Test

const N = 1_000
const X0 = 50.0

x = cumsum(randn(N)) + X0
ohlc = cumsum(randn(N,4)) + X0
hlc = ohlc[:,2:3]

count_nans(x) = sum(isnan.(x))

#TODO: mom.jl
#TODO: reg.jl
#TODO: patterns.jl
#TODO: temporal.jl
#TODO: trendy.jl
#TODO: utils.jl
#TODO: vol.jl

#TODO: run.jl
tmp = diffn(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = diffn(ohlc)
@test size(tmp, 1) == N
@test size(tmp, 2) == size(ohlc,2)
@test count_nans(tmp) != N

tmp = runmean(x, cumulative=true)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = runmean(x, cumulative=false)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = runsum(x, cumulative=true)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = wilder_sum(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = runmad(x, cumulative=true)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = runmad(x, cumulative=false)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = runvar(x, cumulative=true)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = runvar(x, cumulative=false)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = runcov(x, x.*rand(N), cumulative=true)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = runcov(x, x.*rand(N), cumulative=false)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = runcor(x, x.*rand(N), cumulative=true)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = runcor(x, x.*rand(N), cumulative=false)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = runmin(x, cumulative=true)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = runmin(x, cumulative=false)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = max(x, cumulative=true)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = max(x, cumulative=false)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

# moving average functions
tmp = sma(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 1
@test count_nans(tmp) != N

tmp = mama(x)
@test size(tmp, 1) == N
@test size(tmp, 2) == 2
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


