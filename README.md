### Content

This repository contains:

- The implementation from-scratch of an example bivariate EM algorithm that is robust to missing values, i.e. NAs, in both variables.
- A few 'tutorial' examples from [Q for Mortals](https://code.kx.com/q4m3/) and an awesome [lecture](https://youtu.be/ZGIPmC6wi7E) by Tim Thornton.

### Formulas used to compute the Expectation-Maximization Algorithm

#### Expectation step

There are **m** elements with missing data out of **n** elements.

![test](https://latex.codecogs.com/gif.latex?\begin{align}&space;s_1&space;&=&space;\sum^n_{i=m&plus;1}x_{i,1}&space;&plus;&space;\sum^m_{i=1}\big(\mu_1&plus;\frac{\sigma_{1,2}}{\sigma_{2,2}}(x_{i,2}&space;-&space;\mu_2)\big)\notag\\&space;s_{1,1}&space;&=&space;\sum^n_{i=m&plus;1}x_{i,1}^2&space;&plus;&space;\sum^m_{i=1}\big(\big(\mu_1&plus;\frac{\sigma_{1,2}}{\sigma_{2,2}}(x_{i,2}&space;-&space;\mu_2)\big)^2&space;&plus;&space;\sigma_{1,1}&space;-&space;\frac{\sigma_{1,2}^2}{\sigma_{2,2}}\big)\notag\\&space;s_2&space;&=&space;\sum^n_{i=m&plus;1}x_{i,2}&space;&plus;&space;\sum^m_{i=1}\big(\mu_2&plus;\frac{\sigma_{2,1}}{\sigma_{1,1}}(x_{i,1}&space;-&space;\mu_1)\big)\notag\\&space;s_{2,2}&space;&=&space;\sum^n_{i=m&plus;1}x_{i,2}^2&space;&plus;&space;\sum^m_{i=1}\big(\big(\mu_2&plus;\frac{\sigma_{2,1}}{\sigma_{1,1}}(x_{i,1}&space;-&space;\mu_1)\big)^2&space;&plus;&space;\sigma_{2,2}&space;-&space;\frac{\sigma_{2,1}^2}{\sigma_{1,1}}\big)\notag\\&space;s_{1,2}&space;&=&space;\sum^n_{i=m&plus;1}x_{i,1}.x_{i,2}&plus;\sum^m_{i=1}x_{i,1}\big(\mu_2&plus;\frac{\sigma_{2,1}}{\sigma_{1,1}}(x_{i,1}-\mu_1)\big)\notag&space;\end{align}" title="\begin{align} s_1 &= \sum^n_{i=m+1}x_{i,1} + \sum^m_{i=1}\big(\mu_1+\frac{\sigma_{1,2}}{\sigma_{2,2}}(x_{i,2} - \mu_2)\big)\notag\\ s_{1,1} &= \sum^n_{i=m+1}x_{i,1}^2 + \sum^m_{i=1}\big(\big(\mu_1+\frac{\sigma_{1,2}}{\sigma_{2,2}}(x_{i,2} - \mu_2)\big)^2 + \sigma_{1,1} - \frac{\sigma_{1,2}^2}{\sigma_{2,2}}\big)\notag\\ s_2 &= \sum^n_{i=m+1}x_{i,2} + \sum^m_{i=1}\big(\mu_2+\frac{\sigma_{2,1}}{\sigma_{1,1}}(x_{i,1} - \mu_1)\big)\notag\\ s_{2,2} &= \sum^n_{i=m+1}x_{i,2}^2 + \sum^m_{i=1}\big(\big(\mu_2+\frac{\sigma_{2,1}}{\sigma_{1,1}}(x_{i,1} - \mu_1)\big)^2 + \sigma_{2,2} - \frac{\sigma_{2,1}^2}{\sigma_{1,1}}\big)\notag\\ s_{1,2} &= \sum^n_{i=m+1}x_{i,1}.x_{i,2}+\sum^m_{i=1}x_{i,1}\big(\mu_2+\frac{\sigma_{2,1}}{\sigma_{1,1}}(x_{i,1}-\mu_1)\big)\notag \end{align})

#### Maximization step

We update the parameters such that:

\begin{align}
\mu_1&=\frac{s_1}{n}\\
\mu_2&=\frac{s_2}{n}\\
\sigma_{1,1}&=\frac{s_{1,1}}{n}-(\mu_1)^2\\
\sigma_{2,2}&=\frac{s_{2,2}}{n}-(\mu_2)^2\\
\sigma_{1,2}&=\frac{s_{1,2}}{n}-(\mu_1.\mu_2)\\
\end{align}
