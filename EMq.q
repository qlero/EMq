/ Implementation of an EM algorithm in q using the Wine dataset
/
/ \wget ... system commands

/ Retrieves dataset
\wget https://gist.githubusercontent.com/tijptjik/9408623/raw/b237fa5848349a14a14e5d4107dc7897c21951f5/wine.csv

/ E(xtract)T(ransform)L(oad)
/ (column types, type separated) 0: filename
wine : ("iffffifffffffi"; enlist ",") 0: `:wine.csv


