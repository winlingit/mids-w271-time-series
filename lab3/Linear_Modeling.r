unemp$DATE <- as.Date(unemp$DATE)
unemp$time <- rank(unemp$DATE)
unemp$month <- months(unemp$DATE)
unemp$year <- ceiling(unemp$time/12)
unemp_test <- unemp[unemp$DATE>"2015-12-01",]
unemp_train <- unemp[unemp$DATE<"2016-01-01",]

mod1 <- lm(UNRATENSA ~ time + month, data = unemp_train)
summary(mod1)
par(mfrow = c(2,2)) 
plot(mod1$residuals, type = "l") 
hist(mod1$residuals) 
acf(mod1$residuals, lag.max = 48) 
pacf(mod1$residuals, lag.max = 48)

plot(unemp_train$UNRATENSA~unemp_train$time, type = "l") + lines(predict(mod1,newdata = unemp_train), col="blue")

test <- data.frame(time = 817:876, month = rep(c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"),5))
accuracy(predict(mod1, newdata = test[1:18,]),unemp_test$UNRATENSA)