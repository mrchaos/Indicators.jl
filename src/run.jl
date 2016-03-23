@doc doc"""
mode{T}(a::AbstractArray{T})

Compute the mode of an arbitrary array

(Adapted from StatsBase: https://raw.githubusercontent.com/JuliaStats/StatsBase.jl/master/src/scalarstats.jl)
""" ->
function mode{Float64}(a::AbstractArray{Float64})
    isempty(a) && error("mode: input array cannot be empty.")
    cnts = Dict{Float64,Int64}()
    # first element
    mc = 1
    mv = a[1]
    cnts[mv] = 1
    # find the mode along with table construction
    @inbounds for i = 2 : length(a)
        x = a[i]
        if haskey(cnts, x)
            c = (cnts[x] += 1)
            if c > mc
                mc = c
                mv = x
            end
        else
            cnts[x] = 1
            # in this case: c = 1, and thus c > mc won't happen
        end
    end
    return mv
end

@doc doc"""
runmean{Float64}(x::Vector{Float64}, n::Int64=10, cumulative::Bool=true)

Compute a running or rolling arithmetic mean of an array.
""" ->
function runmean{Float64}(x::Vector{Float64}, n::Int64=10, cumulative::Bool=true)
    @assert n<size(x,1) && n>0 "Argument n is out of bounds."
    out = zeros(x)
    out[1:n-1] = NaN
    if cumulative
        fi = 1.0:size(x,1)
        @inbounds for i = n:size(x,1)
            out[i] = sum(x[1:i])/fi[i]
        end
    else
        @inbounds for i = n:size(x,1)
            out[i] = mean(x[i-n+1:i])
        end
    end
    return out
end

@doc doc"""
runsum{Float64}(x::Vector{Float64}, n::Int64=10, cumulative::Bool=true)

Compute a running or rolling summation of an array.
""" ->
function runsum{Float64}(x::Vector{Float64}, n::Int64=10, cumulative::Bool=true)
    @assert n<size(x,1) && n>0 "Argument n is out of bounds."
    if cumulative
        out = cumsum(x)
        out[1:n-1] = NaN
    else
        out = zeros(x)
        out[1:n-1] = NaN
        @inbounds for i = n:size(x,1)
            out[i] = sum(x[i-n+1:i])
        end
    end
	return out
end

@doc doc"""
wilder_sum{Float64}(x::Vector{Float64}, n::Int64=10)

Welles Wilder summation of an array
""" ->
function wilder_sum{Float64}(x::Vector{Float64}, n::Int64=10)
    @assert n<size(x,1) && n>0 "Argument n is out of bounds."
    nf = float(n)  # type stability -- all arithmetic done on floats
    out = zeros(x)
    out[1] = x[1]
    @inbounds for i = 2:size(x,1)
        out[i] = x[i] + out[i-1]*(nf-1.0)/nf
    end
    return out
end

@doc doc"""
runmad{Float64}(x::Vector{Float64}, n::Int64=10, fun::Function=median)

Compute the running or rolling mean absolute deviation of an array
""" ->
function runmad{Float64}(x::Vector{Float64}, n::Int64=10, cumulative::Bool=true; fun::Function=median)
    @assert n<size(x,1) && n>0 "Argument n is out of bounds."
    out = zeros(x)
    out[1:n-1] = NaN
    center = 0.0
    if cumulative
        fi = collect(1.0:size(x,1))
        @inbounds for i = n:size(x,1)
            center = fun(x[1:i])
            out[i] = sum(abs(x[1:i]-center)) / fi[i]
        end
    else
        fn = float(n)
        @inbounds for i = n:size(x,1)
            center = fun(x[i-n+1:i])
            out[i] = sum(abs(x[i-n+1:i]-center)) / fn
        end
    end
    return out
end

@doc doc"""
runvar{Float64}(x::Vector{Float64}, n::Int64=10, cumulative=true)

Compute the running or rolling variance of an array
""" ->
function runvar{Float64}(x::Vector{Float64}, n::Int64=10, cumulative=true)
    @assert n<size(x,1) && n>0 "Argument n is out of bounds."
    out = zeros(x)
    out[1:n-1] = NaN
    if cumulative
        @inbounds for i = n:size(x,1)
            out[i] = var(x[1:i])
        end
    else
        @inbounds for i = n:size(x,1)
            out[i] = var(x[i-n+1:i])
        end
    end
    return out
end

@doc doc"""
runsd{Float64}(x::Vector{Float64}, n::Int64=10, cumulative::Bool=true)

Compute the running or rolling standard deviation of an array
""" ->
function runsd{Float64}(x::Vector{Float64}, n::Int64=10, cumulative::Bool=true)
    return sqrt(runvar(x, n, cumulative))
end

@doc doc"""
runcov{Float64}(xy::Array{Float64,2}, n::Int64=10, cumulative::Bool=true)

Compute the running or rolling covariance of two arrays
""" ->
function runcov{Float64}(xy::Array{Float64,2}, n::Int64=10, cumulative::Bool=true)
    @assert size(xy,2) == 2 "Argument xy must have 2 columns."
    @assert n<size(xy,1) && n>0 "Argument n is out of bounds."
    out = zeros(size(xy,1))
    out[1:n-1] = NaN
    if cumulative
        @inbounds for i = n:N
            out[i] = cov(x[1:i], y[1:i])
        end
    else
        @inbounds for i = n:N
            out[i] = cov(x[i-n+1:i], y[i-n+1:i])
        end
    end
    return out
end

@doc doc"""
runmax{Float64}(x::Vector{Float64}, n::Int64=2, cumulative::Bool=true)

Compute the running or rolling maximum of an array.
""" ->
function runmax{Float64}(x::Vector{Float64}, n::Int64=10, cumulative::Bool=true)
    @assert n<size(x,1) && n>0 "Argument n is out of bounds."
    out = zeros(x)
    if cumulative
        out[n] = maximum(x[1:n])
        @inbounds for i = n+1:size(x,1)
            out[i] = max(out[i-1], x[i])
        end
    else
        @inbounds for i = n:size(x,1)
            out[i] = maximum(x[i-n+1:i])
        end
    end
    out[1:n-1] = NaN
    return out
end

@doc doc"""
runmin{Float64}(x::Vector{Float64}, n::Int64=10, cumulative::Bool=true)

Compute the running or rolling minimum of an array.
""" ->
function runmin{Float64}(x::Vector{Float64}, n::Int64=10, cumulative::Bool=true)
    @assert n<size(x,1) && n>0 "Argument n is out of bounds."
    out = zeros(x)
    if cumulative
        out[n] = minimum(x[1:n])
        @inbounds for i = n+1:size(x,1)
            out[i] = min(out[i-1], x[i])
        end
    else
        @inbounds for i = n:size(x,1)
            out[i] = minimum(x[i-n+1:i])
        end
    end
    out[1:n-1] = NaN
    return out
end
