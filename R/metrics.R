# Script for REC metrics

### Metrics of C-REC


#1. The average of the absolute values of the C-REC matrix entries (this is essentially how much relative excess correlation there is still to distribute across groupings)
rec.average <- function(data, na.rm=T){
  Qij.star <- cor.rec(data, na.rm=na.rm)
  Qij.star <- Qij.star[lower.tri(Qij.star,diag = F)]
  mean(abs(Qij.star)))
}





2.	For each domain i, the average of the C-REC entries within domain vs. the average of the C-REC entries when looking at correlations between indicators in domain D=i with indicators in domains other than i (note that this does NOT include correlations in domain j with other indicators in domain j; for a given domain, it is basically the average of the C-REC entries within the domain vs. the average of the C-REC entries for all of the other entries in the column of that domain). We might call this the C-REC domain coherence for domain i



rownames(Qij.star) <- colnames(Qij.star) <- ITEMS

ITEMS.i <- c("total_goodrel", "total_prolead", "total_healthyprac", "total_satcomm", "total_strongmiss")
out.dat <- data.frame(matrix(ncol=3, nrow=length(ITEMS.i)))
colnames(out.dat) <- c("Domain", "Avg C-Rec Within Domain", "Avg C-REC of domain items with items of other domains")
out.dat$Domain <- DOMAIN.BETTER.LABELS

Dlist <- list(  ITEMS_goodrel, ITEMS_prolead, ITEMS_healthyprac, ITEMS_satcomm, ITEMS_strongmiss)

i <- 1
for(i in 1:length(Dlist)){
  temp.cor <- Qij.star[(ITEMS %in% Dlist[[i]]), (ITEMS %in% Dlist[[i]])]
  out.dat[i,2] <- mean(temp.cor[lower.tri(temp.cor)])

  temp.cor <- Qij.star[(ITEMS %in% Dlist[[i]]), !(ITEMS %in% Dlist[[i]])]
  out.dat[i,3] <- mean(temp.cor)
}

fit_flextable(flextable(out.dat))

```


3.	The average value of the C-REC domain coherence taken across domains (which, when the domains all have the same number of indicators, I believe will also equal the average within-domain C-REC vs. the average cross-domain C-REC); this gives a measure of the coherence of the partition formed by the various domains as a whole

```{r}
#| label: c-rec-metric-3
#| echo: true
#| warning: FALSE
#| message: FALSE
#| error: FALSE
#| tbl-cap: "Metric 3"
#| tbl-cap-location: top


Qij.star2 <- Qij.star

within_cors <- between_cors <- NULL
Qij.star2[upper.tri(Qij.star2)] <- NA
i <- 1
for(i in 1:length(Dlist)){
  temp.cor <- Qij.star2[(ITEMS %in% Dlist[[i]]), (ITEMS %in% Dlist[[i]])]
  within_cors <-c(within_cors,temp.cor[lower.tri(temp.cor)])

  temp.cor <- Qij.star2[(ITEMS %in% Dlist[[i]]), !(ITEMS %in% Dlist[[i]])]
  between_cors <-c(between_cors,c(temp.cor))
}

cat("Average Within Domain C-REC: ", .round(mean(within_cors)))

cat("Average Between Domain C-REC: ", .round(mean(between_cors, na.rm=T)))

```

4.	The 5x5 C-REC matrix for the domain scores, along with the average of the absolute values of the entries of this matrix

```{r}
#| label: c-rec-metric-4
#| echo: true
#| warning: FALSE
#| message: FALSE
#| error: FALSE
#| tbl-cap: "Metric 4"
#| tbl-cap-location: top


ITEMS.i <- c("total_goodrel", "total_prolead", "total_healthyprac", "total_satcomm", "total_strongmiss")

temp.dat <- analysis_data %>%
  select(all_of(ITEMS.i)) %>%
  mutate(
    x.mean = rowMeans(across(all_of(ITEMS.i))),
    across(all_of(ITEMS.i), ~ .x - x.mean, .names="resid_{.col}")
  ) %>% select(!x.mean) %>%
  na.omit()

cor.out <- as.data.frame(matrix(ncol=length(ITEMS.i)+2,nrow=length(ITEMS.i)))
colnames(cor.out) <- c("item", paste0("(",1:length(ITEMS.i),")"), "Mean Cor")
cor.out$item <- DOMAIN.BETTER.LABELS

Cij <- cor(temp.dat %>% select(!contains("resid_")))
diag(Cij) <- NA

rho.i <- rowMeans(Cij, na.rm = T)
rho.. <- mean(Cij, na.rm=T)

Qij.star <- matrix(nrow=ncol(Cij),ncol=ncol(Cij))
for(i in 1:ncol(Cij)){
  for(j in 1:ncol(Cij)){
    if(i != j){
      Qij.star[i,j] = (Cij[i,j] - rho..) - ((rho.i[i]-rho..)+(rho.i[j]-rho..))
    }
  }
}

cor.out[,2:(length(ITEMS.i)+1)] <- Qij.star
diag(cor.out[,2:(length(ITEMS.i)+1)]) <- NA
cor.out$`Mean Cor` <- cor.rowMeans(Qij.star)

fit_flextable(flextable(cor.out))

cat("Average absoluate C-REC: ", .round(mean(abs(Qij.star[lower.tri(Qij.star,diag = F)]))))

```


5.	A 20x5 matrix such that each row corresponds to an indicator, and the entry in column i is the average C-REC score for that indicator with the other indicators in domain i. This will allow one in some sense to see if certain indicators seem to have higher C-REC scores in a domain other than to the other in which they were assigned

```{r}
#| label: c-rec-metric-5
#| echo: true
#| warning: FALSE
#| message: FALSE
#| error: FALSE
#| tbl-cap: "Metric 5"
#| tbl-cap-location: top

ITEMS.i <- ITEMS
temp.dat <- analysis_data %>%
  select(all_of(ITEMS.i)) %>%
  mutate(
    x.mean = rowMeans(across(all_of(ITEMS.i))),
    across(all_of(ITEMS.i), ~ .x - x.mean, .names="resid_{.col}")
  ) %>% select(!x.mean) %>%
  na.omit()

out.dat <- as.data.frame(matrix(ncol=length(DOMAIN.BETTER.LABELS)+1,nrow=length(ITEMS.i)))
colnames(out.dat) <- c("Item", DOMAIN.BETTER.LABELS)
out.dat$Item <- ITEMS.BETTER.LABELS

Cij <- cor(temp.dat %>% select(!contains("resid_")))
diag(Cij) <- NA

rho.i <- rowMeans(Cij, na.rm = T)
rho.. <- mean(Cij, na.rm=T)

Qij.star <- matrix(nrow=ncol(Cij),ncol=ncol(Cij))
for(i in 1:ncol(Cij)){
  for(j in 1:ncol(Cij)){
    if(i != j){
      Qij.star[i,j] = (Cij[i,j] - rho..) - ((rho.i[i]-rho..)+(rho.i[j]-rho..))
    }
  }
}

Dlist <- list(  ITEMS_goodrel, ITEMS_prolead, ITEMS_healthyprac, ITEMS_satcomm, ITEMS_strongmiss)

diag(Qij.star) <- NA
i <- d <- 1
for(i in 1:length(ITEMS.i)){
  for(d in 1:length(DOMAIN.BETTER.LABELS)){
    temp.cor <- Qij.star[(ITEMS %in% ITEMS.i[i]), (ITEMS %in% Dlist[[d]])]
    out.dat[i,d+1] <- mean(temp.cor, na.rm=T)
  }
}

fit_flextable(flextable(out.dat))

```
