\name{hmdb_taxonomy}
\alias{hmdb_taxonomy}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
hmdb_taxonomy
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Outputs csv of annotated metabolites
}
\usage{
hmdb_taxonomy(sheetname)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{sheetname}{
%%     ~~Describe \code{sheetname} here~~
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
function (sheetname)
{
    sheet <- read.csv(sheetname, na.string = "NA")
    idlist <- sheet[[c("hmdb_id")]]
    len <- length(idlist)
    hmdb_id <- idlist
    super_class <- NULL
    class <- NULL
    sub_class <- NULL
    direct_parent <- NULL
    j <- 0
    for (j in 1:length(idlist)) {
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
        len <- length(hmdb)
        for (i in 1:len) {
            if (hmdb[[i]][[1]] == idlist[j]) {
                tempsupclass <- hmdb[[i]][[5]]
                tempclass <- hmdb[[i]][[6]]
                tempsubclass <- hmdb[[i]][[7]]
                tempdirectparent <- hmdb[[i]][[8]]
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
        if (is.null(tempdirectparent)) {
            tempdirectparent <- "NA"
        }
        direct_parent <- append(direct_parent, tempdirectparent)
    }
    sheet[c("super_class")] <- super_class
    sheet[c("class")] <- class
    sheet[c("sub_class")] <- sub_class
    sheet[c("direct_parent")] <- direct_parent
    write.csv(sheet, "taxonomy.csv")
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
