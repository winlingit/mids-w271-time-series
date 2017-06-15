library(vcd)

# Week 4 Live Session
df = read.csv('w271_summer2017_anes.csv', header = TRUE, sep = ',')


# EDA of ideology
party.ideo.table = xtabs(~ party + ideo5, data = df)
party.ideo.table

# test independence - strong evidence against independence (p << .05)
ind.test = chisq.test(party.ideo.table, correct = FALSE)
ind.test
assocstats(party.ideo.table)
summary(party.ideo.table)

# check ordered relationship between party and ideology
boxplot(ideo5 ~ party, data = df)
round(prop.table(party.ideo.table, m = 2), 4)


# EDA of crime spend
party.crimespend.table = xtabs(~ party + crimespend, data = df)
party.crimespend.table

# test independence - strong evidence against independence (p << .05)
ind.test = chisq.test(party.crimespend.table, correct = FALSE)
ind.test
assocstats(party.crimespend.table)
summary(party.crimespend.table)

# check ordered relationship between party and crime spend
boxplot(crimespend ~ party, data = df)
round(prop.table(party.crimespend.table, m = 2), 4)

library(car)
library(nnet)
library(MASS)

# nominal model for party and crime spend
mod.nominal = multinom(party ~ crimespend, data = df)
summary(mod.nominal)

# test significance of effect of crime spend in nominal model
Anova(mod.nominal)

# ordinal model
mod.ordinal = polr(as.factor(party) ~ crimespend, data = df, method = 'logistic', Hess = TRUE)
summary(mod.ordinal)

# test significance of effect of crime spend in ordinal model
Anova(mod.ordinal)
