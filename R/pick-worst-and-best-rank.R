biggest_drop_in_rank <- function(possible_league_tables) {
  possible_league_tables %>%
    dplyr::group_by(team) %>%
    dplyr::summarise(biggest_drop_in_rank = min(rank_difference))
}

biggest_rank_increase <- function(possible_league_tables) {
  possible_league_tables %>%
    dplyr::group_by(team) %>%
    dplyr::summarise(biggest_rank_increase = max(rank_difference))
}

create_rank_table <- function(league_table, possible_league_tables) {
  league_table %>%
    dplyr::select(team, rank) %>%
    dplyr::left_join(biggest_drop_in_rank(possible_league_tables), by = "team") %>%
    dplyr::left_join(biggest_rank_increase(possible_league_tables), by = "team") %>%
    dplyr::mutate(lowest_rank = rank - biggest_drop_in_rank) %>%
    dplyr::mutate(highest_rank = rank - biggest_rank_increase)
}
