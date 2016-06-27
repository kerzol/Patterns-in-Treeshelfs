source('premutations.R')
source('debug.R')

###
### some calculations for "Treeshelfs patters" paper
### 
### Code by Sergey KIRGIZOV

###                                                             
### down.up   .          down_up      .     down.down   .       
###            \   .                 /                   \      
###             \ /                 /                     \     
###              .                 .                       .    
###                                 \                       \   
###                                  .                       .  

###
### down.1              down.2             down.3
###
###                                                      .      
###                         
###         .                   .                  .       
###          \                   \    .             \    
###           \                   \                  \     
###            .                   .                  .    
###
###                .


###
### 1.down              2.down             3.down
###
###                                             .        
###                         
###         .                   .                  .       
###          \               .   \                  \    
###           \                   \                  \     
###            .                   .                  .    
###      .
###                


### down.3m     down.1m  
###                      
###    .         . 
###  .            \     
###   \            \    
###    \            .   
###     .         .     
###                      


### Enumerazione
###
### avoid down      ---- 1
### avoid up        ---- 1
### avoid down.down ---- A000111  --- avoid up.up    1, 2, 5, 16, 61, 272, 1385,  7936, 50521, 353792
### avoid down.up   ---- A000110  --- avoid up.down  1, 2, 5, 15, 52, 203,  877,  4140, 21147, 115975
### avoid down.2    ---- A000110  ---                1, 2, 5, 15, 52, 203,  877,  4140, 21147, 115975
### avoid 1.down    ---- A000110
### avoid 3.down    ---- A000110
### avoid 2.down    ---- n!  --- contradict the definition of VB-arbres
### avoid down.3    ---- A000108 (catalan) --- evit motif 213
### avoid down_up   ---- A131178  --- avoid up_down  1, 2, 5, 16, 64, 308, 1730, 11104, 80176, 643232

### WE need to check it again..
### avoid down.1   ---- A193296                  --- 1, 2, 5, 15, 51, 191, 773, 3338, 15243


### TODO: formula, check the bruteforce
### avoid down.3m  ---- not in oeis                      ---- 1,2,5,15,53,216,995,5094,28603 
### avoid down.1m  ---- A113227 (avoids 1-23-4)          ---- 1,2,6,23,105,549,3207,20577,143239,1071704
###                     equinumerous but not the same!!! 
###
### avoid down.1m or avoid down.3m  ---- Bell?                            ---- 1,2,5,15,52,203,877,4140,21147,115975,...





a.down.down <- function (n) {
    ## Count leveled binary trees that avoid
    ##
    ##  .
    ##   \
    ##    .
    ##     \
    ##      .
    ##
    if (n < 0) return (0)
    if (n == 0) return (1)
    sum <- 0
    for (i in 1:n) {

        sum <- sum + 
            choose(n-1, i-1) *  a.down.down (n-i) * a.down.down.a.prefix.down (i-1)
    }

    return (sum)
}

a.down.down.a.prefix.down <- function (n) {
    ## avoid down.down and avoid down at beginning
    if (n < 0) return (0)
    if (n == 0) return (1)
    if (n == 1) return (1)

    1 * a.down.down (n-1)    
}

paste(sapply (1:10, a.down.down), collapse=  ',')


a.down_up <- function (n) {
    ## Count leveled binary trees that avoid
    ##
    ##   down_up      .  
    ##               /   
    ##              /    
    ##             .     
    ##              \    
    ##               .
    if (n < 0) return (0)
    if (n == 0) return (1)
    if (n == 1) return (1)
    if (n == 2) return (2)
    
    sum <- 0
    for (i in 1:n) {

        if (i == 1) {
            ## border case
            sum <- sum + a.down_up (n-1)
        } else if (i == n) {
            ## border case
            sum <- sum + a.down_up (n-1)
        } else {
            ## choose places for 0s.
            sum <- sum + choose(n-2, i-1)  *  a.down_up (n-i) * a.down_up (i-1) ## 1....
            ## 0.... cannot exists, caz it will make down_up
        }

    }

    return (sum)
   
}

paste(sapply (1:10, a.down_up), collapse=  ',')





a.down.up <- function (n) {
    ## Count leveled binary trees that avoid
    ##
    ##  down.up   .        
    ##             \   .   
    ##              \ /      
    ##               .     
    ##
    if (n < 0) return (0)
    if (n == 0) return (1)
    if (n == 1) return (1)
    if (n == 2) return (2)

    sum <- 0
    for (i in 1:n) {

        if (i == 1) {
            ## border case
            sum <- sum + a.down.up(n-1)
        } else if (i == 2) {
            ## border case
            sum <- sum + a.down.up(n-2) * (n-1)
        } else {
            ## choose places for 0s.
            ## i-1 is the number of 0s
            ## n-i is the number of 1s
            sum <- sum +
                choose(n-1, i-1) * a.down.up(n-i) * 1
        }


    }

    return (sum)
   
}

paste(sapply (1:10, a.down.up), collapse=  ',')



a.down.2 <- function (n) {
    ## Count leveled binary trees that avoid down.2
    ##
    ##  .        
    ##   \    .  
    ##    \      
    ##     .     
    if (n < 0) return (0)
    if (n == 0) return (1)
    sum <- 0
    for (i in 1:n) {
        if (i == 1) {
            # border case
            sum <- sum + a.down.2 (n-1)
        } else if (i == 2) {
            # border case
            sum <- sum + a.down.2 (n-2) * (n-1)
        } else {
            sum <- sum + 
                choose(n-1, i-1) *  a.down.2 (n-i) 
        }
    }

    return (sum)
}

paste(sapply (1:10, a.down.2), collapse=  ',')


a.2.down = factorial

a.3.down == a.down.2


a.1.down <- function (n) {
    ## Count leveled binary trees that avoid 1.down
    ##
    ##   .        
    ##    \    
    ##     \      
    ##      .
    ## .
    ##
    if (n < 0) return (0)
    if (n == 0) return (1)
    sum <- 0
    for (i in 1:n) {
        if (i == n) {
            # border case
            sum <- sum + a.1.down (n-1)
        } else if (i == n-1) {
            # border case
            sum <- sum + a.1.down (n-2) * (n-1)
        } else {
            sum <- sum + 
                choose(n-1, i-1) *  a.1.down (i-1) 
        }
    }

    return (sum)
}

paste(sapply (1:10, a.1.down), collapse=  ',')



a.down.3 <- function (n) {
    ## Count leveled binary trees that avoid down.3
    ##
    ##          .
    ##   .        
    ##    \    
    ##     \      
    ##      .
    ## 
    ##
    if (n < 0) return (0)
    if (n == 0) return (1)
    sum <- 0
    for (i in 1:n) {
        if (i == 1) {
            # border case
            sum <- sum + a.down.3 (n-1)
        } else if (i == n) {
            # border case
            sum <- sum + a.down.3 (n-1) 
        } else {
            sum <- sum + 
                a.down.3 (i-1) * a.down.3 (n-i)
        }
    }

    return (sum)
}

paste(sapply (1:10, a.down.3), collapse=  ',')



## Count leveled binary trees that avoid down.1
##
##   .        
##    \    
##     \      
##      .
## 
##          .
##
## TODO: test me!!!!11
## PAS SURE, PAS SURE... pas


## n -- size
## i -- π₁
## j -- just before the first end of down-link in treeshelf

### FIXME: why sometimes n-i is less than j-1 ???
### What about others special cases :
###    i == n? i == n-1, i == 2 ?
###    Will they be the consequencies of... what?
### OKEY!!111
a.down.1ij <- function (n,i,j) {
    debut()
    f='a.down.1ij >>'
    dprint(f, n,i,j,n-i,j-1)

    if (i == 1) {
        val = a.down.1j(n-1, j-1)
        fin()
        return (val)
    }
    
    if (n-i < j-1) {
        fin()
        return (0)
    }

    sum <- 0
    for (k in (j-1):(n-i)) {
        sum <- sum +
            choose (i-1+k-j,i-2) *
                a.down.1 (i-2) *
                    a.down.1j(n-i,k)
    }


    fin()
    return (sum)
}


### OKEY!!111
a.down.1j <- function (n, j) {
    debut()
    f="a.down.1j >>"
    dprint(f, n, j)

    if (j == 0) {
        if (n == 0) {
            fin()
            return (1)
        }

        fin()
        return (0)
    }
    
    sum <- 0    
    for (i in 1:n) {
        sum <- sum + a.down.1ij (n, i, j)
    }

    fin()
    return (sum)
}


### OKEY!!111
a.down.1 <- function (n) {
    debut()
    f="a.down.1 >>"
    dprint(f, n)
    
    if (n == 0 || n == 1) {
        fin()
        return (1)
    }
    
    sum <- 0
    for (j in 1:n) {
            sum <- sum + a.down.1j(n, j)
    }

    
    fin()
    return (sum)
}
GLOBAL.indent <<- 0
a.down.1(2)

paste(sapply (1:11, a.down.1), collapse=  ',')


## 1,2,3, 4, 5,  6,  7,   8,    9,   10
## 1,2,5,15,51,191,773,3338,15243,73131

## QUESTION the same as generalised pattern 32-1??

## NOOO !!!11 in 41532 there is 32-1 pattern : 532, bu there is no down.1 pattern
## +-+-+-+-+-+
## | | |x| | |
## +-+-+-+-+-+
## |x| | | | |
## +-+-+-+-+-+
## |̱ | | |x| |
## +-+-+-+-+-+
## | | | | |x|
## +-+-+-+-+-+
## | |x| | | |
## +-+-+-+-+-+




##
## BRUTEFORCE test if a permutation avoids a following pattern
##          
##   .        
##    \    
##     \      
##      .
##
##          .
##
test.avoid.down.1 <- function (p) {
    n <- length(p)
    if (n < 3) return (TRUE)
    
    avoids <- TRUE
    for (i in 1:(n-2)) {
        for (j in (i+1):(n-1)) {
            if (p[i] > p[j]) {
                ## this is a 21 patter
                ## we need to check whether it is a down-link in our tree or not
                if (
                    i == 1
                    ||
                    all (   p[1:(i-1)] > p[i]
                          | p[1:(i-1)] < p[j]
                        )
                ) {
                    ## True down-link in leveled arbre
                    for (k in (j+1):n) {
                        if (p[j] > p[k]) return (FALSE)
                    }
                    break ## this 21 pattern was a down-link in the tree
                          ## we should not examine next j-s
                }
            }
        }
    }
    return (TRUE)
}
## avoid
bruteforce.a.down.1 <- function (n) {
    permn(n) -> all.permutations
    all.permutations [sapply (all.permutations, test.avoid.down.1)]
}
## contains
bruteforce.c.down.1 <- function (n) {
    permn(n) -> all.permutations
    all.permutations [sapply (all.permutations, function(p) !test.avoid.down.1(p))]
}

n = 9;
paste( sapply (1:n, function (n) length (bruteforce.a.down.1 (n)) ), collapse=  ',')




##
## BRUTEFORCE test if a permutation avoids a following pattern
##     
##     .
##   .        
##    \
##     \      
##      .
##
test.avoid.down.3m <- function (p) {
    n <- length(p)
    if (n < 3) return (TRUE)
    
    avoids <- TRUE
    for (i in 1:(n-2)) {
        for (j in (i+1):n) {
            if (p[i] > p[j]) {
                ## this is a 21 patter
                ## we need to check whether it is a down-link in our tree or not
                if (
                    i == 1
                    ||
                    all (   p[1:(i-1)] > p[i]
                          | p[1:(i-1)] < p[j]
                        )
                ) {
                    ## True down-link in leveled arbre
                    if ( (j-1) >= (i+1) ) {
                        ## if there is something between p[i] and p[j]
                        for (k in (i+1):(j-1)) {
                            if (p[k] > p[i]) return (FALSE)
                        }
                    }
                    
                    break ## this 21 pattern was a down-link in the tree
                          ## we should not examine next j-s
                }
            }
        }
    }
    return (TRUE)
}
## avoids
bruteforce.a.down.3m <- function (n) {
    permn(n) -> all.permutations
    all.permutations [sapply (all.permutations, test.avoid.down.3m)]
}
## contains
bruteforce.c.down.3m <- function (n) {
    permn(n) -> all.permutations
    all.permutations [sapply (all.permutations, function(p) !test.avoid.down.3m(p))]
}

n = 9;
paste( sapply (1:n, function (n) length (bruteforce.a.down.3m (n)) ), collapse=  ',')



##
## BRUTEFORCE test if a permutation avoids a following pattern
##     
##   .        
##    \
##     \      
##      .
##    .
##
test.avoid.down.1m <- function (p) {
    n <- length(p)
    if (n < 3) return (TRUE)
    
    avoids <- TRUE
    for (i in 1:(n-2)) {
        for (j in (i+1):n) {
            if (p[i] > p[j]) {
                ## this is a 21 patter
                ## we need to check whether it is a down-link in our tree or not
                if (
                    i == 1
                    ||
                    all (   p[1:(i-1)] > p[i]
                          | p[1:(i-1)] < p[j]
                        )
                ) {
                    ## True down-link in leveled arbre
                    if ( (j-1) >= (i+1) ) {
                        ## if there is something between p[i] and p[j]
                        for (k in (i+1):(j-1)) {
                            if (p[k] < p[j]) return (FALSE)
                        }
                    }
                    
                    break ## this 21 pattern was a down-link in the tree
                          ## we should not examine next j-s
                }
            }
        }
    }
    return (TRUE)
}
## avoids
bruteforce.a.down.1m <- function (n) {
    permn(n) -> all.permutations
    all.permutations [sapply (all.permutations, test.avoid.down.1m)]
}
## contains
bruteforce.c.down.1m <- function (n) {
    permn(n) -> all.permutations
    all.permutations [sapply (all.permutations, function(p) !test.avoid.down.1m(p))]
}

n = 9;
paste( sapply (1:n, function (n) length (bruteforce.a.down.1m (n)) ), collapse=  ',')


