/ prime finder
/ \:/:                    -- each left each right
/ n mod \:/: n:1 + til 10 -- declares n (list from 1 to 10)
/                            computes mod each left each right
/ 0=                      -- outputs bool where val = 0
/ +/                      -- plus reduction (i.e. sum)
/ 2=                      -- find where the sum is 2
/ where                   -- outputs indexes
/ n <val> <val>           -- retrieves values from list n at index <>

p : {n where 2=sum 0=n mod\:/: n:1+til x}
