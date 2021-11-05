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

/ computes intermediary values for the expectation step

n            : count wine
nl           : null wineNA
malWithAlcNA : wineNA[`Malic.Acid] where nl[`Alcohol]
alcWithMalNA : wineNA[`Alcohol] where nl[`Malic.Acid]
mal          : wineNA[`Malic.Acid] where all each not null wineNA[`Malic.Acid]
alc          : wineNA[`Alcohol] where all each not null wineNA[`Alcohol]
sumMal       : sum mal
sumAlc       : sum alc
squareSumAlc : sum alc * alc
squareSumMal : sum mal * mal
prodAlcMal   : sum alc * mal

/ Expectation step loop

s_1 : { [m1; m2; v12; v22]      m1 + (v12 % v22) * (malWithAlcNA - m2) }
s_2 : { [m1; m2; v11; v12]      m2 + (v12 % v11) * (alcWithMalNA - m1) }
s1  : { [m1; m2; v12; v22]      sumAlc + (sum s_1[m1; m2; v12; v22]) }
s11 : { [m1; m2; v11; v12; v22] a : (s_1[m1; m2; v12; v22] * s_1[m1; m2; v12; v22]);
                                b : v11 - (v12 * v12) % v22; 
                                squareSumAlc + sum a + b }
s2  : { [m1; m2; v11; v12]      sumMal + (sum s_2[m1; m2; v11; v12]) }
s22 : { [m1; m2; v11; v12; v22] a : (s_2[m1; m2; v11; v12] * s_2[m1; m2; v11; v12]);
                                b : v22 - (v12 * v12) % v11; 
                                squareSumMal + sum a + b }
s12 : { [m1; m2; v11; v12]      a : m2 + (v12 % v11) * (alcWithMalNA - m1);
                                b : alcWithMalNA * a;
                                prodAlcMal + sum b }
  
/ Maximization step loop

m1Up  : { [m1; m2; v12; v22]      s1[m1; m2; v12; v22] % n }
m2Up  : { [m1; m2; v11; v12]      s2[m1; m2; v11; v12] % n }
v11Up : { [m1; m2; v11; v12; v22] (s11[m1; m2; v11; v12; v22] % n) - (m1 * m1) }
v22Up : { [m1; m2; v11; v12; v22] (s22[m1; m2; v11; v12; v22] % n) - (m2 * m2) }
v12Up : { [m1; m2; v11; v12; v22] (s12[m1; m2; v11; v12] % n) - (m1 * m2) }

/ EM algorithm

EM : { [m1; m2; v11; v12; v22] nm1  : m1Up[m1; m2; v12; v22]; 
                               nm2  : m2Up[m1; m2; v11; v12]; 
                               nv11 : v11Up[m1; m2; v11; v12; v22]; 
                               nv12 : v12Up[m1; m2; v11; v12; v22]; 
                               nv22 : v22Up[m1; m2; v11; v12; v22]; 
                               (nm1, nm2, nv11, nv12, nv22) }

/ Running the algorithm: 1 and 3 rounds of EM

EM           [mean[`Alcohol]; mean[`Malic.Acid]; varAlc; covAlcMal; varMal]
EM . EM . EM [mean[`Alcohol]; mean[`Malic.Acid]; varAlc; covAlcMal; varMal]
