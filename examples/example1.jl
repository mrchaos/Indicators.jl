using Indicators
using PyPlot
using Base.Dates

srand(1)
n = 250
X = 100.0 + cumsum(rand(n,3)-rand(n,3))
x = X[:,1]
t = collect(today():Day(1):today()+Day(n-1))

subplot(311)
plot(t, x, lw=2, c="k", label="Random Walk")
grid(ls="-", c=[0.8,0.8,0.8])
plot(t, sma(x,40), c=[1,0.5,0], label="SMA (40)")
plot(t, ema(x,10), c=[0,1,1], label="EMA (10)")
plot(t, wma(x,20), c=[1,0,1], label="WMA (20)")
legend(loc="best", frameon=false)

subplot(312)
tmp = macd(x)
plot(t, tmp[:,1], label="MACD", c=[1,0.5,1])
plot(t, tmp[:,2], label="Signal", c=[0.5,0.25,0.5])
bar(t, tmp[:,3], align="center", label="Histogram", color=[0,0.5,0.5], alpha=0.25)
plot([t[1],t[end]], [0,0], ls="--", c=[0.5,0.5,0.5])
grid(ls="-", c=[0.8,0.8,0.8])
legend(loc="best", frameon=false)

subplot(313)
plot(t, rsi(x), c=[0.5,0.5,0], label="RSI")
grid(ls="-", c=[0.8,0.8,0.8])
plot([t[1],t[end]], [30,30], c="g")
plot([t[1],t[end]], [70,70], c="r")
legend(loc="best", frameon=false)

tight_layout()
