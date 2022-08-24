# Mission Bay
# This script is used when adding new data to the HBS dataframe. HBS export data
# should be placed in the data/mb folder located on the server. This data
# ranges from 7/10/21

# List file names in MB directory
fileNames <- list.files("/Volumes/burnsgr/data/import/mb", ".csv", recursive = TRUE, full.names = TRUE)

# Create blank dataframe
df <- data.frame()

# # Set WD to AM directory

# Loop through set WD
for (fileName in fileNames) {
  # read data:
  import <- read.csv(fileName)
  # import_dat <- import %>% mutate(PPE = mdy(PPE), DATE = mdy(DATE))
  # append df with each looped output
  df <- rbind(df, import)
}

# Filter for unique records
df_unique <- df %>% distinct()

# Set variable types
hbs_dat <- df_unique %>% 
  mutate(PPE = ymd(PPE),
        DATE = ymd(DATE),
         CODE = as.factor(CODE))

# Save data as RDS for future analysis
saveRDS(hbs_dat, file = "data/output/hbs_MB.rds")

# Save CSV to archive
write.csv(hbs_dat, file = "/Volumes/burnsgr/data/import/mb/hbs_MB.csv", row.names = FALSE)



