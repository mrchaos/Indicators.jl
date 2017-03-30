@doc doc"""
Simple moving average (SMA)

`sma{Float64}(x::Vector{Float64}; n::Int64=10)::Vector{Float64}`
""" ->
function sma{Float64}(x::Vector{Float64}; n::Int64=10)::Vector{Float64}
    return runmean(x, n=n, cumulative=false)
end
# function sma{Float64}(X::Matrix{Float64}; n::Int=10)::Matrix{Float64}
#     out = zeros(X)
#     @inbounds for j in 1:size(X,2)
#         out[:,j] = sma(X[:,j], n=n)
#     end
#     return out
# end

@doc doc"""
Triangular moving average (TRIMA)

`trima{Float64}(x::Vector{Float64}; n::Int64=10, ma::Function=sma, args...)::Vector{Float64}`
""" ->
function trima{Float64}(x::Vector{Float64}; n::Int64=10, ma::Function=sma)::Vector{Float64}
    return ma(ma(x, n=n), n=n)
end

@doc doc"""
Weighted moving average (WMA)

`wma{Float64}(x::Vector{Float64}; n::Int64=10, wts::Vector{Float64}=collect(1:n)/sum(1:n))::Vector{Float64}`
""" ->
function wma{Float64}(x::Vector{Float64}; n::Int64=10, wts::Vector{Float64}=collect(1:n)/sum(1:n))
    @assert n<size(x,1) && n>0 "Argument n out of bounds"
    out = fill(NaN, size(x,1))
    @inbounds for i = n:size(x,1)
        out[i] = (wts' * x[i-n+1:i])[1]
    end
    return out
end

@doc doc"""
Exponential moving average (EMA)

`ema{Float64}(x::Vector{Float64}; n::Int64=10, alpha::Float64=2.0/(n+1.0), wilder::Bool=false)::Vector{Float64}`
""" ->
function ema{Float64}(x::Vector{Float64}; n::Int64=10, alpha::Float64=2.0/(n+1), wilder::Bool=false)
    @assert n<size(x,1) && n>0 "Argument n out of bounds."
    if wilder
        alpha = 1.0/n
    end
    out = zeros(x)
    i = first(find(!isnan(x)))
    out[1:n+i-2] = NaN
    out[n+i-1] = mean(x[i:n+i-1])
    @inbounds for i = n+i:size(x,1)
        out[i] = alpha * (x[i] - out[i-1]) + out[i-1]
    end
    return out
end

@doc doc"""
Modified moving average (MMA)

`mma{Float64}(x::Vector{Float64}; n::Int64=10)::Vector{Float64}`
""" ->
function mma{Float64}(x::Vector{Float64}; n::Int64=10)
    return ema(x, n=n, alpha=1.0/n)
end

@doc doc"""
Double exponential moving average (DEMA)

`dema{Float64}(x::Vector{Float64}; n::Int64=10, alpha=2.0/(n+1), wilder::Bool=false)::Vector{Float64}`
""" ->
function dema{Float64}(x::Vector{Float64}; n::Int64=10, alpha=2.0/(n+1), wilder::Bool=false)
    return 2.0 * ema(x, n=n, alpha=alpha, wilder=wilder) - 
        ema(ema(x, n=n, alpha=alpha, wilder=wilder),
            n=n, alpha=alpha, wilder=wilder)
end

@doc doc"""
Triple exponential moving average (TEMA)

`tema{Float64}(x::Vector{Float64}; n::Int64=10, alpha=2.0/(n+1), wilder::Bool=false)::Vector{Float64}`
""" ->
function tema{Float64}(x::Vector{Float64}; n::Int64=10, alpha=2.0/(n+1), wilder::Bool=false)
    return 3.0 * ema(x, n=n, alpha=alpha, wilder=wilder) - 
        3.0 * ema(ema(x, n=n, alpha=alpha, wilder=wilder),
                  n=n, alpha=alpha, wilder=wilder) +
        ema(ema(ema(x, n=n, alpha=alpha, wilder=wilder),
                n=n, alpha=alpha, wilder=wilder),
            n=n, alpha=alpha, wilder=wilder)
end

@doc doc"""
MESA adaptive moving average (MAMA)

`mama{Float64}(x::Vector{Float64}; fastlimit::Float64=0.5, slowlimit::Float64=0.05)::Vector{Float64}`
""" ->
function mama{Float64}(x::Vector{Float64}; fastlimit::Float64=0.5, slowlimit::Float64=0.05)
    n = size(x,1)
    out = zeros(n,2)
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
    a = 0.0962
    b = 0.5769
    @inbounds for i = 13:n
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
        out[i,1] = alpha*x[i] + (1.0-alpha)*out[i-1,1]
        out[i,2] = 0.5*alpha*out[i,1] + (1.0-0.5*alpha)*out[i-1,2]
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
    out[1:32,:] = NaN
    return out
end


@doc doc"""
Hull moving average (HMA)

`hma{Float64}(x::Vector{Float64}; n::Int64=20)::Vector{Float64}`
""" ->
function hma{Float64}(x::Vector{Float64}; n::Int64=20)
    return wma(2 * wma(x, n=Int64(round(n/2.0))) - wma(x, n=n), n=Int64(trunc(sqrt(n))))
end

@doc doc"""
Sine-weighted moving average

`swma{Float64}(x::Vector{Float64}; n::Int64)::Vector{Float64}`
""" ->
function swma{Float64}(x::Vector{Float64}; n::Int64=10)
    @assert n<size(x,1) && n>0 "Argument n out of bounds."
    w = sin(collect(1:n) * 180.0/6.0)  # numerator weights
    d = sum(w)  # denominator = sum(numerator weights)
    out = zeros(x)
    out[1:n-1] = NaN
    @inbounds for i = n:size(x,1)
        out[i] = sum(w .* x[i-n+1:i]) / d
    end
    return out
end

@doc doc"""
Kaufman adaptive moving average (KAMA)

`kama{Float64}(x::Vector{Float64}; n::Int64=10, nfast::Float64=0.6667, nslow::Float64=0.0645)::Vector{Float64}`
""" ->
function kama{Float64}(x::Vector{Float64}; n::Int64=10, nfast::Float64=0.6667, nslow::Float64=0.0645)
    @assert n<size(x,1) && n>0 "Argument n out of bounds."
    @assert nfast>0.0 && nfast<1.0 "Argument nfast out of bounds."
    @assert nslow>0.0 && nslow<1.0 "Argument nslow out of bounds."
    dir = diffn(x, n=n)  # price direction := net change in price over past n periods
    vol = runsum(abs(diffn(x,n=1)), n=n, cumulative=false)  # volatility/noise
    er = abs(dir) ./ vol  # efficiency ratio
    ssc = er * (nfast-nslow) + nslow  # scaled smoothing constant
    sc = ssc .^ 2  # smoothing constant
    # initiliaze result variable
    out = zeros(x)
    i = first(find(!isnan(x)))
    out[1:n+i-2] = NaN
    out[n+i-1] = mean(x[i:n+i-1])
    @inbounds for i = n+1:size(x,1)
        out[i] = out[i-1] + sc[i]*(x[i]-out[i-1])
    end
    return out
end

@doc doc"""
Arnaud-Legoux moving average (ALMA)

`alma{Float64}(x::Vector{Float64}; n::Int64=9, offset::Float64=0.85, sigma::Float64=6.0)::Vector{Float64}`
""" ->
function alma{Float64}(x::Vector{Float64}; n::Int64=9, offset::Float64=0.85, sigma::Float64=6.0)
    @assert n<size(x,1) && n>0 "Argument n out of bounds."
    @assert sigma>0.0 "Argument sigma must be greater than 0."
    @assert offset>=0.0 && offset<=1 "Argument offset must be in (0,1)."
    out = zeros(x)
    out[1:n-1] = NaN
    m = floor(offset*(float(n)-1.0))
    s = float(n) / sigma
    w = exp(-(((0.0:-1.0:-float(n)+1.0)-m).^2.0) / (2.0*s*s))
    wsum = sum(w)
    if wsum != 0.0
        w = w ./ wsum
    end
    @inbounds for i = n:length(x)
        out[i] = sum(x[i-n+1] .* w)
    end
    return out
end

