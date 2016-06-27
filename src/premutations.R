library(combinat)


"%+%" <- function(...){
    paste0(...,sep="")
}

str2perm <- function (str) {
    as.integer(unlist(strsplit(str, "")))
}

visualise <- function (perm) {
###
### Visualise a (list of) permutation as a matrix
###

    ### FIXME: NULL VALUES AT THE END, WHAT THE FUCK ???
    if (is.list(perm)) {
        sapply (perm, visualise) -> devnull
    } else {
        n <- length(perm)
        id <- 1:n
        M <- matrix (' ', ncol=n, nrow=n)
        M[cbind(id,perm)] <- '◆'

        ## we create a separator line
        separator.line <- paste(rep('-+',n), collapse='')
        separator.line <- '\n+' %+% separator.line %+% '\n'

        result <- NULL
        ## we construct the visaulisation line par line
        for (i in 1:n) {

            ## add permutation dots
            line <- '|' %+% paste(M[,i], collapse = '|') %+% '|'        
            ## add current line to the result        
            result <- line %+%
                separator.line %+%
                    result
            
        }
        ## create x-axis
        result <- separator.line %+%
            result %+%
                ' ' %+% paste(perm, collapse=' ') %+%'\n'
        cat (result)

        result
    }
}


