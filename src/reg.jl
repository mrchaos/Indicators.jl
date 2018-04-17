@doc doc"""
Moving linear regression intercept (column 1) and slope (column 2)

`mlr_beta{Float64}(y::Array{Float64}; n::Int64=10)::Array{Float64}`
""" ->
function mlr_beta{Float64}(y::Array{Float64}; n::Int64=10, x::Array{Float64}=collect(1.0:n))::Matrix{Float64}
    @assert n<length(y) && n>0 "Argument n out of bounds."
    @assert size(x,1) == n
    out = zeros(Float64, (length(y),2))
    out[1:n-1,:] = NaN
    xbar = mean(x)
    ybar = runmean(y, n=n, cumulative=false)
    @inbounds for i = n:length(y)
        yi = y[i-n+1:i]
        out[i,2] = cov(x,yi) / var(x)
        out[i,1] = ybar[i] - out[i,2]*xbar
    end
    return out
end

@doc doc"""
Moving linear regression slope

`mlr_slope{Float64}(y::Array{Float64}; n::Int64=10)::Array{Float64}`
""" ->
function mlr_slope{Float64}(y::Array{Float64}; n::Int64=10, x::Array{Float64}=collect(1.0:n))::Array{Float64}
    @assert n<length(y) && n>0 "Argument n out of bounds."
    @assert size(x,1) == n
    out = zeros(y)
    out[1:n-1] = NaN
    @inbounds for i = n:length(y)
        yi = y[i-n+1:i]
        out[i] = cov(x,yi) / var(x)
    end
    return out
end

@doc doc"""
Moving linear regression y-intercept

`mlr_intercept{Float64}(y::Array{Float64}; n::Int64=10)::Array{Float64}`
""" ->
function mlr_intercept{Float64}(y::Array{Float64}; n::Int64=10, x::Array{Float64}=collect(1.0:n))::Array{Float64}
    @assert n<length(y) && n>0 "Argument n out of bounds."
    @assert size(x,1) == n
    out = zeros(y)
    out[1:n-1] = NaN
    xbar = mean(x)
    ybar = runmean(y, n=n, cumulative=false)
    @inbounds for i = n:length(y)
        yi = y[i-n+1:i]
        out[i] = ybar[i] - xbar*(cov(x,yi)/var(x))
    end
    return out
end

@doc doc"""
Moving linear regression predictions

`mlr{Float64}(y::Array{Float64}; n::Int64=10)::Array{Float64}`
""" ->
function mlr{Float64}(y::Array{Float64}; n::Int64=10)::Array{Float64}
    b = mlr_beta(y, n=n)
    return b[:,1] + b[:,2]*float(n)
end

@doc doc"""
Moving linear regression standard errors

`mlr_se{Float64}(y::Array{Float64}; n::Int64=10)::Array{Float64}`
""" ->
function mlr_se{Float64}(y::Array{Float64}; n::Int64=10)::Array{Float64}
    yhat = mlr(y, n=n)
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
Moving linear regression upper bound

`mlr_ub{Float64}(y::Array{Float64}; n::Int64=10, se::Float64=2.0)::Array{Float64}`
""" ->
function mlr_ub{Float64}(y::Array{Float64}; n::Int64=10, se::Float64=2.0)::Array{Float64}
    return y + se*mlr_se(y, n=n)
end

@doc doc"""
Moving linear regression lower bound

`mlr_lb{Float64}(y::Array{Float64}; n::Int64=10, se::Float64=2.0)::Array{Float64}`
""" ->
function mlr_lb{Float64}(y::Array{Float64}; n::Int64=10, se::Float64=2.0)::Array{Float64}
    return y - se*mlr_se(y, n=n)
end

@doc doc"""
Moving linear regression bands

`mlr_bands{Float64}(y::Array{Float64}; n::Int64=10, se::Float64=2.0)::Matrix{Float64}`


*Output:*

Column 1: Lower bound

Column 2: Regression estimate

Column 3: Upper bound
""" ->
function mlr_bands{Float64}(y::Array{Float64}; n::Int64=10, se::Float64=2.0)::Matrix{Float64}
    out = zeros(Float64, (length(y),3))
    out[1:n-1,:] = NaN
    out[:,2] = mlr(y, n=n)
    out[:,1] = mlr_lb(y, n=n, se=se)
    out[:,3] = mlr_ub(y, n=n, se=se)
    return out
end

@doc doc"""
Moving linear regression R-squared or adjusted R-squared

`mlr_rsq{Float64}(y::Array{Float64}; n::Int64=10, adjusted::Bool=false)::Array{Float64}`
""" ->
function mlr_rsq{Float64}(y::Array{Float64}; n::Int64=10, adjusted::Bool=false)::Array{Float64}
    yhat = mlr(y, n=n)
    rsq = runcor(y, yhat, n=n, cumulative=false) .^ 2
    if adjusted
        return rsq - (1.0-rsq)*(1.0/(float(n)-2.0))
    else
        return rsq
    end
end

