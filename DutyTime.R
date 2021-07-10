# Replace sample1 with your file name or sample name
# Usage: Rscript DutyTime.R duty_time_<FlowCellID>.csv ouputprefix

main <- function() {
  args <- commandArgs(trailingOnly = TRUE)
  df <- args[1]
  output <- args[2]
  suppressPackageStartupMessages({
    library(dplyr, warn.conflicts = FALSE)
    library(tidyr)
    library(ggplot2)
    library(magrittr)
    
    })

  options(dplyr.summarise.inform = FALSE)
  
  # Read in the data from duty_time_<FlowCellID>.csv saved after sequencing run has finished
  df <- read.csv(df, header = TRUE)
  
  message("Imported duty time file...one moment please")
  
  message("Generating duty time plot")
  
  # Generate geom_bar for the dwell time for each pore status as sequencing run progresses 
  pdf(paste0(output, "_duty_time_plot.pdf"), width=6, height=6)
  plot <- ggplot(df, aes(x = df$Experiment.Time..minutes., y = df$State.Time..samples., fill = Channel.State)) +
  geom_bar(position = "fill" , stat = "identity") +
  xlab("Time (mins)") +
  ylab("State Time Equivalence (fraction)") +
  ggtitle("Duty Time") +
  labs(fill="Pore Status") +
  geom_hline(yintercept = 0.8, linetype="longdash")
  print(plot)
  dev.off()

}

suppressWarnings(
  main())