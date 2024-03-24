# Copyright 2023 Province of Alberta
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set.seed(13)
day <- 1:365
simulated_data <-
  -15 * cos((2 * pi / 365) * (day - 10)) + rnorm(365, mean = 10, sd = .5)
simulated_data[simulated_data < 0] <- 0

simulated_data <- tibble::tibble(
  date = seq.Date(
    from = as.Date("2019-01-01"),
    to = as.Date("2019-12-31"),
    by = "day"
  ),
  synthetic = simulated_data
)
usethis::use_data(simulated_data, overwrite = TRUE)
