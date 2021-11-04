### Content

This repository contains:

- The implementation from-scratch of an example bivariate EM algorithm that is robust to missing values, i.e. NAs, in both variables.
- A few 'tutorial' examples from [Q for Mortals](https://code.kx.com/q4m3/) and an awesome [lecture](https://youtu.be/ZGIPmC6wi7E) by Tim Thornton.

### Formulas used to compute the Expectation-Maximization Algorithm

#### Expectation step

There are **m** elements with missing data out of **n** elements.

![Estep](images/Estep.png#center)

#### Maximization step

We update the parameters such that:

![Mstep](images/Mstep.png#center)
