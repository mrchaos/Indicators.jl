@doc doc"""
Renko chart patterns

# Methods

- Traditional (Constant Box Size): `renko(x::Vector{Float64}; box_size::Float64=10.0)::Vector{Int}`
- ATR Dynamic Box Size: `renko(hlc::Matrix{Float64}; box_size::Float64=10.0, use_atr::Bool=false, n::Int=14)::Vector{Int}`

# Output

`Vector{Int}` object of size Nx1 (where N is the number rows in `x`) where each element gives the Renko bar number of the corresponding row in `x`.

""" ->
# Renko chart bar identification with traditional methodology (constant box size)
function renko(x::Vector{Float64}; box_size::Float64=10.0)::Vector{Int}
    if box_size < 0.0
        box_size = abs(box_size)
    elseif box_size == 0.0
        error("Argument `box_size` must be nonzero.")
    end
    bar_id = ones(Int, size(x,1))
    ref_pt = x[1]
    @inbounds for i in 2:size(x,1)
        if abs(x[i]-ref_pt) >= box_size
            ref_pt = x[i]
            bar_id[i:end] += 1
        end
    end
end

# Renko chart bar identification with option to use ATR or traditional method (constant box size)
function renko(hlc::Matrix{Float64}; box_size::Float64=10.0, use_atr::Bool=false, n::Int=14)::Vector{Int}
    if use_atr
        bar_id = ones(Int, size(x,1))
        box_sizes = atr(hlc, n=n)
        ref_pt = x[1]
        @inbounds for i in 2:size(x,1)
            if abs(x[i]-ref_pt) >= box_sizes[i]
                ref_pt = x[i]
                bar_id[i:end] += 1
            end
        end
        return bar_id
    else
        return renko(hlc[:,3], box_size=box_size)
    end
end

