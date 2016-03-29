@doc doc"""
mlr_beta{Float64}(y::Vector{Float64}, n::Int64=10)

Moving linear regression intercept (column 1) and slope (column 2)
""" ->
function mlr_beta{Float64}(y::Vector{Float64}, n::Int64=10)
    @assert n<length(y) && n>0 "Argument n out of bounds."
    out = zeros(Float64, (length(y),2))
    out[1:n-1,:] = NaN
    xi = collect(1.0:n)
    xbar = mean(xi)
    ybar = runmean(y, n, false)
    @inbounds for i = n:length(y)
        yi = y[i-n+1:i]
        out[i,2] = cov(xi,yi) / var(xi)
        out[i,1] = ybar[i] - out[i,2]*xbar
    end
    return out
end

@doc doc"""
mlr_slope{Float64}(y::Vector{Float64}, n::Int64=10)

Moving linear regression slope
""" ->
function mlr_slope{Float64}(y::Vector{Float64}, n::Int64=10)
    @assert n<length(y) && n>0 "Argument n out of bounds."
    out = zeros(y)
    out[1:n-1] = NaN
    xi = collect(1.0:n)
    @inbounds for i = n:length(y)
        yi = y[i-n+1:i]
        out[i] = cov(xi,yi) / var(xi)
    end
    return out
end

@doc doc"""
mlr_intercept{Float64}(y::Vector{Float64}, n::Int64=10)

Moving linear regression y-intercept
""" ->
function mlr_intercept{Float64}(y::Vector{Float64}, n::Int64=10)
    @assert n<length(y) && n>0 "Argument n out of bounds."
    out = zeros(y)
    out[1:n-1] = NaN
    xi = collect(1.0:n)
    xbar = mean(xi)
    ybar = runmean(y, n, false)
    @inbounds for i = n:length(y)
        yi = y[i-n+1:i]
        out[i] = ybar[i] - xbar*(cov(xi,yi)/var(xi))
    end
    return out
end

@doc doc"""
mlr{Float64}(y::Vector{Float64}, n::Int64=10)

Moving linear regression estimates
""" ->
function mlr{Float64}(y::Vector{Float64}, n::Int64=10)
    b = mlr_beta(y, n)
    return b[:,1] + b[:,2]*float(n)
end

@doc doc"""
mlr_se{Float64}(y::Vector{Float64}, n::Int64=10)

Moving linear regression standard error of estimate
""" ->
function mlr_se{Float64}(y::Vector{Float64}, n::Int64=10)
    yhat = mlr(y, n)
    r = zeros(Float64, n)
    out = zeros(y)
    out[1:n-1] = NaN
    nf = float(n)
    @inbounds for i = n:length(y)
        r = y[i-n+1:i] - yhat[i]
        out[i] = sqrt(sum(r.^2)/nf)
    end
    return out
end

@doc doc"""
mlr_ub{Float64}(y::Vector{Float64}, n::Int64=10, se::Float64=2.0)

Moving linear regression upper bound
""" ->
function mlr_ub{Float64}(y::Vector{Float64}, n::Int64=10, se::Float64=2.0)
    return y + se*mlr_se(y,n)
end

@doc doc"""
mlr_lb{Float64}(y::Vector{Float64}, n::Int64=10, se::Float64=2.0)

Moving linear regression lower bound
""" ->
function mlr_lb{Float64}(y::Vector{Float64}, n::Int64=10, se::Float64=2.0)
    return y - se*mlr_se(y,n)
end

@doc doc"""
mlr_bands{Float64}(y::Vector{Float64}, n::Int64=10, se::Float64=2.0)

Moving linear regression bands

`Output:`

Column 1: Lower bound

Column 2: Regression estimate

Column 3: Upper bound
""" ->
function mlr_bands{Float64}(y::Vector{Float64}, n::Int64=10, se::Float64=2.0)
    out = zeros(Float64, (length(y,3)))
    out[1:n-1,:] = NaN
    out[:,2] = mlr(y, n)
    out[:,1] = mlr_lb(y, n, se)
    out[:,1] = mlr_ub(y, n, se)
end

@doc doc"""
mlr_rsq{Float64}(y::Vector{Float64}, n::Int64=10; adjusted::Bool=false)

Moving linear regression R-squared (and adjusted R-squared)
""" ->
function mlr_rsq{Float64}(y::Vector{Float64}, n::Int64=10; adjusted::Bool=false)
    yhat = mlr(y, n)
    rsq = runcor(y, yhat, n, false) .^ 2
    if adjusted
        return rsq - (1.0-rsq)*(1.0/(float(n)-2.0))
    else
        return rsq
    end
end

