/ Implementation of a bivariate EM algorithm, robust to missing values, with q and
/ the standard R dataset: Wine 

/ Retrieves dataset with cmd call: "\wget ... system commands"
/ uncomment this line if the file is not downloaded yet
/ \wget https://gist.githubusercontent.com/tijptjik/9408623/raw/b237fa5848349a14a14e5d4107dc7897c21951f5/wine.csv

/ E(xtract)T(ransform)L(oad) -- we keep only the first two features
/ (column types, type separated) 0: filename

wine   : ("iffffifffffffi"; enlist ",") 0: `:wine.csv
wine   : flip `Alcohol`Malic.Acid!wine[`Alcohol`Malic.acid]

wineNA : ("iffffifffffffi"; enlist ",") 0: `:wineNA.csv
wineNA : flip `Alcohol`Malic.Acid!wineNA[`Alcohol`Malic.acid]

/ real mean and covariance computation
covariance : {x cov x}
mean       : avg wine 
varAlc     : sqrt covariance wine[`Alcohol]
varMal     : sqrt covariance wine[`Malic.Acid] 
covAlcMal  : sqrt wine[`Alcohol] cov wine[`Malic.Acid]

/ computes the intermediary values for the expectation step
nl           : null wineNA
malWithAlcNA : wineNA[`Malic.Acid] where nl[`Alcohol]
alcWithMalNA : wineNA[`Alcohol] where nl[`Malic.Acid]
mal          : wineNA[`Malic.Acid] where all each not null wineNA[`Malic.Acid]
alc          : wineNA[`Alcohol] where all each not null wineNA[`Alcohol]

/ Expectation step loop
/
/ s_1 &= \sum^n_{i=m+1} x_{i,1} + 
/        \sum^m_{i=1} \big( \mu_1 + \frac{\sigma_{1,2}}{\sigma_{2,2}} (x_{i,2} - \mu_2) \big)
/
/ s_{1,1} &= \sum^n_{i=m+1} x_{i,1}^2 + 
/            \sum^m_{i=1} \big(
/                \big( \mu_1 + \frac{\sigma_{1,2}}{\sigma_{2,2}} (x_{i,2} - \mu_2) \big)^2 + 
/                \sigma_{1,1} - \frac{\sigma_{1,2}^2}{\sigma_{2,2}}
/            \big)
/ 
/ s_2 &= \sum^n_{i=m+1} x_{i,2} + 
/        \sum^m_{i=1} \big(
/             \mu_2 + \frac{\sigma_{2,1}}{\sigma_{1,1}} (x_{i,1} - \mu_1)
/        \big)
/
/ s_{2,2} &= \sum^n_{i=m+1} x_{i,2}^2 + \sum^m_{i=1} \big(
/                \big(\mu_2 + \frac{\sigma_{2,1}}{\sigma_{1,1}} (x_{i,1} - \mu_1)\big)^2 + 
/                \sigma_{2,2} - \frac{\sigma_{2,1}^2}{\sigma_{1,1}}
/            \big)
/
/ s_{1,2} &= \sum^n_{i=m+1} x_{i,1}.x_{i,2} + \sum^m_{i=1} x_{i,1} \big(
/                 \mu_2 + \frac{\sigma_{2,1}}{\sigma_{1,1}}(X_{i,1}-\mu_1)
/            \big\
/

s_1 : { [m1; m2; v12; v22] m1 + (v12 % v22) * (malWithAlcNA - m2) }

s_2 : { [m1; m2; v11; v12] m2 + (v12 % v11) * (alcWithMalNA - m1) }

s1  : { [m1; m2; v12; v22] (sum alc) + (sum s_1[m1; m2; v12; v22]) }

s11 : { [m1; m2; v11; v12; v22] a : (sum alc * alc);
                                b : (s_1[m1; m2; v12; v22] * s_1[m1; m2; v12; v22]);
                                c :  v11 - (v12 * v12) % v22; 
                                a + sum b + c }

s2  : { [m1; m2; v11; v12] (sum mal) + (sum s_2[m1; m2; v11; v12]) }

s22 : { [m1; m2; v11; v12; v22] a : (sum mal * mal);
                                b : (s_2[m1; m2; v11; v12] * s_2[m1; m2; v11; v12]);
                                c : v22 - (v12 * v12) % v11; 
                                a + sum b + c }

s12 : { [m1; m2; v11; v12] a : (sum alc * mal); 
                           b : (alcWithMalNA * (m2 + (v12 % v11) * (alcWithMalNA-m1))); 
                           a + sum b }
  
/ Maximization step loop
/
/ \mu_1&=\frac{s_1}{n}\\
/ \mu_2&=\frac{s_2}{n}\\
/ \sigma_{1,1}&=\frac{s_{1,1}}{n}-(\mu_1)^2\\
/ \sigma_{2,2}&=\frac{s_{2,2}}{n}-(\mu_2)^2\\
/ \sigma_{1,2}&=\frac{s_{1,2}}{n}-(\mu_1.\mu_2)\\
/

m1Up  : { [m1; m2; v12; v22] s1[m1; m2; v12; v22] % (count wine) }
m2Up  : { [m1; m2; v11; v12] s2[m1; m2; v11; v12] % (count wine) }
v11Up : { [m1; m2; v11; v12; v22] (s11[m1; m2; v11; v12; v22] % count wine) - (m1 * m1) }
v22Up : { [m1; m2; v11; v12; v22] (s22[m1; m2; v11; v12; v22] % count wine) - (m2 * m2) }
v12Up : { [m1; m2; v11; v12; v22] (s12[m1; m2; v11; v12] % count wine) - (m1 * m2) }

/ EM algorithm
EM : { [m1; m2; v11; v12; v22] nm1  : m1Up[m1; m2; v12; v22]; 
                               nm2  : m2Up[m1; m2; v11; v12]; 
                               nv11 : v11Up[m1; m2; v11; v12; v22]; 
                               nv12 : v12Up[m1; m2; v11; v12; v22]; 
                               nv22: v22Up[m1; m2; v11; v12; v22]; 
                               (nm1, nm2, nv11, nv12, nv22) }

/ Running the algorithm

/ one round of EM
EM [mean[`Alcohol]; mean[`Malic.Acid]; varAlc; covAlcMal; varMal]

/ three rounds of EM
EM . EM . EM [mean[`Alcohol]; mean[`Malic.Acid]; varAlc; covAlcMal; varMal]
