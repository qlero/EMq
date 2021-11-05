### Content

This repository contains:

- The implementation from-scratch of an example bivariate EM algorithm that is robust to missing values, i.e. NAs, in both variables.
- A few 'tutorial' examples from [Q for Mortals](https://code.kx.com/q4m3/) and an awesome [lecture](https://youtu.be/ZGIPmC6wi7E) by Tim Thornton.

#### Note

For easiness of reading the algorithm, present in the ``EMq.q`` file, we only consider here the construction of a single bivariate distribution starting with the sample mean and covariance matrix of the whole Wine dataset (here restricted to the feature Alcohol and Malic.Acid).

In a more authentic case, we would compute a sample mean and covariance matrix for each of the 3 types of wine present in the dataset and compute the EM algorithm over each of them. Doing so would approximate, up to a local optimum, the distribution of each population as a Gaussian.

### Formulas used to compute the Expectation-Maximization Algorithm

#### Expectation step

There are **m** elements with missing data out of **n** elements.

![Estep](images/Estep.png#center)

#### Maximization step

We update the parameters such that:

![Mstep](images/Mstep.png#center)
