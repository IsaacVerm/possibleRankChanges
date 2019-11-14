plot_rank_changes <- function(rank_table) {
  ggplot2::ggplot(data = rank_table,
                  ggplot2::aes(x = reorder(team, rank), y = rank)) +
    ggplot2::geom_linerange(ggplot2::aes(ymin = lowest_rank,
                                         ymax = highest_rank)) +
    ggplot2::geom_point() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 1))
}
