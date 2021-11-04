/ Newton's Method
/ Find the n+1th approximation of the root of a number

/ Sets the floating point display to maximum
\P 0

/ Square Root of 2
/ xn -- approximation at some step
{[xn] xn-((xn*xn)-2)%2*xn}/[1.0] / OVER
{[xn] xn-((xn*xn)-2)%2*xn}\[1.0] / SCAN

/ Square Root of number
/ xn -- approximation at some step
/ c  -- number to find the square root of
{[c; xn] xn-((xn*xn)-c)%2*xn}[2.0;]/[1.0]

/ p-Root of number
/ xn -- approximation at some step
/ c  -- number to find the p-root of
/ p  -- root
{[p; c; xn] xn-(((*/)p#xn)-c)%p*(*/)(p-1)#xn}[2; 3.0;]/[1.0]


