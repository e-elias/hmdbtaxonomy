#' This function extracts the chemical taxonomy of a metabolite
#' HMDB ID should be on column 6
#' taxonomy will be outputted on column 11-14set
#'

hmdb_taxonomy <- function(sheetname)
{
  sheet <- read.csv(sheetname, na.string = "NA")

  idlist <- sheet[[6]]
  len <- length(idlist)


  hmdb_id <- idlist
  super_class <- NULL
  class <- NULL
  sub_class <- NULL
  direct_parent <- NULL

  #super_class <- append(super_class, "TITLE")

  j <- 0
  for (j in 1:length(idlist))
  {
    #print(j)

    tempsupclass <- "NA"
    tempclass <- "NA"
    tempsubclass <- "NA"
    tempdirectparent <- "NA"
    if (is.na(idlist[j])) {
      super_class <- append(super_class, tempsupclass)

      class <- append(class, tempclass)

      sub_class <- append(sub_class, tempsubclass)

      direct_parent <- append(direct_parent, tempdirectparent)

      next
    }
    for (i in 1:217920)
    {
      if (hmdb[[i]][[1]] == idlist[j])
      {
        tempsupclass <- hmdb[[i]][[5]]
        #super_class <- append(super_class, tempsupclass)

        tempclass <- hmdb[[i]][[6]]
        #class <- append(class, tempclass)

        tempsubclass <- hmdb[[i]][[7]]
        #sub_class <- append(sub_class, tempsubclass)

        tempdirectparent <- hmdb[[i]][[8]]
        #direct_parent <- append(direct_parent, tempdirectparent)

        break
      }
    }
    if (is.null(tempsupclass)) {
      tempsupclass <- "NA"
    }
    super_class <- append(super_class, tempsupclass)
    if (is.null(tempclass)) {
      tempclass <- "NA"
    }
    class <- append(class, tempclass)
    if (is.null(tempsubclass)) {
      tempsubclass <- "NA"
    }
    sub_class <- append(sub_class, tempsubclass)
    if (is.null (tempdirectparent)) {
      tempdirectparent <- "NA"
    }
    direct_parent <- append(direct_parent, tempdirectparent)

  }


  sheet[11] <- super_class
  sheet[12] <- class
  sheet[13] <- sub_class
  sheet[14] <- direct_parent


  #df <- data.frame(hmdb_id, super_class, class, sub_class, direct_parent)
  write.csv(sheet, "taxonomy.csv")
}
