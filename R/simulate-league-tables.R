add_new_rank <- function(simulated_league_table) {
  simulated_league_table %>%
    dplyr::mutate(new_rank = dplyr::min_rank(dplyr::desc(new_total_points)))
}


simulate_possible_league_tables <-
  function(league_table, possible_points_by_team) {
    possible_points_by_team %>%
      purrr::map(function(points_per_team) {
        dplyr::left_join(x = league_table,
                         y = points_per_team,
                         by = "team") %>%
          dplyr::mutate(new_total_points = total_points + points) %>%
          add_new_rank()
      })
  }

league_tables_to_df <- function(league_tables) {
  dplyr::bind_rows(league_tables)
}

add_rank_difference <- function(simulated_leagues_table) {
  simulated_leagues_table %>%
    dplyr::mutate(rank_difference = rank - new_rank)
}
