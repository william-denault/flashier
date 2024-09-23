

library(wdflashier)
library(dplyr)
fit_alternative_backfit <- wdflashier:: flash_init(gtex
                                      ) %>%
  flash_set_verbose(0) %>%

  flash_add_intercept(rowwise = FALSE) %>%
  flash_factors_init(svd(gtex, nu = 5, nv = 5)) %>%
  flash_greedy(
    Kmax = 7,
    ebnm_fn = c( ebnm_ash, ebnm_ash)
  )%>%
  flash_backfit(verbose = 0 )


library(flashier)
fit_alternative_orig <- flashier:: flash_init(gtex
) %>%
  flash_set_verbose(0) %>%

  flash_add_intercept(rowwise = FALSE) %>%
  flash_factors_init(svd(gtex, nu = 5, nv = 5)) %>%
  flash_greedy(

    Kmax = 7,
    ebnm_fn = c( ebnm_ash, ebnm_ash)
  )%>%
  flash_backfit(verbose = 0 )


fit_alternative_backfit$elbo

fit_alternative_orig$elbo
library(ggplot2)
library(cowplot)
library(dplyr)

p2 <- plot(
  fit_alternative_backfit,
  pm_which = "factors",
  pm_colors = gtex_colors,
  include_scree = FALSE
) + ggtitle("With SFS perm ")
p3 <- plot(
  fit_alternative_orig,
  pm_which = "factors",
  pm_colors = gtex_colors,
  include_scree = FALSE
) + ggtitle("Without SFS perm ")
plot_grid( p2,p3 ,ncol = 2)

fit_alternative_orig$elbo
fit_alternative_backfit$elbo
