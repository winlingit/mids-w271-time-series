cbe = read.table('./w271-time-series/programs_cowpertwait_metcalfe/cbe.dat', header = T)
head(cbe)
summary(cbe)

elec.ts = ts(cbe[, 3], start = 1958, freq = 12)
beer.ts = ts(cbe[, 2], start = 1958, freq = 12)
choc.ts = ts(cbe[, 1], start = 1958, freq = 12)
plot(cbind(elec.ts, beer.ts, choc.ts))
