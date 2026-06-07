.onAttach <- function(libname, pkgname) {
    packageStartupMessage(paste(pkgname, utils::packageVersion(pkgname)))
    invisible()
}
