add_home_points <- function(game_results) {
  game_results %>%
    dplyr::mutate(
      home_points = dplyr::case_when(
        home_score > away_score ~ 3,
        home_score == away_score ~ 1,
        home_score < away_score ~ 0
      )
    )
}

add_away_points <- function(game_results) {
  game_results %>%
    dplyr::mutate(
      away_points = dplyr::case_when(
        home_points == 3 ~ 0,
        home_points == 1 ~ 1,
        home_points == 0 ~ 3
      )
    )
}


