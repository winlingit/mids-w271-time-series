### Week 1

# probability mass functions
pmf1 = dbinom(x=0:10, size=10, prob=0.2)
pmf2 = dbinom(x=0:10, size=10, prob=0.8)

# data.frame with PMFs
pmf.df = data.frame(w=0:10, prob1=round(x=pmf1, digits=4), prob2=round(x=pmf2, digits=2))

print(pmf.df)






