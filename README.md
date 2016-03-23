# Indicators

Indicators is a Julia package offering efficient implementations of many technical analysis indicators and algorithms. This work is inspired by the [TTR](https://github.com/joshuaulrich/TTR) package in R and the Python implementation of [TA-Lib](https://github.com/mrjbq7/ta-lib), and the ultimate goal is to implement all of the functionality of these offerings (and more) in Julia.

![alt text](https://raw.githubusercontent.com/dysonance/Indicators.jl/master/examples/example1.png "Example 1")

## Implemented
### Moving Averages
- SMA (simple moving average)
- WMA (weighted moving average)
- EMA (exponential moving average)
- TRIMA (triangular moving average)
- KAMA (Kaufman adaptive moving average)
- MAMA (MESA adaptive moving average, developed by John Ehlers)
- HMA (Hull moving average)
- SWMA (sine-weighted moving average)
- DEMA (double exponential moving average)
- TEMA (tripe exponential moving average)

### Momentum Indicators
- MACD (moving average convergence-divergence)
- RSI (relative strength index)
- ADX (average directional index)
- Parabolic SAR (stop and reverse)
- ROC (rate of change)
- KST (Know Sure Thing)

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
- Moving Linear Regression
- VWMA (volume-weighted moving average)
- ~~DEMA (double exponential moving average)~~
- ~~TEMA (tripe exponential moving average)~~
- ~~Parabolic SAR~~
- Williams %R
- CCI (commodity channel index)
- ~~KST (know sure thing)~~
- Donchian Channel
- ALMA (Arnaud Legoux moving average)
- VWAP (volume-weighted average price)
- ZLEMA (zero lag exponential moving average)
- EVWMA (elastic, volume-weighted moving average)
- VMA (variable-length moving average)
- ~~KAMA (Kaufman adaptive moving average)~~
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

[![Build Status](https://travis-ci.org/dysonance/Indicators.jl.svg?branch=master)](https://travis-ci.org/dysonance/Indicators.jl)
