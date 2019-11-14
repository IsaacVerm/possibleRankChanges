add_rank <- function(league_table) {
  league_table %>%
    dplyr::mutate(rank = dplyr::min_rank(dplyr::desc(total_points)))
}
