if (isFALSE(require("remotes", quietly = TRUE))) install.packages("remotes", dependencies = TRUE)
remotes::install_github("https://github.com/zivankaraman/clockify", ref = "myversion", dependencies = FALSE, lib = .libPaths()[1])
