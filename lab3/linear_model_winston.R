## old method from CM2009 5.6
t = time(unemp.ts)
month = cycle(unemp.ts)

# fit linear model w/ entire data set
fit.lm = lm(unemp.ts ~ 0 + t + factor(month))
summary(fit.lm)

# check residuals - normally distributed
plot(fit.lm$residuals)  # residuals are not white noise
hist(fit.lm$residuals)
qqnorm(fit.lm$residuals)
acf2(fit.lm$residuals)

# OLS forecast 1 year
new.t2y = seq(2016, len=24, by=1/12)
new.month2y = rep(1:12, 2)
new.dat = data.frame(t = new.t2y, month = new.month2y)
for2y.lm = predict(fit.lm, newdata = new.dat)
accuracy(for2y.lm, unemp.test)

# plot actuals and predicted for test period
for2y.lm.ts = ts(for2y.lm, start=c(2016,1), frequency=12)
comp = ts.intersect(unemp.test, for2y.lm.ts)
ts.plot(comp, lty=c(1,2), main='Monthly unemployment rate, January 2016 - June 2017: Actuals and Forecast', ylab='Unemployment rate (%)')

# OLS forecast 4 years
new.t5y = seq(2016, len=60, by=1/12)
new.month5y = rep(1:12, 5)
new.dat = data.frame(t = new.t5y, month = new.month5y)
for5y.lm = predict(fit.lm, newdata = new.dat, se.fit=T)

for5y.lm.ts = ts(for5y.lm$fit, start=c(2016,1), frequency=12)
tail(for5y.lm.ts)

# forecast confidence intervals
lower = ts(for5y.lm$fit - 2*for5y.lm$se.fit, start=c(2016,1), frequency=12)
upper = ts(for5y.lm$fit + 2*for5y.lm$se.fit, start=c(2016,1), frequency=12)

# plot forecasts and confidence intervals for test period
comp = ts.intersect(for5y.lm.ts, lower, upper)
ts.plot(comp, lty=c(1,2,2))
