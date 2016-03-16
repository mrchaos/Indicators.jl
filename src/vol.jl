# TODO: add matype option for atr

include("ma.jl")

@doc doc"""
bbands{T<:Real}(x::Array{T,1}, n::Int=10, sigma::Float64=2.0)

Bollinger Bands (moving average with standard deviation bands)
""" ->
function bbands{T<:Real}(x::Array{T,1}, n::Int=10, sigma::Float64=2.0)
    out = zeros(size(x,1), 3)  # cols := lower bound, ma, upper bound
    out[:,2] = sma(x, n)
    sd = run_sd(x, n, false)
    out[:,1] = out[:,2] - sigma*sd
    out[:,3] = out[:,2] + sigma*sd
    return out
end

@doc doc"""
tr{T<:Real}(hlc::Array{T,2})

True Range
""" ->
function tr{T<:Real}(hlc::Array{T,2})
    if size(hlc,2) != 3
        error("HLC array must have 3 columns.")
    end
    n = size(hlc,1)
    out = zeros(n)
    out[1] = NaN
    for i=2:n
        out[i] = max(hlc[i,1]-hlc[i,2], hlc[i,1]-hlc[i-1,3], hlc[i-1,3]-hlc[i,2])
    end
    return out[:,1]
end

@doc doc"""
atr{T<:Real}(hlc::Array{T,2}, n::Int=14)

Average true range (uses exponential moving average)
""" ->
function atr{T<:Real}(hlc::Array{T,2}, n::Int=14)
    return [NaN; ema(tr(hlc)[2:end], n)]
end

@doc doc"""
keltner{T<:Real}(hlc::Array{T,2}, nema::Int=20, natr::Int=10, mult::Int=2)

Keltner Bands
""" ->
function keltner{T<:Real}(hlc::Array{T,2}, nema::Int=20, natr::Int=10, mult::Int=2)
    out = zeros(size(hlc,1), 3)
    out[:,2] = ema(hlc[:,3], nema)
    out[:,1] = out[:,2] - mult*atr(hlc, natr)
    out[:,3] = out[:,2] + mult*atr(hlc, natr)
    return out
end
