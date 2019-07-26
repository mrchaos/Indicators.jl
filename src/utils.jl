# Miscellaneous utilities

"""
```
crossover(x::Array{T}, y::Array{T}) where {T<:Real}
```

Find where `x` crosses over `y` (returns boolean vector where crossover occurs)
"""
function crossover(x::Array{T}, y::Array{T}) where {T<:Real}
    @assert size(x,1) == size(y,1)
    out = falses(size(x))
    @inbounds for i in 2:size(x,1)
        out[i] = ((x[i] > y[i]) && (x[i-1] < y[i-1]))
    end
    return out
end

"""
```
crossunder(x::Array{T}, y::Array{T}) where {T<:Real}
```

Find where `x` crosses under `y` (returns boolean vector where crossunder occurs)
"""
function crossunder(x::Array{T}, y::Array{T}) where {T<:Real}
    @assert size(x,1) == size(y,1)
    out = falses(size(x))
    @inbounds for i in 2:size(x,1)
        out[i] = ((x[i] < y[i]) && (x[i-1] > y[i-1]))
    end
    return out
end
