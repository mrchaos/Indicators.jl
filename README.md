# Indicators

Indicators is a Julia package offering efficient implementations of many technical analysis indicators and algorithms. This work is inspired by the [TTR](https://github.com/joshuaulrich/TTR) package in R and the Python implementation of [TA-Lib](https://github.com/mrjbq7/ta-lib), and the ultimate goal is to implement all of the functionality of these offerings (and more) in Julia.

## Implemented
### Moving Averages
- SMA (simple moving average)
- WMA (weighted moving average)
- EMA (exponential moving average)
- TRIMA (triangular moving average)
- KAMA (Kaufman adaptive moving average)
- MAMA (MESA adaptive moving average, developed by John Ehlers)
- HMA (Hull moving average)
- ALMA (Arnaud-Legoux moving average)
- SWMA (sine-weighted moving average)
- DEMA (double exponential moving average)
- TEMA (tripe exponential moving average)
- MLR (moving linear regression)
    - Prediction
    - Slope
    - Intercept
    - Standard error
    - Upper & lower bound
    - R-squared

### Momentum Indicators
- MACD (moving average convergence-divergence)
- RSI (relative strength index)
- ADX (average directional index)
- Parabolic SAR (stop and reverse)
- ROC (rate of change)
- KST (Know Sure Thing)
- Williams %R
- CCI (commodity channel index)

### Volatility Indicators
- Bollinger Bands
- Average True Range
- Keltner Bands

### Other
- Rolling/running mean
- Rolling/running standard deviation
- Rolling/running variance
- Rolling/running covariance
- Rolling/running correlation
- Rolling/running maximum
- Rolling/running minimum
- Rolling/running MAD (mean absolute deviation)
- n-period lag and difference


## Todo
- ~~Moving Linear Regression~~
- ~~KAMA (Kaufman adaptive moving average)~~
- ~~DEMA (double exponential moving average)~~
- ~~TEMA (tripe exponential moving average)~~
- ~~ALMA (Arnaud Legoux moving average)~~
- Hamming moving average
- MMA (modified moving average)
- VWMA (volume-weighted moving average)
- VWAP (volume-weighted average price)
- ZLEMA (zero lag exponential moving average)
- EVWMA (elastic, volume-weighted moving average)
- VMA (variable-length moving average)
- ~~Parabolic SAR~~
- ~~Williams %R~~
- ~~KST (know sure thing)~~
- ~~CCI (commodity channel index)~~
- Donchian Channel
- Aroon Indicator / Aroon Oscillator
- Chaikin Money Flow
- ~~ROC (rate of change)~~
- Momentum
- Stochastics
  - Slow Stochastics
  - Fast Stochastics
  - Stochastic Momentum Index
- Ultimate Oscillator
- OBV (on-balance volume)
- Too many more to name...

# Examples
#### Randomly generated data:
![alt text](https://raw.githubusercontent.com/dysonance/Indicators.jl/master/examples/example1.png "Example 1")

#### Apple (AAPL) daily data from 2015:
![alt text](https://raw.githubusercontent.com/dysonance/Indicators.jl/master/examples/example2.png "Example 2")


[![Build Status](https://travis-ci.org/dysonance/Indicators.jl.svg?branch=master)](https://travis-ci.org/dysonance/Indicators.jl)
