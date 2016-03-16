# TODO: include matype options in macd, rsi, and adx functions
# include("ma.jl")  # include pre-requisite moving average functions
# include("vol.jl")  # pre-requisite volatility indicator functions (i.e. avg true range)

@doc doc"""
macd{T<:Real}(x::Array{Real,1}, nfast::Int=12, nslow::Int=26, nsig::Int=9)

Moving average convergence-divergence
""" ->
function macd{T<:Real}(x::Array{T,1}, nfast::Int=12, nslow::Int=26, nsig::Int=9)
    out = zeros(size(x,1), 3)  # cols := fast ma, signal, histogram
	out = fill(NaN, (size(x,1),3))
    out[:,1] = ema(x, nfast) - ema(x, nslow)
    n = max(nfast, nslow)
    out[n:end,2] = ema(out[n:end,1], nsig)
    out[:,3] = out[:,1] - out[:,2]
    return out
end

@doc doc"""
rsi{T<:Real}(x::Array{T,1}, n::Int=14; wilder::Bool=true)

Relative strength index
""" ->
function rsi{T<:Real}(x::Array{T,1}, n::Int=14; wilder::Bool=true)
    N = size(x,1)
    ups = zeros(x)
    dns = zeros(x)
    zro = zero(T)
    dx = [NaN; diff(x)]
    for i=2:N
        if dx[i] > zro
            ups[i] = dx[i]
        elseif dx[i] < zro
            dns[i] = -dx[i]
        end
    end
    rs = [NaN; ema(ups[2:end], n, wilder=wilder) ./ ema(dns[2:end], n, wilder=wilder)]
    return 100.0 - 100.0 ./ (1.0 + rs)
end

@doc doc"""
adx{T<:Real}(hlc::Array{T,2}, n::Int=14; wilder=true)

Average directional index
""" ->
function adx{T<:Real}(hlc::Array{T,2}, n::Int=14; wilder=true)
	if size(hlc,2) != 3
		error("HLC array must have three columns")
	end
	N = size(hlc,1)
	updm = zeros(x)
	dndm = zeros(x)
	updm[1] = dndm[1] = NaN
	for i = 2:N
		upmove = hlc[i,1] - hlc[i-1,1]
		dnmove = hlc[i-1,2] - hlc[i,2]
		if upmove > dnmove && upmove > 0.0
			updm[i] = upmove
		elseif dnmove > upmove && dnmove > 0.0
			dndm[i] = dnmove
		end
	end
	dip = [NaN; ema(updm[2:N], n, wilder=wilder)] ./ atr(hlc, n) * 100.0
	dim = [NaN; ema(dndm[2:N], n, wilder=wilder)] ./ atr(hlc, n) * 100.0
	dmx = abs(dip-dim) ./ (dip+dim)
	adx = [fill(NaN,n); ema(dmx[n+1:N], n, wilder=wilder)] * 100.0
	return [dip dim dmx adx]
end
