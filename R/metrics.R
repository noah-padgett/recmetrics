#' REC Metric 1
#'
#' The average of the absolute values of the C-REC matrix entries (this is
#' essentially how much relative excess correlation there is still to distribute
#' across groupings)
#'
#' `r lifecycle::badge('experimental')`
#'
#' @param data A data.frame or tibble  (required)
#' @param na.rm logical (defaults to TRUE)
#' @returns A single numerical value
#' @examples {
#'   # Use the SCWB data example
#'   # Metric 1 - item scores
#'   rec.average(SCWB[, 1:20])
#'   # Metric 4 - domain total scores
#'   my_rec <- rec.average(SCWB[, 21:25])
#'   my_rec
#'   # Metric 4 - averages
#'   mean(abs(my_rec[lower.tri(my_rec)]))
#' }
#' @export
rec.average <- function(data, na.rm = TRUE) {
  Qij.star <- cor.rec(data, na.rm = na.rm)
  Qij.star <- Qij.star[lower.tri(Qij.star)]
  mean(abs(Qij.star))
}


#' REC Metric 2
#'
#' For each domain i, the average of the REC entries within domain vs. the
#' average of the REC entries when looking at correlations between indicators in
#' domain D=i with indicators in domains other than i (note that this does NOT
#' include correlations in domain j with other indicators in domain j; for a
#' given domain, it is basically the average of the REC entries within the domain
#' vs. the average of the REC entries for all of the other entries in the column
#' of that domain). We might call this the REC domain coherence for domain i
#'
#' `r lifecycle::badge('experimental')`
#'
#' @param data A data.frame or tibble  (required)
#' @param domainlist A list of character vectors or numeric vectors denoting the
#'  columns for each domain (required)
#' @param domainnames A character vector suppling updated names to be attached to
#'  output
#' @param na.rm logical (defaults to TRUE)
#' @returns A single numerical value
#' @examples {
#'   # Use the SCWB data example
#'   domain_goodrel <- c("cwbcloserel", "cwbrespect", "cwbtrust", "cwbmutuality")
#'   domain_prolead <- c("cwbbeneficence", "cwbintegrity", "cwbcompetence", "cwbvision")
#'   domain_healthyprac <- c("cwbrelgrowth", "cwbfairness", "cwbsustenance", "cwbachieve")
#'   domain_satcomm <- c("cwbsatisf", "cwbvalue", "cwbbelonging", "cwbwelcome")
#'   domain_strongmiss <- c("cwbpurpose", "cwbcontrib", "cwbinterconn", "cwbsynergy")
#'   mylist <- list(
#'     domain_goodrel,
#'     domain_prolead,
#'     domain_healthyprac,
#'     domain_satcomm,
#'     domain_strongmiss
#'   )
#'   rec.avg.wb.domains(SCWB, mylist)
#' }
#' @export
rec.avg.wb.domains <-
  function(data,
           domainlist = NULL,
           domainnames = NULL,
           na.rm = TRUE) {
    temp.data <- data
    if (is.null(domainlist)) {
      stop("Error. You must supply a list containing the items in each domain.")
    }

    if (is.null(domainnames)) {
      domainnames <- paste("Domain", 1:length(domainlist))
    }
    myvar <- colnames(temp.data)
    keep.var <- unlist(domainlist)
    temp.data <- temp.data %>%
      select(all_of(keep.var))

    # get REC matrix
    Qij.star <- cor.rec(temp.data, na.rm = na.rm)

    # setup output object
    out.dat <- data.frame(matrix(ncol = 3, nrow = length(domainnames)))
    colnames(out.dat) <-
      c(
        "Domain",
        "Avg_Rec_Within_Domain",
        "Avg_REC_Between_Domains"
      )
    out.dat$Domain <- domainnames

    i <- 1
    for (i in 1:length(domainlist)) {
      temp.cor <-
        Qij.star[(keep.var %in% domainlist[[i]]), (keep.var %in% domainlist[[i]])]
      out.dat[i, 2] <- mean(temp.cor[lower.tri(temp.cor)])

      temp.cor <-
        Qij.star[(keep.var %in% domainlist[[i]]), !(keep.var %in% domainlist[[i]])]
      out.dat[i, 3] <- mean(temp.cor)
    }

    out.dat
  }


#' REC Metric 3
#'
#' The average value of the REC domain coherence taken across domains (which,
#' when the domains all have the same number of indicators, I believe will also
#' equal the average within-domain REC vs. the average cross-domain REC); this
#' gives a measure of the coherence of the partition formed by the various
#' domains as a whole
#'
#' `r lifecycle::badge('experimental')`
#'
#' @param data A data.frame or tibble  (required)
#' @param domainlist A list of character vectors or numeric vectors denoting the
#'  columns for each domain (required)
#' @param domainnames A character vector suppling updated names to be attached to
#'  output
#' @param na.rm logical (defaults to TRUE)
#' @returns A single numerical value
#' @examples {
#'   # Use the SCWB data example
#'   domain_goodrel <- c("cwbcloserel", "cwbrespect", "cwbtrust", "cwbmutuality")
#'   domain_prolead <- c("cwbbeneficence", "cwbintegrity", "cwbcompetence", "cwbvision")
#'   domain_healthyprac <- c("cwbrelgrowth", "cwbfairness", "cwbsustenance", "cwbachieve")
#'   domain_satcomm <- c("cwbsatisf", "cwbvalue", "cwbbelonging", "cwbwelcome")
#'   domain_strongmiss <- c("cwbpurpose", "cwbcontrib", "cwbinterconn", "cwbsynergy")
#'   mylist <- list(
#'     domain_goodrel,
#'     domain_prolead,
#'     domain_healthyprac,
#'     domain_satcomm,
#'     domain_strongmiss
#'   )
#'   rec.coherence(SCWB, mylist)
#' }
#' @export
rec.coherence <-
  function(data,
           domainlist = NULL,
           domainnames = NULL,
           na.rm = TRUE) {
    temp.data <- data
    if (is.null(domainlist)) {
      stop("Error. You must supply a list containing the items in each domain.")
    }

    if (is.null(domainnames)) {
      domainnames <- paste("Domain", 1:length(domainlist))
    }
    myvar <- colnames(temp.data)
    keep.var <- unlist(domainlist)
    temp.data <- temp.data %>%
      select(all_of(keep.var))

    # get REC matrix
    Qij.star <- cor.rec(temp.data, na.rm = na.rm)

    within_cors <- between_cors <- NULL
    Qij.star[upper.tri(Qij.star)] <- NA
    i <- 1
    for (i in 1:length(domainlist)) {
      temp.cor <-
        Qij.star[(keep.var %in% domainlist[[i]]), (keep.var %in% domainlist[[i]])]
      within_cors <- c(within_cors, temp.cor[lower.tri(temp.cor)])

      temp.cor <-
        Qij.star[(keep.var %in% domainlist[[i]]), !(keep.var %in% domainlist[[i]])]
      between_cors <- c(between_cors, c(temp.cor))
    }
    # setup output object
    out.dat <- data.frame(matrix(ncol = 2, nrow = 2))
    colnames(out.dat) <- c("Metric", "Average")
    out.dat$Metric <-
      c("REC Average Within Domain", "REC Average Between Domains")
    out.dat$Average <-
      c(mean(within_cors, na.rm = TRUE), mean(between_cors, na.rm = TRUE))

    out.dat
  }


#' REC Metric 3
#'
#' An (Number of Items)x(Number of Domains) matrix such that each row
#' corresponds to an indicator, and the entry in column i is the average REC
#' score for that indicator with the other indicators in domain i. This will
#' allow one in some sense to see if certain indicators seem to have higher REC
#' scores in a domain other than to the other in which they were assigned
#'
#' `r lifecycle::badge('experimental')`
#'
#' @param data A data.frame or tibble  (required)
#' @param domainlist A list of character vectors or numeric vectors denoting the
#'   columns for each domain (required)
#' @param domainnames A character vector suppling updated names to be attached
#'   to output
#' @param labels A character vector supplying updated variable names to be
#'   attached to output
#' @param na.rm logical (defaults to TRUE)
#' @returns A single numerical value
#' @examples {
#'   # Use the SCWB data example
#'   domain_goodrel <- c("cwbcloserel", "cwbrespect", "cwbtrust", "cwbmutuality")
#'   domain_prolead <- c("cwbbeneficence", "cwbintegrity", "cwbcompetence", "cwbvision")
#'   domain_healthyprac <- c("cwbrelgrowth", "cwbfairness", "cwbsustenance", "cwbachieve")
#'   domain_satcomm <- c("cwbsatisf", "cwbvalue", "cwbbelonging", "cwbwelcome")
#'   domain_strongmiss <- c("cwbpurpose", "cwbcontrib", "cwbinterconn", "cwbsynergy")
#'   mylist <- list(
#'     domain_goodrel,
#'     domain_prolead,
#'     domain_healthyprac,
#'     domain_satcomm,
#'     domain_strongmiss
#'   )
#'   rec.pattern.matrix(SCWB, mylist)
#' }
#' @export
rec.pattern.matrix <-
  function(data,
           domainlist = NULL,
           domainnames = NULL,
           labels = NULL,
           na.rm = TRUE) {
    temp.data <- data
    if (is.null(domainlist)) {
      stop("Error. You must supply a list containing the items in each domain.")
    }

    myvar <- colnames(temp.data)
    keep.var <- unlist(domainlist)
    temp.data <- temp.data %>%
      select(all_of(keep.var))

    if (is.null(domainnames)) {
      domainnames <- paste0("Domain", 1:length(domainlist))
    }
    if (is.null(labels)) {
      labels <- keep.var
    }

    # get REC
    Qij.star <- cor.rec(temp.data, na.rm = na.rm)

    # output object
    out.dat <-
      as.data.frame(matrix(ncol = length(domainnames) + 1, nrow = length(keep.var)))
    colnames(out.dat) <- c("Item", domainnames)
    out.dat$Item <- labels


    diag(Qij.star) <- NA
    i <- d <- 1
    for (i in 1:length(keep.var)) {
      for (d in 1:length(domainlist)) {
        temp.cor <-
          Qij.star[(keep.var %in% keep.var[i]), (keep.var %in% domainlist[[d]])]
        out.dat[i, d + 1] <- mean(temp.cor, na.rm = TRUE)
      }
    }

    out.dat
  }
