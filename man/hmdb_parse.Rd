\name{hmdb_parse}
\alias{hmdb_parse}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
hmdb_parse
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
parses HMDB xml file
}
\usage{
hmdb_parse(xmlName)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{xmlName}{
%%     ~~Describe \code{xmlName} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
N/A
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
N/A
}
\references{
%% ~put references to the literature/web site here ~
N/A
}
\author{
%%  ~~who you are~~
Emmanuel Elias
}
\note{
%%  ~~further notes~~
N/A
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
N/A
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (xmlName)
{
    doc = xmlParse(xmlName)
    root = xmlRoot(doc)
    hmdb <- list()
    size <- xmlSize(root)
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
                namevector[i1 + 1] <- xmlToList(root2[[i1]])
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
        else {
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
            substituentroot = substituentroot[[c("substituents")]]
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
            molecularframeworkroot = molecularframeworkroot[[1]]
            molecularframeworkroot = molecularframeworkroot[[c("molecular_framework")]]
            if (xmlSize(molecularframeworkroot) == 0) {
                molecularframeworkvector <- NULL
            }
            else {
                molecularframeworkvector = xmlToList(molecularframeworkroot)
            }
            externaldescriptorroot = root[[j]][c("taxonomy")]
            externaldescriptorroot = externaldescriptorroot[[1]]
            externaldescriptorroot = externaldescriptorroot[[c("external_descriptors")]]
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
        arr = list(hmdb_id = idvector, names = namevector, description = descriptionvector,
            kingdom = kingdomvector, super_class = superclassvector,
            class = classvector, sub_class = subclassvector,
            direct_parent = directparentvector, alternative_parent = alternativeparentvector,
            substituents = substituentvector, molecular_framework = molecularframeworkvector)
        hmdb[[j]] = arr
    }
    save(hmdb, file = "hmdbtaxonomy.rda")
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
