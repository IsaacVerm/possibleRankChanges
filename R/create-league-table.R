games_to_df <- function(list_games) {
  dplyr::bind_rows(list_games)
}

create_home_league_table <- function(game_results) {
  game_results %>%
    dplyr::group_by(home_team) %>%
    dplyr::summarise(total_home_points = sum(home_points))
}

create_away_league_table <- function(game_results) {
  game_results %>%
    dplyr::group_by(away_team) %>%
    dplyr::summarise(total_away_points = sum(away_points))
}

create_league_table <- function(home_league_table, away_league_table) {
  home_league_table %>%
    dplyr::left_join(away_league_table, by = c("home_team" = "away_team")) %>%
    dplyr::rename(team = home_team) %>%
    dplyr::mutate(total_points = total_home_points + total_away_points)
}


