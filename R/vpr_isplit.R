vpr_split_year <- \(data, initial = idx[seq(nrow(idx)), 1], n_col = 15) {
  purrr::pmap_df(
    tibble::tibble(
      initial = initial,
      n_col = n_col
    ),
    \(initial, n_col) {
      data |>
        vpr_split_one(
          initial = initial,
          n_col = n_col
        )
    }
  )
}

# df |> vpr_split_year()


