# workspace()
using Indicators
using PyPlot
using Base.Dates

aapl = readcsv("test/aapl-2015.csv", header=true)[1]
op = aapl[:,1]
hi = aapl[:,2]
lo = aapl[:,3]
cl = aapl[:,4]
vo = aapl[:,5]
ti = Date("2015-01-02"):Day(1):Date("2015-01-02")+Day(size(aapl,1)-1)
t = collect(ti)

subplot(211)
plot(t, cl, lw=2, c="k", label="AAPL")
plot(t, mama(cl)[:,1], c="m", label="MAMA")
plot(t, mama(cl)[:,2], c="c", label="FAMA")
plot(t, trima(cl), c="g", label="Triangula MA")
plot(t, hma(cl), c="r", label="Hull MA")
# plot(t, trima(cl), c="c", label="Triangular MA")
# plot(t, hma(cl), c="g", label="Hull MA")
# plot(t, dema(cl), c="r", label="Double Exp MA")
grid(ls="-", c=[0.8,0.8,0.8])
legend(loc="best", frameon=false)

subplot(212)
plot(t, kst(cl), c="m", label="KST")
plot(t, sma(kst(cl),9), c="c", label="Signal")
plot([t[1],t[end]], [0,0], ls="--", c=[0.4,0.4,0.4])
grid(ls="-", c=[0.8,0.8,0.8])
legend(loc="best", frameon=false)

tight_layout()
