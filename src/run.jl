import Temporal.acf  # used for running autocorrelation function

using Statistics

"""
```
diffn(x::Array{T}; n::Int64=1)::Array{T}
```

Lagged differencing
"""
function diffn(x::Array{T}; n::Int64=1)::Array{T} where {T<:Real}
    @assert n<size(x,1) && n>0 "Argument n out of bounds."
    dx = zeros(size(x))
    dx[1:n] .= NaN
    @inbounds for i=n+1:size(x,1)
        dx[i] = x[i] - x[i-n]
    end
    return dx
end

"""
```
diffn(X::Array{T,2}; n::Int64=1)::Array{T}
```

Lagged differencing
"""
function diffn(X::Array{T,2}; n::Int64=1)::Matrix{T} where {T<:Real}
    @assert n<size(X,1) && n>0 "Argument n out of bounds."
    dx = zeros(size(X))
    @inbounds for j = 1:size(X,2)
        dx[:,j] = diffn(X[:,j], n=n)
    end
    return dx
end

"""
(Adapted from StatsBase: https://raw.githubusercontent.com/JuliaStats/StatsBase.jl/master/src/scalarstats.jl)

Compute the mode of an arbitrary array::Array{T}
"""
function mode(a::AbstractArray{T}) where {T<:Real}
    isempty(a) && error("mode: input array cannot be empty.")
    cnts = Dict{T,Int64}()
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

"""
```
runmean(x::Array{T}; n::Int64=10, cumulative::Bool=true)::Array{T}
```

Compute a running or rolling arithmetic mean of an array.
"""
function runmean(x::Array{T}; n::Int64=10, cumulative::Bool=true)::Array{T} where {T<:Real}
    @assert n<size(x,1) && n>1 "Argument n is out of bounds."
    out = zeros(size(x))
    out[1:n-1] .= NaN
    if cumulative
        fi = 1.0:size(x,1)
        @inbounds for i = n:size(x,1)
            out[i] = sum(x[1:i])/fi[i]
        end
    else
        # original shorter but slower version of the code below
        # @inbounds for i = n:size(x,1)
        #     out[i] = mean(x[i-n+1:i])
        # end
        n_current = 0
        s::T = 0
        @inbounds for i = 1:n
            if isfinite(x[i])
                s += x[i]
                n_current += 1
            end
        end
        out[n] = n_current == n ? s / n : NaN
        @inbounds for i = n+1:size(x,1)
            if isfinite(x[i])
                s += x[i]
                n_current += 1
            end
            if isfinite(x[i-n])
                s -= x[i-n]
                n_current -= 1
            end
            out[i] = (n_current == n) # n_current > 0
                ? s / n_current
                : NaN
        end
    end
    return out
end
"""
```
runsum(x::Array{T}; n::Int64=10, cumulative::Bool=true)::Array{T}
```

Compute a running or rolling summation of an array.
"""
function runsum(x::Array{T}; n::Int64=10, cumulative::Bool=true)::Array{T} where {T<:Real}
    @assert n<size(x,1) && n>1 "Argument n is out of bounds."
    if cumulative
        out = cumsum(x, dims=1)
        out[1:n-1] .= NaN
    else
        out = zeros(size(x))
        out[1:n-1] .= NaN
        # original shorter but slower version of the code below
        # @inbounds for i = n:size(x,1)
        #     out[i] = sum(x[i-n+1:i])
        # end
        n_current = 0
        s::T = 0
        @inbounds for i = 1:n
            if isfinite(x[i])
                s += x[i]
                n_current += 1
            end
        end
        out[n] = n_current == n ? s : NaN
        @inbounds for i = n+1:size(x,1)
            if isfinite(x[i])
                s += x[i]
                n_current += 1
            end
            if isfinite(x[i-n])
                s -= x[i-n]
                n_current -= 1
            end
            out[i] = (n_current == n) # n_current > 0
                ? s
                : NaN
        end
    end
    return out
end
"""
```
wilder_sum(x::Array{T}; n::Int64=10)::Array{T}
```

Welles Wilder summation of an array
"""
function wilder_sum(x::Array{T}; n::Int64=10)::Array{T} where {T<:Real}
    @assert n<size(x,1) && n>0 "Argument n is out of bounds."
    nf = float(n)  # type stability -- all arithmetic done on floats
    out = zeros(size(x))
    out[1] = x[1]
    @inbounds for i = 2:size(x,1)
        out[i] = x[i] + out[i-1]*(nf-1.0)/nf
    end
    return out
end

"""
```
runmad(x::Array{T}; n::Int64=10, cumulative::Bool=true, fun::Function=median)::Array{T}
```

Compute the running or rolling mean absolute deviation of an array
"""
function runmad(x::Array{T}; n::Int64=10, cumulative::Bool=true, fun::Function=median)::Array{T} where {T<:Real}
    @assert n<size(x,1) && n>1 "Argument n is out of bounds."
    out = zeros(size(x))
    out[1:n-1] .= NaN
    center = 0.0
    if cumulative
        fi = collect(1.0:size(x,1))
        @inbounds for i = n:size(x,1)
            center = fun(x[1:i])
            out[i] = sum(abs.(x[1:i].-center)) / fi[i]
        end
    else
        fn = float(n)
        @inbounds for i = n:size(x,1)
            center = fun(x[i-n+1:i])
            out[i] = sum(abs.(x[i-n+1:i].-center)) / fn
        end
    end
    return out
end

"""
```
runvar(x::Array{T}; n::Int64=10, cumulative=true)::Array{T}
```

Compute the running or rolling variance of an array
"""
function runvar(x::Array{T}; n::Int64=10, cumulative=true)::Array{T} where {T<:Real}
    @assert n<size(x,1) && n>1 "Argument n is out of bounds."
    out = zeros(size(x))
    out[1:n-1] .= NaN
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

"""
```
runsd(x::Array{T}; n::Int64=10, cumulative::Bool=true)::Array{T}
```

Compute the running or rolling standard deviation of an array
"""
function runsd(x::Array{T}; n::Int64=10, cumulative::Bool=true)::Array{T} where {T<:Real}
    return sqrt.(runvar(x, n=n, cumulative=cumulative))
end

"""
```
runcov(x::Array{T}, y::Array{T}; n::Int64=10, cumulative::Bool=true)::Array{T}
```

Compute the running or rolling covariance of two arrays
"""
function runcov(x::Array{T}, y::Array{T}; n::Int64=10, cumulative::Bool=true)::Array{T} where {T<:Real}
    @assert length(x) == length(y) "Dimension mismatch: length of `x` not equal to length of `y`."
    @assert n<size(x,1) && n>1 "Argument n is out of bounds."
    out = zeros(size(x))
    out[1:n-1] .= NaN
    if cumulative
        @inbounds for i = n:length(x)
            out[i] = cov(x[1:i], y[1:i])
        end
    else
        @inbounds for i = n:length(x)
            out[i] = cov(x[i-n+1:i], y[i-n+1:i])
        end
    end
    return out
end

"""
```
runcor(x::Array{T}, y::Array{T}; n::Int64=10, cumulative::Bool=true)::Array{T}
```

Compute the running or rolling correlation of two arrays
"""
function runcor(x::Array{T}, y::Array{T}; n::Int64=10, cumulative::Bool=true)::Array{T} where {T<:Real}
    @assert length(x) == length(y) "Dimension mismatch: length of `x` not equal to length of `y`."
    @assert n<size(x,1) && n>1 "Argument n is out of bounds."
    out = zeros(size(x))
    out[1:n-1] .= NaN
    if cumulative
        @inbounds for i = n:length(x)
            out[i] = cor(x[1:i], y[1:i])
        end
    else
        @inbounds for i = n:length(x)
            out[i] = cor(x[i-n+1:i], y[i-n+1:i])
        end
    end
    return out
end

"""
```
runmax(x::Array{T}; n::Int64=10, cumulative::Bool=true, inclusive::Bool=true)::Array{T}
```

Compute the running or rolling maximum of an array
"""
function runmax(x::Array{T}; n::Int64=10, cumulative::Bool=true, inclusive::Bool=true)::Array{T} where {T<:Real}
    @assert n<size(x,1) && n>1 "Argument n is out of bounds."
    out = zeros(size(x))
    if inclusive
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
        out[1:n-1] .= NaN
        return out
    else
        if cumulative
            out[n+1] = maximum(x[1:n])
            @inbounds for i = n+1:size(x,1)-1
                out[i+1] = max(out[i-1], x[i-1])
            end
        else
            @inbounds for i = n:size(x,1)-1
                out[i+1] = maximum(x[i-n+1:i])
            end
        end
        out[1:n] .= NaN
        return out
    end
end

"""
```
runmin(x::Array{T}; n::Int64=10, cumulative::Bool=true, inclusive::Bool=true)::Array{T}
```

Compute the running or rolling minimum of an array
"""
function runmin(x::Array{T}; n::Int64=10, cumulative::Bool=true, inclusive::Bool=true)::Array{T} where {T<:Real}
    @assert n<size(x,1) && n>1 "Argument n is out of bounds."
    out = zeros(size(x))
    if inclusive
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
        out[1:n-1] .= NaN
        return out
    else
        if cumulative
            out[n+1] = minimum(x[1:n])
            @inbounds for i = n+1:size(x,1)-1
                out[i+1] = min(out[i-1], x[i-1])
            end
        else
            @inbounds for i = n:size(x,1)-1
                out[i+1] = minimum(x[i-n+1:i])
            end
        end
        out[1:n] .= NaN
        return out
    end
end

"""
```
runquantile(x::Vector{T}; p::T=0.05, n::Int=10, cumulative::Bool=true)::Vector{T}
```

Compute the running/rolling quantile of an array
"""
function runquantile(x::Array{T}; p::T=0.05, n::Int=10, cumulative::Bool=true)::Array{T} where {T<:Real}
    @assert n<size(x,1) && n>1 "Argument n is out of bounds."
    out = zeros(T, (size(x,1), size(x,2)))
    if cumulative
        @inbounds for j in 1:size(x,2), i in 2:size(x,1)
            out[i,j] = quantile(x[1:i,j], p)
        end
        out[1,:] .= NaN
    else
        @inbounds for j in 1:size(x,2), i in n:size(x,1)
            out[i,j] = quantile(x[i-n+1:i,j], p)
        end
        out[1:n-1,:] .= NaN
    end
    return out
end


"""
```
function runacf(x::Array{T};
                n::Int = 10,
                maxlag::Int = n-3,
                lags::AbstractArray{Int,1} = 0:maxlag,
                cumulative::Bool = true)::Matrix{T} where {T<:Real}
```

Compute the running/rolling autocorrelation of a vector.
"""
function runacf(x::Array{T};
                n::Int = 10,
                maxlag::Int = n-3,
                lags::AbstractArray{Int,1} = 0:maxlag,
                cumulative::Bool = true)::Matrix{T} where {T<:Real}
    @assert size(x, 2) == 1 "Autocorrelation input array must be one-dimensional"
    N = size(x, 1)
    @assert n < N && n > 0
    if length(lags) == 1 && lags[1] == 0
        return ones((N, 1))
    end
    out = zeros((N, length(lags))) * NaN
    if cumulative
        @inbounds for i in n:N
            out[i,:] = acf(x[1:i], lags=lags)
        end
    else
        @inbounds for i in n:N
            out[i,:] = acf(x[i-n+1:i], lags=lags)
        end
    end
    return out
end

"""
```
runfun(x::Array{T}, f::Function; n::Int = 10, args...)
```

Apply a general function `f` that returns a scalar over an array
"""
function runfun(x::Array{T}, f::Function; n::Int = 10, cumulative::Bool=false, args...)::Array{T} where {T<:Real}
    N = size(x,1)
    out = zeros(T, N) .* NaN
    if cumulative
        for i in n:N
            result::T = f(x[1:i]; args...)
            out[i] = result
        end
    else
        for i in n:N
            result::T = f(x[i-n+1:i]; args...)
            out[i] = result
        end
    end
    return out
end
