using Indicators
using Base.Test

# Read sample data and calculations
const tol = 1e-8
data = X = readcsv("AAPL-2015.csv", header=true)[1]
ma = readcsv("ma.csv", header=true)[1]
o = data[:,1]
h = data[:,2]
l = data[:,3]
c = x = data[:,4]
v = data[:,5]
hlc = data[:,2:4]
ohlc = data[:,1:4]

# Compare against `Indicators` package function results
@test maximum(sma(x)[10:end]-ma[10:end,1]) < tol
@test maximum(ema(x)[10:end]-ma[10:end,2]) < tol
@test maximum(wma(x)[10:end]-ma[10:end,3]) < tol
@test maximum(hma(x)[23:end]-ma[23:end,4]) < tol
