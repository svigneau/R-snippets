## Function ##

# Function to merge dataframes, appending the original dataframe name to the corresponding columns
mergeDeluxe <- function (tomerge, join) {
  # tomerge: list of dataframes
  # join: name of column to use as a join to merge dataframes
  
  # Function to add suffix to each element of a vector, except if element is identical to an element of keep
  addVecSuffix <- function (vec, suffix, keep) {
    # vec, keep: character vectors
    # suffix: character
    addEltSuffix <- function (elt) {
      if (sum(sapply(keep, function (x) elt == x))) {
        elt
      } else {
        paste(elt, suffix, sep="_")
      }
    }
    sapply(vec, addEltSuffix)
  }
  
  # Rename columns of each dataframe by appending the dataframe name, except for the join column
  tomerge <- lapply(names(tomerge), function (x) {
    df <- tomerge[[x]]
    vec <- names(df)
    suffix <- x
    keep <- join
    names(df) <- addVecSuffix(vec, suffix, keep)
    df
    }
  )
  
  # Merge all dataframes by column join
  Reduce(function (x, y) merge(x, y, by=join), tomerge)
}

## Usage ##

# List of dataframes to merge (here df1 and df2)
#tomerge <- list(suffix1=df1, suffix2=df2)

# Join columns for merge
#join <- c("Gene", "Chr", "Start", "End", "Strand")

# Merge
#mergeDeluxe(tomerge, join)
