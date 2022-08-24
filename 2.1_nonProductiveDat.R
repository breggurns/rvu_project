# Import data
import <- readRDS("data/output/hbs_join.rds")

# Filtered by non-productive HBS codes
non_productive_dat <- import %>% 
  filter(daily_hours_worked != TRUE &
           CODE == "Orientation" |
           CODE == "In House Education" |
           CODE == "Admin Time" |
           CODE == "Staff Meeting") 

# Create productive hours and fte table
# non_productive_table <- non_productive_dat %>%
#   group_by(CODE) %>% 
#   summarise(sum_hours = round(sum(HOURS), 0),
#             sum_fte = round((sum(HOURS)/80), 2)) %>% 
#   arrange(desc(sum_hours))

# Save data as RDS for future analysis
saveRDS(non_productive_dat, file = "data/output/nonProductive.rds")

# Save CSV to archive
write.csv(non_productive_dat, file = "/Volumes/burnsgr/data/import/mb/nonProductive.csv", row.names = FALSE)