# TODO: include matype options in macd, rsi, and adx functions

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
	updm = zeros(N)
	dndm = zeros(N)
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
	return [dip dim adx]
end

@doc doc"""
runmax{T<:Real}(x::Vector{T}, n::Int=2, cumulative::Bool=true)

Compute the running or rolling maximum of an array.
""" ->
function runmax{T<:Real}(x::Vector{T}, n::Int=10, cumulative::Bool=true)
	if n < 1
		error("Argument `n` must be greater than zero.")
	end
	out = zeros(x)
	if cumulative
		out[n] = maximum(x[1:n])
		for i = n+1:size(x,1)
			out[i] = max(out[i-1], x[i])
		end
	else
		for i = n:size(x,1)
			out[i] = maximum(x[i-n+1:i])
		end
	end
	out[1:n-1] = NaN
	return out
end

@doc doc"""
runmin{T<:Real}(x::Vector{T}, n::Int=10, cumulative::Bool=true)

Compute the running or rolling minimum of an array.
""" ->
function runmin{T<:Real}(x::Vector{T}, n::Int=10, cumulative::Bool=true)
	if n < 1
		error("Argument `n` must be greater than zero.")
	end
	out = zeros(x)
	if cumulative
		out[n] = minimum(x[1:n])
		for i = n+1:size(x,1)
			out[i] = min(out[i-1], x[i])
		end
	else
		for i = n:size(x,1)
			out[i] = minimum(x[i-n+1:i])
		end
	end
	out[1:n-1] = NaN
	return out
end

@doc doc"""
psar{T<:Real}(hi::Vector{T}, lo::Vector{T}; af::Float64=0.02,
              af_max::Float64=0.2, af_min::Float64=0.02)

Parabolic stop and reverse (SAR)

hl		- 2D array of high and low prices in first and second columns respectively
af_min  - starting/initial value for acceleration factor
af_max  - maximum acceleration factor (accel factor capped at this value)
af_inc	- increment to the acceleration factor (speed of increase in accel factor)
""" ->
function psar{T<:Real}(hl::Array{T,2}, af_min::Float64=0.02, af_max::Float64=0.2, af_inc::Float64=af_min)
    if size(hl,2) != 2
        error("Argument `hl` must have 2 columns.")
    end
    ls0 = 1
    ls = 0
    af0 = af_min
    af = 0.0
    ep0 = hl[1,1]
    ep = 0.0
    maxi = 0.0
    mini = 0.0
    sar = zeros(T, size(hl,1))
    sar[1] = hl[1,2] - std(hl[:,1]-hl[:,2])
    for i = 2:size(hl,1)
        ls = ls0
        ep = ep0
        af = af0
        mini = min(hl[i-1,2], hl[i,2])
        maxi = max(hl[i-1,1], hl[i,1])
        # Long/short signals and local extrema
        if (ls == 1)
            ls0 = hl[i,2] > sar[i-1] ? 1 : -1
            ep0 = max(maxi, ep)
        else
            ls0 = hl[i,1] < sar[i-1] ? -1 : 1
            ep0 = min(mini, ep)
        end
        # Acceleration vector
        if ls0 == ls  # no signal change
            sar[i] = sar[i-1] + af*(ep-sar[i-1])
            af0 = (af == af_max) ? af_max : (af + af_inc)
            if ls0 == 1  # current long signal
                af0 = (ep0 > ep) ? af0 : af
                sar[i] = min(sar[i], mini)
            else  # current short signal
                af0 = (ep0 < ep) ? af0 : af
                sar[i] = max(sar[i], maxi)
            end
        else  # new signal
            af0 = af_min
            sar[i] = ep0
        end
    end
    return sar
end
