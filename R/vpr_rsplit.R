vpr_split_years <- \(data, years = seq(ncol(idx))) {
  purrr::pmap_df(
    tibble::tibble(
      years = years
      ),
    \(years) {
      data |>
      vpr_split_year(initial = idx[seq(nrow(idx)), years])
    }
  )
}

df |> vpr_split_years() |>


purrr::pmap_df(
  tibble::tibble(
    years = seq(ncol(idx))
  ),
  \(years) {
    df |>
      vpr_split_year(initial = idx[seq(nrow(idx)), years])
  }
)
