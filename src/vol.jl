@doc doc"""
bbands{Float64}(x::Vector{Float64}, n::Int64=10, sigma::Float64=2.0)

Bollinger Bands (moving average with standard deviation bands)
""" ->
function bbands{Float64}(x::Vector{Float64}, n::Int64=10, sigma::Float64=2.0; ma::Function=sma, args...)
    @assert n<size(x,1) && n>0 "Argument n is out of bounds."
    out = zeros(size(x,1), 3)  # cols := lower bound, ma, upper bound
    out[:,2] = ma(x, n; args...)
    sd = runsd(x, n, false)
    out[:,1] = out[:,2] - sigma*sd
    out[:,3] = out[:,2] + sigma*sd
    return out
end

@doc doc"""
tr{Float64}(hlc::Array{Float64,2})

True Range
""" ->
function tr{Float64}(hlc::Array{Float64,2})
    if size(hlc,2) != 3
        error("HLC array must have 3 columns.")
    end
    n = size(hlc,1)
    out = zeros(n)
    out[1] = NaN
    @inbounds for i=2:n
        out[i] = max(hlc[i,1]-hlc[i,2], hlc[i,1]-hlc[i-1,3], hlc[i-1,3]-hlc[i,2])
    end
    return out[:,1]
end

@doc doc"""
atr{Float64}(hlc::Array{Float64,2}, n::Int64=14)

Average true range (uses exponential moving average)
""" ->
function atr{Float64}(hlc::Array{Float64,2}, n::Int64=14; ma::Function=ema)
    @assert n<size(hlc,1) && n>0 "Argument n out of bounds."
    return [NaN; ma(tr(hlc)[2:end], n)]
end

@doc doc"""
keltner{Float64}(hlc::Array{Float64,2}, nema::Int64=20, natr::Int64=10, mult::Int64=2)

Keltner Bands
""" ->
function keltner{Float64}(hlc::Array{Float64,2}, nema::Int64=20, natr::Int64=10, mult::Int64=2)
    out = zeros(size(hlc,1), 3)
    out[:,2] = ema(hlc[:,3], nema)
    out[:,1] = out[:,2] - mult*atr(hlc, natr)
    out[:,3] = out[:,2] + mult*atr(hlc, natr)
    return out
end
