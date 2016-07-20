using Temporal
using Indicators
using PyPlot

X = tsread("/julia/packages/v0.4/temporal/data/corn.csv")
x = X["2015-03/", :Settle]

x.fields = [:Corn]
plot(x.index, x.values, label="Corn", lw=3, color="blue")
grid(true, ls="-", color="black", alpha=0.25)

# First-order trendlines
maxi = maxlocal(x)
mini = minlocal(x)
plot(x[maxi].index, x[maxi].values, label="Resistance", color="red", marker="o")
plot(x[mini].index, x[mini].values, label="Support", color="green", marker="o")

# Second-order trendlines
maxi = [x maxlocal(x[maxi])][:,2]
mini = [x minlocal(x[mini])][:,2]
maxi.values[isnan(maxi.values)] = 0.0
mini.values[isnan(mini.values)] = 0.0
maxi = ts(bool(maxi.values), maxi.index, maxi.fields)
mini = ts(bool(mini.values), mini.index, mini.fields)
plot(x[maxi].index, x[maxi].values, color="red", marker="o")
plot(x[mini].index, x[mini].values, color="green", marker="o")

# Third-order trendlines
maxi = [x maxlocal(x[maxi])][:,2]
mini = [x minlocal(x[mini])][:,2]
maxi.values[isnan(maxi.values)] = 0.0
mini.values[isnan(mini.values)] = 0.0
maxi = ts(bool(maxi.values), maxi.index, maxi.fields)
mini = ts(bool(mini.values), mini.index, mini.fields)
plot(x[maxi].index, x[maxi].values, color="red", marker="o")
plot(x[mini].index, x[mini].values, color="green", marker="o")

legend(loc="best", frameon=false)

tight_layout()
