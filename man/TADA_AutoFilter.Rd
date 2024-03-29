% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RequiredCols.R
\name{TADA_AutoFilter}
\alias{TADA_AutoFilter}
\title{AutoFilter}
\usage{
TADA_AutoFilter(.data)
}
\arguments{
\item{.data}{TADA dataframe OR TADA sites dataframe}
}
\value{
.data with rows removed where result values are not quantitative (NA or text),
or the results have other issues that are not dealt with elsewhere.
}
\description{
This function removes rows where the result value is not numeric to
prepare a dataframe for quantitative analyses. Ideally, this function should
be run after other data cleaning, QA/QC, and harmonization steps are
completed using other TADA package functions, or manually. Specifically, .
this function removes rows with "Text" and "NA - Not Available"
in the TADA.ResultMeasureValueDataTypes.Flag column, or NA in the
TADA.ResultMeasureValue column.
}
\details{
This function also removes any columns not required for TADA workflow where
all values are equal to NA.It also provides a warning message identifying
any TADA required columns containing only NA values.
}
\examples{
# Load example dataset:
data(Data_Nutrients_UT)

# Remove all:
TADA_filtered <- TADA_AutoFilter(Data_Nutrients_UT)

}
