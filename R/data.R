#' Holzinger and Swineford Dataset (9 Variables)
#'
#' The classic Holzinger and Swineford (1939) dataset consists of mental ability
#' test scores of seventh- and eighth-grade children from two different schools
#' (Pasteur and Grant-White). In the original dataset (available in the
#' \code{MBESS} package), there are scores for 26 tests. However, a smaller
#' subset with 9 variables is more widely used in the literature (for example in
#' Joreskog's 1969 paper, which also uses the 145 subjects from the Grant-White
#' school only).
#'
#' @usage data(HolzingerSwineford1939)
#' @format ## `HolzingerSwineford1939`
#' A data frame with 301 observations of 15 variables.
#' \describe{
#'   \item{\code{id}}{Identifier}
#'   \item{\code{sex}}{Gender}
#'   \item{\code{ageyr}}{Age, year part}
#'   \item{\code{agemo}}{Age, month part}
#'   \item{\code{school}}{School (Pasteur or Grant-White)}
#'   \item{\code{grade}}{Grade}
#'   \item{\code{x1}}{Visual perception}
#'   \item{\code{x2}}{Cubes}
#'   \item{\code{x3}}{Lozenges}
#'   \item{\code{x4}}{Paragraph comprehension}
#'   \item{\code{x5}}{Sentence completion}
#'   \item{\code{x6}}{Word meaning}
#'   \item{\code{x7}}{Speeded addition}
#'   \item{\code{x8}}{Speeded counting of dots}
#'   \item{\code{x9}}{Speeded discrimination straight and curved capitals}
#' }
#' @source \code{lavaan} package
#' @references Holzinger, K., and Swineford, F. (1939). A study in factor
#'   analysis: The stability of a bifactor solution. Supplementary Educational
#'   Monograph, no. 48. Chicago: University of Chicago Press.
#'
#'   Joreskog, K. G. (1969). A general approach to confirmatory maximum
#'   likelihood factor analysis. \emph{Psychometrika}, 34, 183-202.
#' @examples
#' # The Holzinger and Swineford (1939) example
#' data(HolzingerSwineford1939)
"HolzingerSwineford1939"


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
#'   \item{\code{cwbcloserel}}{}
#'   \item{\code{cwbrespect}}{}
#'   \item{\code{cwbtrust}}{}
#'   \item{\code{cwbmutuality}}{}
#'   \item{\code{cwbbeneficence}}{}
#'   \item{\code{cwbintegrity}}{}
#'   \item{\code{cwbcompetence}}{}
#'   \item{\code{cwbvision}}{}
#'   \item{\code{cwbrelgrowth}}{}
#'   \item{\code{cwbfairness}}{}
#'   \item{\code{cwbsustenance}}{}
#'   \item{\code{cwbachieve}}{}
#'   \item{\code{cwbsatisf}}{}
#'   \item{\code{cwbvalue}}{}
#'   \item{\code{cwbbelonging}}{}
#'   \item{\code{cwbwelcome}}{}
#'   \item{\code{cwbpurpose}}{}
#'   \item{\code{cwbcontrib}}{}
#'   \item{\code{cwbinterconn}}{}
#'   \item{\code{cwbsynergy}}{}
#'   \item{\code{total_goodrel}}{Mean of items cwbcloserel, cwbrespect, cwbtrust, cwbmutuality}
#'   \item{\code{total_prolead}}{Mean of items cwbbeneficence, cwbintegrity, cwbcompetence, cwbvision}
#'   \item{\code{total_healthyprac}}{Mean of items cwbrelgrowth, cwbfairness, cwbsustenance, cwbachieve}
#'   \item{\code{total_satcomm}}{Mean of items cwbsatisf, cwbvalue, cwbbelonging, cwbwelcome}
#'   \item{\code{total_strongmiss}}{Mean of items cwbpurpose, cwbcontrib, cwbintercon, cwbsynergy}
#' }
#' @source Data used in Padgett et al. (in press).
#' @references Padgett, R.N., ...
#' @examples
#' # SCWB example used in preprint
#' data(SCWB)
"SCWB"
