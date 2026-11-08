setHook(packageEvent("base", "onLoad"), function(...) {
  if (interactive()) {
    # Packages to ensure
    required_pkgs <- c("tidyverse", "data.table", "crayon")

    # Use fully qualified names to avoid early eval issues
    installed <- tryCatch(base::installed.packages()[, "Package"], error = function(e) character(0))
    missing_pkgs <- setdiff(required_pkgs, installed)

    if (length(missing_pkgs) > 0) {
      message("Installing missing packages: ", paste(missing_pkgs, collapse = ", "))
      utils::install.packages(missing_pkgs, repos = "https://cloud.r-project.org")
    }

    # Load packages safely and quietly
    suppressMessages(lapply(required_pkgs, function(pkg) {
      tryCatch(library(pkg, character.only = TRUE), error = function(e) message("Failed to load: ", pkg))
    }))
  }
})

# Enable colored output
options(crayon.enabled = TRUE)

# Set a default CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Custom prompt
options(prompt = "R > ", continue = "+ ")

# Quickly reload all packages
reload_packages <- function() {
  sapply(.packages(), detach, character.only = TRUE, unload = TRUE)
  sapply(c("ggplot2", "dplyr"), library, character.only = TRUE)
}

