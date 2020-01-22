@testset "Momentum" begin
    Random.seed!(SEED)
    @testset "Array" begin
        x = cumsum(randn(N))     # close
        Y = cumsum(randn(N, 2), dims=1)  # high-low
        Z = cumsum(randn(N, 3), dims=1)  # high-low-close
        tmp = aroon(Y)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 3
        @test sum(isnan.(tmp)) != N
        tmp = donch(Y)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 3
        @test sum(isnan.(tmp)) != N
        tmp = momentum(x)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 1
        @test sum(isnan.(tmp)) != N
        tmp = roc(x)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 1
        @test sum(isnan.(tmp)) != N
        tmp = macd(x)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 3
        @test sum(isnan.(tmp)) != N
        tmp = rsi(x)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 1
        @test sum(isnan.(tmp)) != N
        tmp = adx(Z)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 3
        @test sum(isnan.(tmp)) != N
        tmp = adx(Z, wilder=true)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 3
        @test sum(isnan.(tmp)) != N
        tmp = psar(Y)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 1
        @test sum(isnan.(tmp)) != N
        tmp = kst(x)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 1
        @test sum(isnan.(tmp)) != N
        tmp = wpr(Z)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 1
        @test sum(isnan.(tmp)) != N
        tmp = cci(Z)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 1
        @test sum(isnan.(tmp)) != N
        tmp = stoch(Z, kind=:fast)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 2
        @test sum(isnan.(tmp)) != N
        tmp = stoch(Z, kind=:slow)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 2
        @test sum(isnan.(tmp)) != N
        tmp = smi(Z)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 2
        @test sum(isnan.(tmp)) != N
    end
    @testset "Temporal" begin
        x = TS(cumsum(randn(N)))
        Y = TS(cumsum(randn(N, 2), dims=1))
        Z = TS(cumsum(randn(N, 3), dims=1))
        # momentum function
        tmp = aroon(Y)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 3
        tmp = donch(Y)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 3
        tmp = momentum(x)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 1
        tmp = roc(x)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 1
        tmp = macd(x)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 3
        tmp = rsi(x)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 1
        tmp = adx(Z)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 3
        tmp = adx(Z, wilder=true)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 3
        tmp = psar(Y)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 1
        tmp = kst(x)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 1
        tmp = wpr(Z)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 1
        tmp = cci(Z)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 1
        tmp = stoch(Z, kind=:fast)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 2
        tmp = stoch(Z, kind=:slow)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 2
        tmp = smi(Z)
        @test size(tmp, 1) == N
        @test size(tmp, 2) == 2
    end
end
