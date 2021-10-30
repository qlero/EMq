/ Run Length Encoding
/ ':     -- each prior adverb, performs a dyadic operation between
/           two consecutive values in a list
/ =':[x] -- checks if char equals previous char
/ [.]    -- evals as list
/ not    -- inverts bool
/ where  -- returns index
/ @ \:/: -- monadic function application
/ expand -- inverse of rle

l : "thiiis a tesstt;"

rle : {(count; first)@\:/:(where not =':[x])_x}
expand : {(),/(#).'x}
