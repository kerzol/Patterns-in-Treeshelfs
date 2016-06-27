debut <- function () {GLOBAL.indent <<- GLOBAL.indent + 1}
fin   <- function () {GLOBAL.indent <<- GLOBAL.indent - 1}
        
dprint <- function(...) {
    vars <- list(...)
    varnames <- sapply(match.call(expand.dots=TRUE)[-1], deparse)
    cat (rep(' ', GLOBAL.indent))
    for (i in 1:length(vars) ) {
        cat (varnames[[i]], '=', vars[[i]], ' ')
    }
    cat ('\n')
}

fun1 <- function (foo, bar, baz) {
    debut()
    f='fun1  >>'
    dprint(f, foo, bar, baz)

    fun2 (foo-1)
    fun2 (foo-2)

    fin()
}

fun2 <- function (br) {
    debut()
    f='fun2  >>'
    dprint(f, br)
    fun3 ()
    fun3 ()
    fin()
}

fun3 <- function () {
    debut()
    f='fun3  >>'
    dprint(f)
    fin()
}

GLOBAL.indent <<- 0; fun1(1,2,3)
