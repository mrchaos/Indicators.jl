"""
```
bbands(x::Array{T}; n::Int64=10, sigma::T=2.0)::Matrix{T}
```

Bollinger bands (moving average with standard deviation bands)

*Output*
- Column 1: lower band
- Column 2: middle band
- Column 3: upper band
"""
function bbands(x::Array{T}; n::Int64=10, sigma::T=2.0, ma::Function=sma, args...)::Matrix{T} where {T<:Real}
    @assert n<size(x,1) && n>0 "Argument n is out of bounds."
    out = zeros(size(x,1), 3)  # cols := lower bound, ma, upper bound
    out[:,2] = ma(x, n=n, args...)
    sd = runsd(x, n=n, cumulative=false)
    out[:,1] = out[:,2] - sigma*sd
    out[:,3] = out[:,2] + sigma*sd
    return out
end

"""
```
tr(hlc::Matrix{T})::Array{T}
```

True range
"""
function tr(hlc::Matrix{T})::Array{T} where {T<:Real}
    @assert size(hlc,2) == 3 "HLC array must have 3 columns."
    n = size(hlc,1)
    out = zeros(n)
    out[1] = NaN
    @inbounds for i=2:n
        out[i] = max(hlc[i,1]-hlc[i,2], hlc[i,1]-hlc[i-1,3], hlc[i-1,3]-hlc[i,2])
    end
    return out[:,1]
end

"""
```
atr(hlc::Matrix{T}; n::Int64=14)::Array{T}
```

Average true range (uses exponential moving average)
"""
function atr(hlc::Matrix{T}; n::Int64=14, ma::Function=ema)::Array{T} where {T<:Real}
    @assert n<size(hlc,1) && n>0 "Argument n out of bounds."
    return [NaN; ma(tr(hlc)[2:end], n=n)]
end

"""
```
keltner(hlc::Matrix{T}; nema::Int64=20, natr::Int64=10, mult::Int64=2)::Matrix{T}
```

Keltner bands

*Output*
Column 1: lower band
Column 2: middle band
Column 3: upper band
"""
function keltner(hlc::Array{T,2}; nema::Int64=20, natr::Int64=10, mult::Int64=2)::Matrix{T} where {T<:Real}
    @assert size(hlc,2) == 3 "HLC array must have 3 columns."
    out = zeros(size(hlc,1), 3)
    out[:,2] = ema(hlc[:,3], n=nema)
    out[:,1] = out[:,2] - mult*atr(hlc, n=natr)
    out[:,3] = out[:,2] + mult*atr(hlc, n=natr)
    return out
end
