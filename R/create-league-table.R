game_results_to_df <- function(game_results) {
  dplyr::bind_rows(game_results)
}
