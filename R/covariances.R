#' Observed Residual Covariances
#'
#' Compute observed residual covariances (ORC) matrix among observed residuals
#' for variables supplied data.
#'
#' `r lifecycle::badge('experimental')`
#'
#' @param data A data.frame or tibble
#' @param na.rm logical (defaults to TRUE)
#' @returns A numeric matrix of correlations among variable residuals.
#' @examples
#'   # Use the SCWB data example
#'   data(SCWB)
#'   cov.orc(SCWB[, 1:20])
#' @export
cov.orc <- function(data, na.rm = TRUE) {
  temp.data <- data
  temp.data <- append_observed_residuals(temp.data, na.rm = na.rm)

  # compute correlations of residuals
  Qij <- temp.data %>%
    select(contains("resid_")) %>%
    cov(use = "pairwise.complete.obs")
  rownames(Qij) <- colnames(Qij) <- colnames(data)

  Qij
}



#' Relative Excess Covariances
#'
#' Compute relative excess covariances (REC) matrix among variables in supplied
#' data.
#'
#' `r lifecycle::badge('experimental')`
#'
#' @param data A data.frame or tibble
#' @param na.rm logical (defaults to TRUE)
#' @returns A numeric matrix of correlations among variable residuals.
#' @examples
#'   # Use the SCWB data example
#'   data(SCWB)
#'   cov.rec(SCWB[, 1:20])
#' @export
cov.rec <- function(data, na.rm = TRUE) {
  temp.data <- data
  temp.data <- append_observed_residuals(temp.data, na.rm = na.rm)

  # observed correlations
  Cij <- temp.data %>%
    select(!contains("resid_")) %>%
    cov(use = "pairwise.complete.obs")
  rownames(Cij) <- colnames(Cij) <- colnames(data)

  # compute relative excess correlation
  diag(Cij) <- NA
  rho.i <- rowMeans(Cij, na.rm = TRUE)
  rho.. <- mean(Cij, na.rm = TRUE)
  Qij.star <- matrix(nrow = ncol(Cij), ncol = ncol(Cij))
  for (i in 1:ncol(Cij)) {
    for (j in 1:ncol(Cij)) {
      if (i != j) {
        Qij.star[i, j] <- (Cij[i, j] - rho..) - ((rho.i[i] - rho..) + (rho.i[j] - rho..))
      }
    }
  }
  rownames(Qij.star) <- colnames(Qij.star) <- colnames(data)

  Qij.star
}
