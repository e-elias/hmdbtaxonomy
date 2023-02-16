#' Input to function is a csv file and the output is OUTPUT.csv.
#' Metabolite names should be under a column named "metabolites".
#' HMDB IDs will be outputted to a column "hmdb_id".
#' Please make sure these columns are already included in the input csv.
#' Please also load in the variable hmdb from an rda file or generated from
#' hmdb_parse.
#' Matches will only be made when the name is direct match for the official
#' HMDB ID name, not synonyms.

hmdb_name_match <- function(sheetName) {

  metabolite_search <- function(input) {
    out <- NULL
    #input = readline(prompt = "Enter metabolite name: ")
    #print(input)
    size <- xmlSize(hmdb)
    for(i in 1:size) {
      name1 <- hmdb[[i]][c("names")]
      name1 <- name1[[1]]
      #nameSize <- xmlSize(name1)
      # for (i1 in 1:nameSize) {
      if (!is.na(input)) {
        if (name1[[1]] == input) {
          out <- hmdb[[i]][c("hmdb_id")]
          out <- out[[1]]
          break
        }
      }
      # }
    }
    if (is.null(out) == 1) {
      #print(paste0(input, " not found"))
      output <- "NA"
    }
    else {
      #print(paste0(input, " HMDB ID is ", out))
      output <- out
    }
    return (output)
  }

  sheet <- read.csv(sheetName, na.string = "NA")
  x <- sheet[[c("hmbd_id")]]
  x <- length(unique(x))
  #print(paste0(x, " unique metabolites before annotation"))

  x<- sheet[[c("hmdb_id")]]
  y <- 0
  for (i in 1:length(x)) {
    if (!is.na(x[i])) {
      y = y + 1
    }
  }
  #print(paste0(y, " total metabolites found before annotation"))

  sheet1 <- as.list(sheet["metabolites"])
  sheet1 <- sheet[[c("metabolites")]]

  len <- length(sheet1)
  for (i2 in 1:len-1) {
    if (is.na(sheet[[c("hmdb_id")]][[1+i2]])) {
      sheet[[c("hmdb_id")]][[1+i2]] <- metabolite_search(sheet1[1+i2])
    }
  }

  write.csv(sheet, "OUTPUT.csv")

  x <- sheet[[c("hmdb_id")]]
  x <- length(unique(x))
  #print(paste0(x, " unique metabolites after annotation"))

  #x<- sheet[[6]]
  #y <- 0
  #for (i in 1:length(x)) {
  #  if (x[i] != "NA") {
   #   y = y + 1
  #  }
}
