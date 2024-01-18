cor.rowMeans <- function(x) {
  diag(x) <- NA
  rowMeans(x, na.rm = T)
}


#' Observed Residual Correlations
#'
#' Compute observed residual correlation (ORC) matrix among observed residuals
#' for variables supplied data.
#'
#' @param data A data.frame or tibble
#' @param na.rm logical (defaults to TRUE)
#' @returns A numeric matrix of correlations among variable residuals.
#' @examples {
#' # Use the SCWB data example
#' data(SCWB)
#' append_observed_residuals(SCWB[,1:20])
#' }
#' @import dplyr tidyselect
#' @export
append_observed_residuals <- function(data, na.rm=T){
  data %>%
    mutate(
      x.mean = 0,
      x.mean = rowMeans(across(everything()), na.rm=na.rm),
      across(everything(), ~ .x - x.mean, .names="resid_{.col}")
    ) %>%
    select(!contains("x.mean")) %>%
    na.omit()
}
