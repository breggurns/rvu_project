# Import data
import <- readRDS("data/output/hbs_join.rds")

#Check paycodes in data
import %>%
  filter(daily_hours_worked == TRUE) %>%
  distinct(CODE)

# Create new factor levels for table for Mission Bay analysis filtered by month/year
productive_import <- import %>% 
                    filter(daily_hours_worked == TRUE) %>% 
                    mutate(productive_hour_type = fct_collapse(CODE,
                             normal_hours = c("Normal Hours Work", 
                                              "In Charge/Lead",
                                              "Skipped Lunch",
                                              "Holiday Premium"),
                             consecutive_shift = c("Consecutive Day Premium"),
                             other_level = "OT - all"),
                           fte = HOURS * 0.0125) # 80 hours per fte, 1 hour is 0.0125 FTE


# Group productive import dat with group.function
productive_dat <- group.fun(productive_import)

# productive_table <- productive_dat %>%
#   group_by(productive_hour_type) %>%
#   summarise(sum_hours = round(sum(HOURS), 0),
#             sum_fte = round((sum(HOURS)/80), 0)) %>%
#   arrange(desc(sum_hours))

# Save data as RDS for future analysis
saveRDS(productive_dat, file = "data/output/productive.rds")

# Save CSV to archive
write.csv(productive_dat, file = "/Volumes/burnsgr/data/import/mb/productive.csv", row.names = FALSE)