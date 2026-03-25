grp1 = response$groupOne
map_dfr(grp1,
  function(user) {
    # Unpack data for each user.
    tibble(
      user_name = user$name,
      duration = user$duration,
      amount = user$amount,
      amounts = map_df(user$amounts, identity),
      projects = "")
  }
)



map_df(user$amounts, identity)
map(user$amounts, ~ map(., identity))



response$groupOne %>% map_dfr(
  function(user) {
    # Unpack data for each user.
    tibble(
      user_name = user$name,
      duration = user$duration,
      amount = user$amount,
      amounts = map_df(user$amounts, identity),
      projects = list(
        map_dfr(
          user$children,
          function(project) {
            # Unpack data for each client/project.
            tibble(
              client_name = project$clientName,
              project_name = project$name,
              duration = project$duration,
              amount = project$amount,
              entries = list(
                map_dfr(
                  project$children,
                  function(entry) {
                    # Unpack data for each time entry.
                    entry$amounts <- NULL
                    as_tibble(entry) %>%
                      clean_names() %>%
                      select(id, description = name, duration, amount)
                  }
                )
              )
            )
          }
        )
      )
    )
  }
) -> res

