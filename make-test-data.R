
example_row <- list(
  list(
    `_value` = "2019-08-09 04:19:25.253",
    `_formattedValue` = "8/9/2019 4:19:25 AM"
  ),
  list(
    `_value` = 3,
    `_formattedValue` = "3"
  ),
  list(
    `_value` = 2438084,
    `_formattedValue` = "2438084"
  ),
  list(
    `_value` = "Liberal",
    `_formattedValue` = "Liberal"
  ),
  list(
    `_value` = "Lean Agree",
    `_formattedValue` = "Lean Agree"
  ),
  list(
    `_value` = "Lean Agree",
    `_formattedValue` = "Lean Agree"
  ),
  list(
    `_value` = "2019-08-09 04:19:25.253",
    `_formattedValue` = "8/9/2019 4:19:25 AM"
  ),
  list(
    `_value` = 0.884,
    `_formattedValue` = "0.884"
  ),
  list(
    `_value` = 24697,
    `_formattedValue` = "24,697.46"
  ),
  list(
    `_value` = 1,
    `_formattedValue` = "1"
  ),
  list(
    `_value` = 1,
    `_formattedValue` = "1"
  ),
  list(
    `_value` = 1,
    `_formattedValue` = "1"
  )
)

df <- list_along(1:10000)


map(1:10000, .f = function(x){df[[x]] <<- example_row})




