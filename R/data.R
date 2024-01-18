#' Subjective Community Well-Being Dataset (25 Variables)
#'
#' These Subjective Community Well-Being (SCWB) data are a random subset from
#' the full dataset used in the paper by Padgett et al. (in press). The SCWB
#' dataset contains 501 responses to the 20 SCWB items plus 5 pre-computed total
#' scores on the five theorized domains of Good Relationships, Proficient
#' Leadership, Healthy Practices, Satisfying Community, and Strong Mission.
#'
#' @usage data(SCWB)
#' @format ## `SCWB` A data frame with 501 observations of 25 variables.
#' \describe{
#'   \item{`cwbcloserel`}{}
#'   \item{`cwbrespect`}{}
#'   \item{`cwbtrust`}{}
#'   \item{`cwbmutuality`}{}
#'   \item{`cwbbeneficence`}{}
#'   \item{`cwbintegrity`}{}
#'   \item{`cwbcompetence`}{}
#'   \item{`cwbvision`}{}
#'   \item{`cwbrelgrowth`}{}
#'   \item{`cwbfairness`}{}
#'   \item{`cwbsustenance`}{}
#'   \item{`cwbachieve`}{}
#'   \item{`cwbsatisf`}{}
#'   \item{`cwbvalue`}{}
#'   \item{`cwbbelonging`}{}
#'   \item{`cwbwelcome`}{}
#'   \item{`cwbpurpose`}{}
#'   \item{`cwbcontrib`}{}
#'   \item{`cwbinterconn`}{}
#'   \item{`cwbsynergy`}{}
#'   \item{`total_goodrel`}{Mean of items cwbcloserel, cwbrespect, cwbtrust, cwbmutuality}
#'   \item{`total_prolead`}{Mean of items cwbbeneficence, cwbintegrity, cwbcompetence, cwbvision}
#'   \item{`total_healthyprac`}{Mean of items cwbrelgrowth, cwbfairness, cwbsustenance, cwbachieve}
#'   \item{`total_satcomm`}{Mean of items cwbsatisf, cwbvalue, cwbbelonging, cwbwelcome}
#'   \item{`total_strongmiss`}{Mean of items cwbpurpose, cwbcontrib, cwbintercon, cwbsynergy}
#' }
#' @source Data used in Padgett et al. (in press).
#' @references Padgett, R.N., ...
#' @examples
#' # SCWB example used in preprint
#' data(SCWB)
"SCWB"
