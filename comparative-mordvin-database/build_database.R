setwd("comparative-mordvin-database/")
rmarkdown::render(input = "database.Rmd", output_file = "../database.html")
setwd("..")