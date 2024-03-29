# paths are defined in zzz.R
# these helpers read games or fd_model and save them to a package cache

nfl4th_games_path <- function()   file.path(R_user_dir("nfl4th", "cache"), "games_nfl4th.rds")
nfl4th_fdmodel_path <- function() file.path(R_user_dir("nfl4th", "cache"), "fd_model.rds")
nfl4th_wpmodel_path <- function() file.path(R_user_dir("nfl4th", "cache"), "wp_model.rds")

.games_nfl4th <- function(){
  if (probably_cran() && !force_cache()) return(get_games_file())
  if (!file.exists(nfl4th_games_path())){
    saveRDS(get_games_file(), nfl4th_games_path())
  }
  readRDS(nfl4th_games_path())
}

fd_model <- function(){
  if (probably_cran() && !force_cache()) return(load_fd_model())
  if (!file.exists(nfl4th_fdmodel_path())){
    saveRDS(load_fd_model(), nfl4th_fdmodel_path())
  }
  readRDS(nfl4th_fdmodel_path())
}

wp_model <- function(){
  if (probably_cran() && !force_cache()) return(load_wp_model())
  if (!file.exists(nfl4th_wpmodel_path())){
    saveRDS(load_wp_model(), nfl4th_wpmodel_path())
  }
  readRDS(nfl4th_wpmodel_path())
}

#' Reset nfl4th Package Cache
#'
#' @param type One of `"games"` (the default), `"fd_model"`, or `"all"`.
#'   `"games"` will remove an internally used games file.
#'   `"fd_model"` will remove the nfl4th 4th down model (only necessary in the
#'   unlikely case of a model update).
#'   `"wp_model"` will remove the nfl4th win probability model (only necessary in the
#'   unlikely case of a model update).
#'   `"all"` will remove all of the above.
#'
#' @return Returns `TRUE` invisibly if cache has been cleared.
#' @export
#'
#' @examples
#' nfl4th_clear_cache()
nfl4th_clear_cache <- function(type = c("games", "fd_model", "wp_model", "all")){
  type <- rlang::arg_match(type)
  to_delete <- switch (type,
    "games" = nfl4th_games_path(),
    "fd_model" = nfl4th_fdmodel_path(),
    "wp_model" = nfl4th_wpmodel_path(),
    "all" = c(nfl4th_games_path(), nfl4th_fdmodel_path(), nfl4th_wpmodel_path())
  )
  file.remove(to_delete[file.exists(to_delete)])
  invisible(TRUE)
}

# The env var _R_CHECK_EXAMPLE_TIMING_CPU_TO_ELAPSED_THRESHOLD_ is mostly
# a CRAN env var. We use it to decide if the code likely is running on CRAN
probably_cran <- function(){
  cpu_threshold <- Sys.getenv(
    "_R_CHECK_EXAMPLE_TIMING_CPU_TO_ELAPSED_THRESHOLD_", NA_character_
    )
  !is.na(cpu_threshold)
}

# allow user to force the cache even if probably_cran() is TRUE
force_cache <- function() {
  getOption("nfl4th.force_cache", "false") == "true"
}
