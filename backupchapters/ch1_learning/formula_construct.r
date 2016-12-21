library(latex2exp)
svg('formula_labelled_revised.svg')
form = '$\\hat{Y} = \\hat{\\beta_{0}} + \\sum_{j=1}^{p}X_j\\hat{\\beta_{j}}$'
labs = c('number of columns in the dataset', 'rows of the dataset', 'estimated parameters of the model', 'the intercept', 'index to parameters of the model\nand columns of the dataset', 'predicted values', 'summation operator', 'implicit inner product operator')
plot(TeX(form))
text(x=0.25,y=seq(0.1,0.7, 0.1), labels=labs)
dev.off()
