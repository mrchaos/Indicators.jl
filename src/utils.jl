# Miscellaneous utilities

@doc """
crossover{Float64}(x::Array{Float64}, y::Array{Float64})

Find where `x` crosses over `y` (returns boolean vector where crossover occurs)
""" ->
function crossover{Float64}(x::Array{Float64}, y::Array{Float64})
    @assert size(x,1) == size(y,1)
    out = falses(x)
    @inbounds for i in 2:size(x,1)
        out[i] = ((x[i] > y[i]) && (x[i-1] < y[i-1]))
    end
    return out
end

@doc """
crossunder{Float64}(x::Array{Float64}, y::Array{Float64})

Find where `x` crosses under `y` (returns boolean vector where crossunder occurs)
""" ->
function crossunder{Float64}(x::Array{Float64}, y::Array{Float64})
    @assert size(x,1) == size(y,1)
    out = falses(x)
    @inbounds for i in 2:size(x,1)
        out[i] = ((x[i] < y[i]) && (x[i-1] > y[i-1]))
    end
    return out
end
