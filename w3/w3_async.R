### Week 3

placekick<-read.table(file = "/Users/winlin/Desktop/w271-time-series/programs/Chapter2/Placekick.csv", header = TRUE, sep = ",")
head(placekick)
tail(placekick)

w<-aggregate(formula = good ~ distance, data = placekick, FUN = sum)
n<-aggregate(formula = good ~ distance, data = placekick, FUN = length)
w.n<-data.frame(distance = w$distance, success = w$good, trials = n$good, proportion = round(w$good/n$good,4))
head(w.n)
tail(w.n)

mod.fit = glm(formula = good ~ distance, family = binomial(link = logit), data = placekick)
mod.fit.distsq = glm(formula = good ~ distance + I(distance^2), family = binomial(link = logit), data = placekick)
summary(mod.fit.distsq)

x11(width = 7, height = 6, pointsize = 12)

symbols(x = w$distance, y = w$good/n$good, circles = sqrt(n$good), inches = 0.5, xlab = "Distance (yards)", ylab = "Estimated probability",
        panel.first = grid(col = "gray", lty = "dotted"))

# Put estimated logistic regression model on the plot
curve(expr = predict(object = mod.fit.distsq, newdata = data.frame(distance = x), type = "response"), col = "red", add = TRUE,
      xlim = c(18, 66))

# Put estimated logistic regression model on the plot
curve(expr = predict(object = mod.fit, newdata = data.frame(distance = x), type = "response"), col = "blue", add = TRUE,
      xlim = c(18, 66))

legend(x = 20, y = 0.4, legend = c("linear term only", "linear and quadratic term"), lty = c("solid", "solid"), col = c("red", "blue"), bty = "n")