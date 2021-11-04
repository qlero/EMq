### Content

This repository contains:

- The implementation from-scratch of an example bivariate EM algorithm that is robust to missing values, i.e. NAs, in both variables.
- A few 'tutorial' examples from [Q for Mortals](https://code.kx.com/q4m3/) and an awesome [lecture](https://youtu.be/ZGIPmC6wi7E) by Tim Thornton.

### Formulas used to compute the Expectation-Maximization Algorithm

#### Expectation step

There are $m$ elements with missing data out of $n$ elements.

\begin{align}
s_1 &= \sum^n_{i=m+1}x_{i,1} + \sum^m_{i=1}\big(\mu_1+\frac{\sigma_{1,2}}{\sigma_{2,2}}(x_{i,2} - \mu_2)\big)\\
s_{1,1} &= \sum^n_{i=m+1}x_{i,1}^2 + \sum^m_{i=1}\big(\big(\mu_1+\frac{\sigma_{1,2}}{\sigma_{2,2}}(x_{i,2} - \mu_2)\big)^2 + \sigma_{1,1} - \frac{\sigma_{1,2}^2}{\sigma_{2,2}}\big)\\
s_2 &= \sum^n_{i=m+1}x_{i,2} + \sum^m_{i=1}\big(\mu_2+\frac{\sigma_{2,1}}{\sigma_{1,1}}(x_{i,1} - \mu_1)\big)\\
s_{2,2} &= \sum^n_{i=m+1}x_{i,2}^2 + \sum^m_{i=1}\big(\big(\mu_2+\frac{\sigma_{2,1}}{\sigma_{1,1}}(x_{i,1} - \mu_1)\big)^2 + \sigma_{2,2} - \frac{\sigma_{2,1}^2}{\sigma_{1,1}}\big)\\
s_{1,2} &= \sum^n_{i=m+1}x_{i,1}.x_{i,2}+\sum^m_{i=1}x_{i,1}\big(\mu_2+\frac{\sigma_{2,1}}{\sigma_{1,1}}(x_{i,1}-\mu_1)\big)\\
\end{align}

#### Maximization step

We update the parameters such that:

\begin{align}
\mu_1&=\frac{s_1}{n}\\
\mu_2&=\frac{s_2}{n}\\
\sigma_{1,1}&=\frac{s_{1,1}}{n}-(\mu_1)^2\\
\sigma_{2,2}&=\frac{s_{2,2}}{n}-(\mu_2)^2\\
\sigma_{1,2}&=\frac{s_{1,2}}{n}-(\mu_1.\mu_2)\\
\end{align}
