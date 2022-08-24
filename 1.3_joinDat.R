# This script is used to join the MB and parnassus data


function_import <- function(path_rds, campus_string) {
  import <- readRDS(path_rds)
  import$campus <- campus_string
  return(import)
}


# Import MB data
hbs_mb_import_ <- function_import("data/output/hbs_MB.rds", "mb")

# Check data to see if there are any NA values and index them out if TRUE
if(any(is.na(hbs_mb_import_)) == TRUE) {
  na.index <- which(is.na(hbs_mb_import_) == TRUE)
  hbs_mb_import <- hbs_mb_import_[-na.index,]
  print("NA Found")
  which(is.na(hbs_mb_import) == TRUE)
} else {
  hbs_mb_import <- hbs_mb_import_
  print("No NA in Mission Bay Data")
}


# Import Parn data
hbs_parn_import_ <- function_import("data/output/hbs_parn.rds", "parn")

# Check data to see if there are any NA values and index them out if TRUE

if(any(is.na(hbs_parn_import_)) == TRUE) {
  na.index <- which(is.na(hbs_parn_import_) == TRUE)
  hbs_parn_import <- hbs_parn_import_[-na.index,]
  print("NA Found")
  which(is.na(hbs_parn_import) == TRUE)
} else {
  hbs_parn_import <- hbs_parn_import_
  print("No NA in Parnassus Data")
}


# Append dat's
hbs_import <- rbind(hbs_mb_import, hbs_parn_import)

# Import data, select VARS, gen 
hbs_dat_import <- hbs_import %>%
  select(PPE, DATE, CODE, HOURS, campus) %>% 
  mutate(PPE = ymd(`PPE`),
         month = month(DATE, label = TRUE),
         year = year(DATE)) 


# Import hbs codes
hbs_codes <- read_excel("/Users/gregoryburns/Library/CloudStorage/Box-Box/UCSF Health/RVU Report/RVU Report/data/pay_codes_DAT.xlsx") 

# Join tables
hbs_dat_join <- left_join(hbs_dat_import, hbs_codes) %>% mutate(CODE = as.factor(CODE))

# Save data as RDS for future analysis
saveRDS(hbs_dat_join, file = "data/output/hbs_join.rds")

# Save CSV to archive
write.csv(hbs_dat_join, file = "/Volumes/burnsgr/data/import/mb/hbs_join.csv", row.names = FALSE)
