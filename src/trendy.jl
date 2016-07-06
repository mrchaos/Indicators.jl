# Functions supporting trendline identification (support/resistance, zigzag, elliot waves, etc.)

function maxlocal{Float64}(x::Vector{Float64}; threshold::Float64=0.0)
    @assert threshold >= 0.0 "Threshold must be positive."
    n = size(x,1)
    idx = falses(n)
    @inbounds for i=2:n-1
        if (x[i]-x[i-1] >= threshold) && (x[i]-x[i+1] >= threshold)
            idx[i] = true
        end
    end
    return idx
end

function minlocal{Float64}(x::Vector{Float64}; threshold::Float64=0.0)
    @assert threshold <= 0.0 "Threshold must be negative."
    n = size(x,1)
    idx = falses(n)
    @inbounds for i=2:n-1
        if (x[i]-x[i-1] <= threshold) && (x[i]-x[i+1] <= threshold)
            idx[i] = true
        end
    end
    return idx
end

function interpolate(x1::Int, x2::Int, y1::Float64, y2::Float64)
	m = (y2-y1)/(x2-x1)
	b = y1 - m*x1
	x = collect(x1:1.0:x2)
	y = m*x + b
	return y
end

function resistance{Float64}(x::Vector{Float64}; order::Int=1, threshold::Float64=0.0)
    @assert order > 0
    out = zeros(x)
    pks = maxlocal(x, threshold=threshold)
    out[!pks] = NaN
    idx = find(pks)
    @inbounds for i=2:length(idx)
        out[idx[i-1]:idx[i]] = interpolate(idx[i-1], idx[i], x[i-1], x[i])
    end
    while order > 1
        out = resistance(out, threshold=threshold)
        order -= 1
    end
    return out
end

function support{Float64}(x::Vector{Float64}; order::Int=1, threshold::Float64=0.0)
    @assert order > 0
    out = zeros(x)
    pks = minlocal(x, threshold=threshold)
    out[!pks] = NaN
    idx = find(pks)
    @inbounds for i=2:length(idx)
        out[idx[i-1]:idx[i]] = interpolate(idx[i-1], idx[i], x[i-1], x[i])
    end
    while order > 1
        out = support(out, threshold=threshold)
        order -= 1
    end
    return out
end
