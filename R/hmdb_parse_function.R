#' Input to the function is an .xml file, formatted from the HMDB website.
#' Output is hmdbtaxonomy.rda
#' Function parses a .xml file for certain data and places it in a lists of lists
#' which is stored under the variable hmdb.
#' Variable hmdb[[1]] would include the parsed information of the first metabolite
#' from the xml file.

hmdb_parse <- function(xmlName)
{
  doc = xmlParse(xmlName)
  root = xmlRoot(doc)

  hmdb <- list()
  size <- xmlSize(root)
  #print(size)
  # creates list of lists of metabolite information
  for (j in 1:size) {
    name <- root[[j]][c("name")]
    name <- name[[1]]
    if (xmlSize(name) == 0) {
      namevector <- NULL
    }
    else {
      name <- xmlToList(name)
      namevector <- c(name)
    }

    root1 = root[[j]][c("synonyms")]
    root2 = root1[[1]]
    size = xmlSize(root2)
    if (size > 0) {
      for (i1 in 1:size) {
        namevector[i1+1] <- xmlToList(root2[[i1]])
      }
    }


    idvector <- root[[j]][c("accession")]
    idvector <- idvector[[1]]
    if (xmlSize(idvector) == 0) {
      idvector <- NULL
    }
    else {
      idvector <- xmlToList(idvector)
    }

    lentaxonomy <- root[[j]][[c("taxonomy")]]
    lentaxonomy <- lentaxonomy[[1]]
    if (xmlSize(lentaxonomy) == 0) {
      descriptionvector <- NULL
      kingdomvector <- NULL
      superclassvector <- NULL
      classvector <- NULL
      subclassvector <- NULL
      directparentvector <- NULL
      substituentvector <- NULL
      alternativeparentvector <- NULL
      molecularframeworkvector <- NULL
    }
    else{
      descriptionroot = root[[1]][c("taxonomy")]
      descriptionroot = descriptionroot[[1]]
      descriptionroot = descriptionroot[[c("description")]]
      if (xmlSize(descriptionroot) == 0) {
        descriptionvector <- NULL
      }
      else {
        descriptionvector = xmlToList(descriptionroot)
      }

      kingdomroot = root[[j]][c("taxonomy")]
      kingdomroot = kingdomroot[[1]]
      kingdomroot = kingdomroot[[c("kingdom")]]
      if (xmlSize(kingdomroot) == 0) {
        kingdomvector <- NULL
      }
      else {
        kingdomvector = xmlToList(kingdomroot)
      }

      superclass = root[[j]][c("taxonomy")]
      superclass = superclass[[1]]
      superclass = superclass[[c("super_class")]]
      if (xmlSize(superclass) == 0) {
        superclassvector <- NULL
      }
      else {
        superclassvector <- xmlToList(superclass)
      }

      classroot = root[[j]][c("taxonomy")]
      classroot = classroot[[1]]
      classroot = classroot[[c("class")]]
      if (xmlSize(classroot) == 0) {
        classvector <- NULL
      }
      else {
        classvector = xmlToList(classroot)
      }

      subclassroot = root[[j]][c("taxonomy")]
      subclassroot = subclassroot[[1]]
      subclassroot = subclassroot[[c("sub_class")]]
      if (xmlSize(subclassroot) == 0) {
        subclassvector <- NULL
      }
      else {
        subclassvector = xmlToList(subclassroot)
      }

      directparentroot = root[[j]][c("taxonomy")]
      directparentroot = directparentroot[[1]]
      directparentroot = directparentroot[[c("direct_parent")]]
      if (xmlSize(directparentroot) == 0) {
        directparentvector <- NULL
      }
      else {
        directparentvector = xmlToList(directparentroot)
      }

      substituentroot = root[[j]]["taxonomy"]
      substituentroot = substituentroot[[1]]
      substituentroot = substituentroot[[c("substituents")]] #9 is the substituent node under taxonomy [c("substituent")] was giving issues

      substituentSize = xmlSize(substituentroot)
      substituentvector <- "name"
      if (substituentSize > 0) {
        for (i1 in 1:substituentSize) {
          substituentvector[i1] <- xmlToList(substituentroot[[i1]])
        }
      }
      else {
        substituentvector <- NULL
      }

      alternativeparentroot = root[[j]]["taxonomy"]
      alternativeparentroot = alternativeparentroot[[1]]
      alternativeparentroot = alternativeparentroot[[c("alternative_parents")]]

      alternativeparentSize = xmlSize(alternativeparentroot)
      alternativeparentvector <- "name"
      if (alternativeparentSize > 0) {
        for (i1 in 1:alternativeparentSize) {
          alternativeparentvector[i1] <- xmlToList(alternativeparentroot[[i1]])
        }
      }
      else {
        alternativeparentvector <- NULL
      }
      molecularframeworkroot = root[[j]][c("taxonomy")]
      molecularframeworkroot  = molecularframeworkroot[[1]]
      molecularframeworkroot  = molecularframeworkroot[[c("molecular_framework")]]
      if (xmlSize(molecularframeworkroot) == 0) {
        molecularframeworkvector <- NULL
      }
      else {
        molecularframeworkvector = xmlToList(molecularframeworkroot)
      }

      externaldescriptorroot = root[[j]][c("taxonomy")]
      externaldescriptorroot =  externaldescriptorroot[[1]]
      externaldescriptorroot =  externaldescriptorroot[[c("external_descriptors")]]

      externaldescriptorSize = xmlSize(externaldescriptorroot)
      externaldescriptorvector <- "name"
      if (externaldescriptorSize > 0) {
        for (i1 in 1:externaldescriptorSize) {
          externaldescriptorvector[i1] <- xmlToList(externaldescriptorroot[[i1]])
        }
      }
      else {
        externaldescriptorvector <- NULL
      }
    }
    arr = list(hmdb_id =idvector, names = namevector, description = descriptionvector, kingdom = kingdomvector, super_class = superclassvector, class = classvector, sub_class = subclassvector, direct_parent = directparentvector, alternative_parent = alternativeparentvector, substituents = substituentvector, molecular_framework = molecularframeworkvector)
    hmdb[[j]] = arr
  }
  save(hmdb, file="hmdbtaxonomy.rda")
}
