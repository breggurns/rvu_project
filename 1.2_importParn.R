# Parnassus 
# This script is used when adding new data to the HBS dataframe. Original data
# ranges from 7/10/21

# List file names in MB directory
fileNames <- list.files("/Volumes/burnsgr/data/import/mb", ".csv", recursive = TRUE, full.names = TRUE)

# Create blank dataframe
df <- data.frame()

# # Set WD to AM directory

# Loop through set WD
for (fileName in fileNames) {
  #read data:
  import <- read.csv(fileName)
  #append df with each looped output
  df <- rbind(df, import)
}

# Filter for unique records
df_unique <- df %>% distinct()

# Set variable types
hbs_dat <- df_unique %>% 
  mutate(PPE = mdy(PPE),
         DATE = mdy(DATE),
         CODE = as.factor(CODE))

# Save data as RDS for future analysis
saveRDS(hbs_dat, file = "data/output/hbs_parn.rds")

# Save CSV to archive
write.csv(hbs_dat, file = "/Volumes/burnsgr/data/import/mb/hbs_PARN.csv", row.names = FALSE)



