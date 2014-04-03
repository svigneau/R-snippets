## Function ##

# Requires

library(reshape)

# Function to reorganize data for barplot plotting, converting values to fractions

barplot_format <- function (data, xlabel, ylabel) {
  summary <- data.frame(xlabel, ylabel, data)
  summary_cast <- cast(summary, ylabel ~ xlabel, value='data')
  summary_mat <- as.matrix(summary_cast[, 2:3])
  dimnames(summary_mat) <- list(unique(xlabel), unique(ylabel))
  summary_prop <- apply(summary_mat, 2, function (x) { x / sum(x) })
  return(summary_prop)
}

## Usage ##

# Data vector
#data <- c(val1, val2, val3, val4)

# Labels for x and y axis
#xlabel <- c(label1, label1, label2, label2)
#ylabel <- c(labela, labelb, labela, labelb)

# Format data
#barplotdata <- barplot_format(data, xlabel, ylabel)

# Plot barplot
#barplot(barplotdata)
