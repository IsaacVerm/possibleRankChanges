create_possible_gameweek_points <- function(nr_teams) {
  possible_outcomes_by_game <- rep(list(c(0,1,3)), 8)

  return(expand.grid(possible_outcomes_by_game))
}

select_gameweek <- function(upcoming_games, selected_gameweek_nr) {
  upcoming_gameweek <- upcoming_games %>%
    dplyr::filter(gameweek == selected_gameweek_nr)
}

calculate_nr_unique_teams <- function(gameweek) {
  unique(gameweek$home_team) %>% length
}

create_possible_gameweeks <- function(nr_possible_gameweeks,
                                      possible_gameweek_points,
                                      gameweek) {
  seq(from = 1, to = nr_possible_gameweeks) %>%
    purrr::map(function(counter) {
      outcome <- possible_gameweek_points[counter, ] %>% as.integer
      gameweek %>%
        dplyr::mutate(home_points = outcome) %>%
        possibleRankChanges::add_away_points()
    })
}

simulate_possible_gameweeks <- function(upcoming_games,
                                        selected_gameweek_nr) {
  gameweek <- select_gameweek(upcoming_games, selected_gameweek_nr)

  nr_unique_teams <- calculate_nr_unique_teams(gameweek)
  possible_gameweek_points <- create_possible_gameweek_points(nr_unique_teams)

  nr_possible_gameweeks <- nrow(possible_gameweek_points)

  create_possible_gameweeks(nr_possible_gameweeks,
                            possible_gameweek_points,
                            gameweek)
}
