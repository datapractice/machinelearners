Let us stick with Nie's example of house prices in order to concretise what descriptive practices (of the kind that admit reality as multiple, abstractions as concretely relevant, and computation as affectively expansive not restrictive) might look like in `R` work with data. House price data is possibly a worst case example, since house prices seem so heavily webbed into employment, salaries, class position, and business as usual. Is it possible to describe  predictive modelling of house prices in a way that responds to what Mol, Whitehead and Wilson propose? Could house price data engage us in something more than working out what to buy or when to sell? House price datasets appear quite often in machine learning research and tutorials. (The most well-known is the Boston House Price dataset dating from the 1970s [Boston Housing Data](http://archive.ics.uci.edu/ml/datasets/Housing)) The sample shown below comes from San Francisco, prior to the global financial crisis 2007 and its associated sub-prime mortgages. As discussed  below, the dataset comes from an online machine learning course. The dataset is fairly small and simple and can be loaded, summarised and plotted using a few lines of `R` code. 

```{r house_price, echo=TRUE, cache=TRUE, message=FALSE, warning=FALSE, comment=NA, size='smallsize', results='markup' }

    house_prices = read.csv('data/ex1data2.txt', header=FALSE)
    names(house_prices) = c('size', 'bedrooms', 'price')
    head(house_prices)
    summary(house_prices)
    attach(house_prices)
    plot(size, price)
```

Two architectures come together here. On the one hand, around fifty houses  in a city, San Francisco, are described in terms of the number of bedrooms, their total floor area and the price they sold for. This is a very sparse description of domestic urban life, and it reduces the encounter with the psychically rich form of houses/apartments to a cognitive minimum. (The Boston House Price dataset, by comparison, has many more variables and offers a somewhat richer picture.) On the other hand, the description of this encounter has its own architectural forms -- the  pervasive form of the table, grid or, crucially for machine learning,  _matrix_ and the plot that displays values of variables in a geometric sapce. (Whatever else happens to the data in machine learning,  matrix operations and graphic plots remain ever-present. As we will see below, in modelling this data, matrix manipulations will be essential.) So Nie's recommendation of `R` as a way of learning house prices is not unusual. His mention of house price prediction as something that might engage us has many precedents. House price prediction is a surprisingly common teaching or demonstration example in machine learning, alongside other iconic datasets including R.A. Fisher's 'iris', the MNIST handwritten digits dataset [@LeCun_2012]  (derived from U.S. National Institute of Standards and Technology (NIST)), or the cat photo dataset discussed in the previous chapter. 



