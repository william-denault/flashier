

library(wdflashier)
library(dplyr)
fit_with_perm <- wdflashier:: flash_init(gtex
                                      ) %>%
  flash_set_verbose(0) %>%

  flash_add_intercept(rowwise = FALSE) %>%
   flash_factors_init(svd(gtex )) %>%
  flash_greedy(
     Kmax=7,
    ebnm_fn = c( ebnm_ash, ebnm_ash)
  )%>%
  flash_backfit( )


library(flashier)
fit_without_perm <- flashier:: flash_init(gtex
) %>%
  flash_set_verbose(0) %>%

  flash_add_intercept(rowwise = FALSE) %>%
 flash_factors_init(svd(gtex )) %>%
  flash_greedy(
     Kmax=7,
    ebnm_fn = c( ebnm_ash, ebnm_ash)
  )%>%
  flash_backfit( )


fit_with_perm$elbo

fit_without_perm$elbo
library(ggplot2)
library(cowplot)
library(dplyr)

p2 <- plot(
  fit_with_perm,
  pm_which = "factors",
  pm_colors = gtex_colors,
  include_scree = FALSE
) + ggtitle("With SFS perm ")
p3 <- plot(
  fit_without_perm,
  pm_which = "factors",
  pm_colors = gtex_colors,
  include_scree = FALSE
) + ggtitle("Without SFS perm current implementation ")
plot_grid( p2,p3 ,ncol = 2)

fit_with_perm$elbo

fit_without_perm$elbo
