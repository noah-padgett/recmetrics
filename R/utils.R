#' Compute rowMeans of a correlation matrix
#'
#' A wrapper for computing the mean of the rows of a correlation matrix.
#'
#' @param x A correlations
#' @param na.rm logical (defaults to TRUE)
#' @returns A numeric vector of correlation means.
#' @examples
#'   # Use the SCWB data example
#'   data(SCWB)
#'   mycor <- cor(SCWB)
#'   cor.rowMeans(mycor)
#' @export
cor.rowMeans <- function(x, na.rm=TRUE) {
  diag(x) <- NA
  rowMeans(x, na.rm = na.rm)
}


#' Append Observed Correlations to Data
#'
#' Compute observed residuals for each variables in data and appends these newly
#' created variables to the original dataset.
#'
#'
#' @param data A data.frame or tibble
#' @param na.rm logical (defaults to TRUE)
#' @returns A numeric matrix of correlations among variable residuals.
#' @examples
#'   # Use the SCWB data example
#'   data(SCWB)
#'   append_observed_residuals(SCWB[, 1:20])
#' @import dplyr tidyselect
#' @export
append_observed_residuals <- function(data, na.rm = TRUE) {
  data %>%
    mutate(
      x.mean = 0,
      x.mean = rowMeans(across(everything()), na.rm = na.rm),
      across(everything(), ~ .x - x.mean, .names = "resid_{.col}")
    ) %>%
    select(!contains("x.mean")) %>%
    na.omit()
}
