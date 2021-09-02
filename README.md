{clockify}
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

# clockify <img src="man/figures/clockify-hex.png" align="right" alt="" width="120" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/clockify)](https://cran.r-project.org/package=clockify)
[![Travis-CI build
status](https://travis-ci.org/datawookie/clockify.svg?branch=master)](https://travis-ci.org/datawookie/clockify)
[![Codecov test
coverage](https://img.shields.io/codecov/c/github/datawookie/clockify.svg)](https://codecov.io/github/datawookie/clockify)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![R-CMD-check](https://github.com/datawookie/clockify/workflows/R-CMD-check/badge.svg)](https://github.com/datawookie/clockify/actions)
<!-- badges: end -->

An R wrapper around the [Clockify
API](https://clockify.me/developers-api).

The documentation for `{clockify}` is hosted at
<https://datawookie.github.io/clockify/>.

## API Key

You’re going to need to have an API key from your Clockify account. If
you don’t yet have an account, create one. Then retrieve the API key
from the [account settings](https://clockify.me/user/settings).

## Get Started

The first thing you’ll need to do is set up your API key. I store mine
in an environment variable called `CLOCKIFY_API_KEY`.

``` r
CLOCKIFY_API_KEY = Sys.getenv("CLOCKIFY_API_KEY")
```

Now load the `{clockify}` package and specify the API key.

``` r
library(clockify)

set_api_key(CLOCKIFY_API_KEY)
```

Let’s turn on some logging so we can see what’s happening behind the
scenes.

``` r
library(logger)

log_threshold(DEBUG)
```

## Workspaces

Retrieve a list of available workspaces.

``` r
workspaces()
```

    2021-09-01 03:43:27 — GET /workspaces

    # A tibble: 2 × 2
      workspace_id             name    
      <chr>                    <chr>   
    1 612b15a5f4c3bf0462192677 Personal
    2 612b1708f4c3bf0462192861 Work    

Select a specific workspace.

``` r
workspace("612b15a5f4c3bf0462192677")
```

    2021-09-01 03:43:27 — Set active workspace -> 612b15a5f4c3bf0462192677.

    [1] "612b15a5f4c3bf0462192677"

## Users

Retrieve information on your user profile.

``` r
user()
```

    2021-09-01 03:43:27 — GET /user

    # A tibble: 1 × 3
      user_id                  user_name status
      <chr>                    <chr>     <chr> 
    1 612b15a4f4c3bf0462192676 Andrew    ACTIVE

Get a list of users.

``` r
users()
```

    2021-09-01 03:43:27 — GET /workspaces/612b15a5f4c3bf0462192677/users

    # A tibble: 2 × 3
      user_id                  user_name status
      <chr>                    <chr>     <chr> 
    1 612b15a4f4c3bf0462192676 Andrew    ACTIVE
    2 5ef46293df73063139f60bf5 Emma      ACTIVE

## Clients

Get a list of clients.

``` r
clients()
```

    2021-09-01 03:43:27 — GET /workspaces/612b15a5f4c3bf0462192677/clients

    # A tibble: 1 × 3
      client_id                client_name workspace_id            
      <chr>                    <chr>       <chr>                   
    1 612b16adff6efe46f554bf9f Fathom Data 612b15a5f4c3bf0462192677

## Projects

Get a list of projects.

``` r
projects()
```

    2021-09-01 03:43:27 — GET /workspaces/612b15a5f4c3bf0462192677/projects
    2021-09-01 03:43:27 — Page contains 2 results.
    2021-09-01 03:43:27 — GET /workspaces/612b15a5f4c3bf0462192677/projects
    2021-09-01 03:43:27 — Page is empty.
    2021-09-01 03:43:27 — API returned 2 results.

    # A tibble: 2 × 4
      project_id               project_name client_id                billable
      <chr>                    <chr>        <chr>                    <lgl>   
    1 612b16c0bc325f120a1e5099 {clockify}   612b16adff6efe46f554bf9f TRUE    
    2 612b16b1ff6efe46f554bfa1 {emayili}    612b16adff6efe46f554bf9f TRUE    

## Time Entries

### Retrieve Time Entries

Retrieve the time entries for the authenticated user.

``` r
time_entries()
```

    2021-09-01 03:43:28 — GET /user
    2021-09-01 03:43:28 — GET /workspaces/612b15a5f4c3bf0462192677/user/612b15a4f4c3bf0462192676/time-entries
    2021-09-01 03:43:28 — Page contains 3 results.
    2021-09-01 03:43:28 — GET /workspaces/612b15a5f4c3bf0462192677/user/612b15a4f4c3bf0462192676/time-entries
    2021-09-01 03:43:28 — Page is empty.
    2021-09-01 03:43:28 — API returned 3 results.

    # A tibble: 3 × 3
      project_id               description               duration
      <chr>                    <chr>                        <dbl>
    1 612b16c0bc325f120a1e5099 Setting up GitHub Actions       12
    2 612b16c0bc325f120a1e5099 Make coffee                     18
    3 612b16c0bc325f120a1e5099 Populating README.Rmd           68

Retrieve time entries for another user specified by their user ID.

``` r
time_entries(user_id = "5ef46293df73063139f60bf5")
```

    2021-09-01 03:43:28 — GET /workspaces/612b15a5f4c3bf0462192677/user/5ef46293df73063139f60bf5/time-entries
    2021-09-01 03:43:28 — Page contains 1 results.
    2021-09-01 03:43:28 — GET /workspaces/612b15a5f4c3bf0462192677/user/5ef46293df73063139f60bf5/time-entries
    2021-09-01 03:43:28 — Page is empty.
    2021-09-01 03:43:28 — API returned 1 results.

    # A tibble: 1 × 3
      project_id               description       duration
      <chr>                    <chr>                <dbl>
    1 612b16c0bc325f120a1e5099 Creating hex logo     45.0

### Insert Time Entry

``` r
prepare_cran_id <- time_entry_insert(
 project_id = "612b16c0bc325f120a1e5099",
 start = "2021-08-30 08:00:00",
 end   = "2021-08-30 10:30:00",
 description = "Prepare for CRAN submission"
)
```

    2021-09-01 03:43:28 — Insert time entry.
    2021-09-01 03:43:28 — POST /workspaces/612b15a5f4c3bf0462192677/time-entries

Check on the ID for this new time entry.

``` r
prepare_cran_id
```

    [1] "612ee8d0836477744be266ea"

Confirm that it has been inserted.

``` r
time_entries("612b15a4f4c3bf0462192676", concise = FALSE) %>%
  select(id, description, time_start, time_end)
```

    2021-09-01 03:43:28 — GET /workspaces/612b15a5f4c3bf0462192677/user/612b15a4f4c3bf0462192676/time-entries
    2021-09-01 03:43:28 — Page contains 4 results.
    2021-09-01 03:43:28 — GET /workspaces/612b15a5f4c3bf0462192677/user/612b15a4f4c3bf0462192676/time-entries
    2021-09-01 03:43:28 — Page is empty.
    2021-09-01 03:43:28 — API returned 4 results.

    # A tibble: 4 × 4
      id                       description                 time_start         
      <chr>                    <chr>                       <dttm>             
    1 612b17ff5287f7468e701971 Setting up GitHub Actions   2021-08-29 06:15:00
    2 612b184f5287f7468e7019c3 Make coffee                 2021-08-29 06:27:00
    3 612b1f4f73ce921672c1134b Populating README.Rmd       2021-08-29 06:45:00
    4 612ee8d0836477744be266ea Prepare for CRAN submission 2021-08-30 09:00:00
      time_end           
      <dttm>             
    1 2021-08-29 06:27:00
    2 2021-08-29 06:45:00
    3 2021-08-29 07:53:00
    4 2021-08-30 11:30:00

### Delete Time Entry

``` r
time_entry_delete(prepare_cran_id)
```

    2021-09-01 03:43:28 — Delete time entry.
    2021-09-01 03:43:28 — DELETE /workspaces/612b15a5f4c3bf0462192677/time-entries/612ee8d0836477744be266ea

    [1] TRUE

Confirm that it has been deleted.

``` r
time_entries("612b15a4f4c3bf0462192676", concise = FALSE) %>%
  select(id, description, time_start, time_end)
```

    2021-09-01 03:43:28 — GET /workspaces/612b15a5f4c3bf0462192677/user/612b15a4f4c3bf0462192676/time-entries
    2021-09-01 03:43:28 — Page contains 3 results.
    2021-09-01 03:43:28 — GET /workspaces/612b15a5f4c3bf0462192677/user/612b15a4f4c3bf0462192676/time-entries
    2021-09-01 03:43:28 — Page is empty.
    2021-09-01 03:43:28 — API returned 3 results.

    # A tibble: 3 × 4
      id                       description               time_start         
      <chr>                    <chr>                     <dttm>             
    1 612b17ff5287f7468e701971 Setting up GitHub Actions 2021-08-29 06:15:00
    2 612b184f5287f7468e7019c3 Make coffee               2021-08-29 06:27:00
    3 612b1f4f73ce921672c1134b Populating README.Rmd     2021-08-29 06:45:00
      time_end           
      <dttm>             
    1 2021-08-29 06:27:00
    2 2021-08-29 06:45:00
    3 2021-08-29 07:53:00