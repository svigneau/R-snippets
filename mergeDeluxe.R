## Function ##

# Function to merge dataframes, appending the original dataframe name to the corresponding columns
mergeDeluxe <- function (tomerge, by, all=T, pos="after", sep="_") {
  # tomerge: list of dataframes
  # by: name of column to use as a join to merge dataframes
  # all: whether to keep non-matching lines, as defined in R base "merge" function
  # pos: if "after", the dataframe name is appended as a suffix; if "before", it is appended as a prefix
  # sep: separator to use when appending dataframe name
  
  # Function to add a label to each element of a vector, except if element is identical to an element of keep
  addVecLabel <- function (vec, label, keep) {
    # vec, keep: character vectors
    # label: character
    addEltLabel <- function (elt) {
      if (sum(sapply(keep, function (x) elt == x))) {
        elt
      } else {
        if (pos == "after") {
          paste(elt, label, sep="_")
        } else if (pos == "before") {
          paste(label, elt, sep=sep)
        }
       
      }
    }
    sapply(vec, addEltLabel)
  }
  
  # Rename columns of each dataframe by appending the dataframe name, except for the join column
  tomerge <- lapply(names(tomerge), function (x) {
    df <- tomerge[[x]]
    vec <- names(df)
    label <- x
    keep <- by
    names(df) <- addVecLabel(vec, label, keep)
    df
    }
  )
  
  # Merge all dataframes by column by
  Reduce(function (x, y) merge(x, y, by=by, all=all), tomerge)
}

## Usage ##

# List of dataframes to merge (here df1 and df2)
#tomerge <- list(label1=df1, label2=df2)

# Join columns for merge
#by <- c("Gene", "Chr", "Start", "End", "Strand")

# Merge
#mergeDeluxe(tomerge, by)