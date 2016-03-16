# TODO: add abilities to use different MA types for trima, macd, bbands, etc

@doc doc"""
runmean(x::Array{Float64,1}, n::Int=10, cumulative::Bool=true)

Compute a running or rolling arithmetic mean of an array.
""" ->
function runmean{T<:Real}(x::Array{T,1}, n::Int=10, cumulative::Bool=true)
    ma = fill(NaN, size(x,1))
    if cumulative
        for i = n:size(x,1)
            ma[i] = mean(x[1:i])
        end
    else
        for i=n:size(x,1)
            ma[i] = mean(x[i-n+1:i])
        end
    end
    return ma
end

@doc doc"""
runsum(x::Array{Numeric}, n::Int=10, cumulative::Bool=true)

Compute a running or rolling summation of an array.
""" ->
function runsum{T<:Real}(x::Array{T,1}, n::Int=10, cumulative::Bool=true)
	out = fill(NaN, size(x,1))
	if cumulative
		for i=n:size(x,1)
			out[i] = sum(x[1:i])
		end
	else
		for i=n:size(x,1)
			out[i] = sum(x[i-n+1:i])
		end
	end
	return out
end

@doc doc"""
wilder_sum(x::Array{Float64,1}, n::Int=10)

Calculate a Welles Wilder Summation of an array.
""" ->
function wilder_sum{T<:Real}(x::Array{T,1}, n::Int=10)
	N = size(x,1)
	out = fill(NaN, size(x,1))
	out[1:n-1] = sum(x[1:n-1])
	for i = n:N
		out[i] = sum[i-1] - sum[i-1]/n + x[i]
	end
	return out
end


@doc doc"""
sma{T<:Real}(x::Array{T,1}, n::Int=10)

Simple moving average
""" ->
function sma{T<:Real}(x::Array{T,1}, n::Int=10)
	return runmean(x, n, false)
end

@doc doc"""
trima{T<:Real}(x::Array{T,1}, n::Int=10)

Triangular moving average
""" ->
# TODO: index to dodge NaN values, allowing for other MA types
# TODO: include matype argument for greater flexibility
function trima{T<:Real}(x::Array{T,1}, n::Int=10)
    return sma(sma(x, n), n)
end

@doc doc"""
wma{T<:Real}(x::Array{T,1}, n::Int=10; wts::Array{T,1}=collect(1:n)/sum(1:n))

Weighted moving average
""" ->
function wma{T<:Real}(x::Array{T,1}, n::Int=10; wts::Array{T,1}=collect(1:n)/sum(1:n))
	ma = fill(NaN, size(x,1))
    for i = n:size(x,1)
        ma[i] = (wts' * x[i-n+1:i])[1]
    end
    return ma
end

@doc doc"""
ema{T<:Real}(x::Array{T,1}, n::Int=10; alpha=2.0/(n+1), wilder::Bool=false)

Exponential moving average
""" ->
function ema{T<:Real}(x::Array{T,1}, n::Int=10; alpha=2.0/(n+1), wilder::Bool=false)
    if wilder
        alpha = 1.0/n
    end
	ma = fill(NaN, size(x,1))
    i = first(find(!isnan(x)))
    ma[n+i-1] = mean(x[i:n+i-1])
    for i = n+i:size(x,1)
        ma[i] = alpha * (x[i] - ma[i-1]) + ma[i-1]
    end
    return ma
end

@doc doc"""
mama{T<:Float64}(x::Array{T,1}, fastlimit::Float64=0.5, slowlimit::Float64=0.05)

MESA adaptive moving average (developed by John Ehlers)
""" ->
function mama{T<:Float64}(x::Array{T,1}, fastlimit::Float64=0.5, slowlimit::Float64=0.05)
    n = size(x,1)
    ma = zeros(n,2)
    smooth = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    detrend = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    Q1 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    I1 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    I2 = [0.0, 0.0]
    Q2 = [0.0, 0.0]
    Re = [0.0, 0.0]
    Im = [0.0, 0.0]
    per = [0.0, 0.0]
    sper = [0.0, 0.0]
    phase = [0.0, 0.0]
    jI = 0.0
    jQ = 0.0
    dphase = 0.0
    alpha = 0.0
    for i = 13:n
        # Smooth and detrend price movement ====================================
        smooth[7] = (4*x[i] + 3*x[i-1] + 2*x[i-2] + x[i-3]) * 0.1
        detrend[7] = (0.0962*smooth[7]+0.5769*smooth[5]-0.5769*smooth[3]-0.0962*smooth[1]) * (0.075*per[1]+0.54)
        # Compute InPhase and Quandrature components ===========================
        Q1[7] = (0.0962*detrend[7]+0.5769*detrend[5]-0.5769*detrend[3]-0.0962*detrend[1]) * (0.075*per[1]+0.54)
        I1[7] = detrend[4]
        # Advance phase of I1 and Q1 by 90 degrees =============================
        jQ = (0.0962*Q1[7]+0.5769*Q1[5]-0.5769*Q1[3]-0.0962*Q1[1]) * (0.075*per[1]+0.54)
        jI = (0.0962*I1[7]+0.5769*I1[5]-0.5769*I1[3]-0.0962*I1[1]) * (0.075*per[1]+0.54)
        # Phasor addition for 3 bar averaging ==================================
        Q2[2] = Q1[7] + jI
        I2[2] = I1[7] - jQ
        # Smooth I & Q components before applying the discriminator ============
        Q2[2] = 0.2 * Q2[2] + 0.8 * Q2[1]
        I2[2] = 0.2 * I2[2] + 0.8 * I2[1]
        # Homodyne discriminator ===============================================
        Re[2] = I2[2] * I2[1] + Q2[2]*Q2[1]
        Im[2] = I2[2] * Q2[1] - Q2[2]*I2[1]
        Re[2] = 0.2 * Re[2] + 0.8*Re[1]
        Im[2] = 0.2 * Im[2] + 0.8*Im[1]
        if (Im[2] != 0.0) & (Re[2] != 0.0)
            per[2] = 360.0/atan(Im[2]/Re[2])
        end
        if per[2] > 1.5 * per[1]
            per[2] = 1.5*per[1]
        elseif per[2] < 0.67 * per[1]
            per[2] = 0.67 * per[1]
        end
        if per[2] < 6.0
            per[2] = 6.0
        elseif per[2] > 50.0
            per[2] = 50.0
        end
        per[2] = 0.2*per[2] + 0.8*per[1]
        sper[2] = 0.33*per[2] + 0.67*sper[1]
        if I1[7] != 0.0
            phase[2] = atan(Q1[7]/I1[7])
        end
        dphase = phase[1] - phase[2]
        if dphase < 1.0
            dphase = 1.0
        end
        alpha = fastlimit / dphase
        if alpha < slowlimit
            alpha = slowlimit
        end
        ma[i,1] = alpha*x[i] + (1.0-alpha)*ma[i-1,1]
        ma[i,2] = 0.5*alpha*ma[i,1] + (1.0-0.5*alpha)*ma[i-1,2]
        # Reset/increment array variables
        smooth = [smooth[2:7]; smooth[7]]
        detrend = [detrend[2:7]; detrend[7]]
        Q1 = [Q1[2:7]; Q1[7]]
        I1 = [I1[2:7]; I1[7]]
        I2[1] = I2[2]
        Q2[1] = Q2[2]
        Re[1] = Re[2]
        Im[1] = Im[2]
        per[1] = per[2]
        sper[1] = sper[2]
        phase[1] = phase[2]
    end
    ma[1:32,:] = NaN
    return ma
end


@doc doc"""
hma{T<:Real}(x::Array{T,1}, n::Int=1)

Hull moving average
""" ->
function hma{T<:Real}(x::Array{T,1}, n::Int=20)
    return wma(2 * wma(x, Int(round(n/2.0))) - wma(x, n), Int(trunc(sqrt(n))))
end

@doc doc"""
swma{T<:Real}(x::Array{T,1}, n::Int)

Sine-weighted moving average
""" ->
function swma{T<:Real}(x::Array{T,1}, n::Int=10)
    N = size(x,1)
    ma = [NaN for i=1:N]
    w = sin(collect(1:n) * 180.0/6.0)  # numerator weights
    d = sum(w)  # denominator = sum(numerator weights)
    for i = n:N
        ma[i] = sum(w .* x[i-n+1:i]) / d
    end
    return ma
end

