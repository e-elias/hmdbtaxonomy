# hmdbtaxonomy
hmdbtaxonomy is a package used to parse HMDB .xml files, match metabolite names to their HMDB ID, and provide chemical taxonomies from HMDB IDs by writing to .csv files.

To install the package, type this in R command line:
install.packages("devtools")
devtools::install_github("e-elias/hmdbtaxonomy")

Current issue and fix: Package depends on library XML and the current package is not automatically adding the dependency. Simply type library(XML) in R console to fix.
