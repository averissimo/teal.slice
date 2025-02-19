#' Whether the variable name is good to use within Show R Code
#'
#' Spaces are problematic because the variables must be escaped with backticks.
#' Also, they should not start with a number as R may silently make it valid by changing it.
#' Therefore, we only allow alphanumeric characters with underscores.
#' The first character of the `name` must be an alphabetic character and can be followed by alphanumeric characters.
#'
#' @md
#'
#' @param name `character, single or vector` name to check
#' @keywords internal
#'
#' @examples
#' teal.slice:::check_simple_name("aas2df")
#' teal.slice:::check_simple_name("ADSL")
#' teal.slice:::check_simple_name("ADSLmodified")
#' teal.slice:::check_simple_name("ADSL_modified")
#' teal.slice:::check_simple_name("ADSL_2")
#' teal.slice:::check_simple_name("a1")
#' # the following fail
#' if (interactive()) {
#'   teal.slice:::check_simple_name("1a")
#'   teal.slice:::check_simple_name("ADSL.modified")
#'   teal.slice:::check_simple_name("a1...")
#' }
check_simple_name <- function(name) {
  checkmate::assert_character(name, min.len = 1, any.missing = FALSE)
  if (!grepl("^[[:alpha:]][a-zA-Z0-9_]*$", name, perl = TRUE)) {
    stop(
      "name '",
      name,
      "' must only contain alphanumeric characters (with underscores)",
      " and the first character must be an alphabetic character"
    )
  }
}

#' Resolve the expected bootstrap theme
#' @keywords internal
get_teal_bs_theme <- function() {
  bs_theme <- getOption("teal.bs_theme")
  if (is.null(bs_theme)) {
    NULL
  } else if (!inherits(bs_theme, "bs_theme")) {
    warning("teal.bs_theme has to be of a bslib::bs_theme class, the default shiny bootstrap is used.")
    NULL
  } else {
    bs_theme
  }
}

#' Include `JS` files from `/inst/js/` package directory to application header
#'
#' `system.file` should not be used to access files in other packages, it does
#' not work with `devtools`. Therefore, we redefine this method in each package
#' as needed. Thus, we do not export this method
#'
#' @param pattern (`character`) pattern of files to be included, passed to `system.file`
#' @param except (`character`) vector of basename filenames to be excluded
#'
#' @return HTML code that includes `JS` files
#' @keywords internal
include_js_files <- function(pattern) {
  checkmate::assert_character(pattern, min.len = 1, null.ok = TRUE)
  js_files <- list.files(
    system.file("js", package = "teal.slice", mustWork = TRUE),
    pattern = pattern,
    full.names = TRUE
  )
  return(singleton(lapply(js_files, includeScript)))
}

#' This function takes a vector of values and returns a `c` call. If the vector
#' has only one element, the element is returned directly.
#'
#' @param choices A vector of values.
#'
#' @return A `c` call.
#'
#' @examples
#' teal.slice:::make_c_call(1:3)
#' # [1] 1 2 3
#'
#' teal.slice:::make_c_call(1)
#' # [1] 1
#' @keywords internal
make_c_call <- function(choices) {
  if (length(choices) > 1) {
    do.call("call", append(list("c"), choices))
  } else {
    choices
  }
}
