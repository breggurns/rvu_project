# Import data
import <- readRDS("data/output/hbs_join.rds")

# Check paycodes in data
import %>%
  filter(unplanned_absense == TRUE) %>%
  distinct(CODE)

# Create new factor levels for table for Mission Bay analysis filtered by month/year
unplanned_absence_dat <- import %>% 
  filter(unplanned_absense == TRUE) %>% 
  mutate(absence_type = fct_collapse(CODE,
                                     sick_personal = c("Sick Personal", 
                                                       "Sick - Bereavement Leave",
                                                       "Sick - Med Appt",
                                                       "Sick - FMLA/PDLL",
                                                       "Overused Sick Leave",
                                                       "PTO - Sick",
                                                       "PTO - Sick Family Member",
                                                       "Vacation - Used for Sick",
                                                       "Sick - KinCare",
                                                       "Sick - Family Member"),    
                                     self_cancel = c("Self Cancel Shift"),
                                     other_level = "Other Unplanned"))

unplanned_absence_dat %>% 
  filter(absence_type == "Other Unplanned") %>% 
  distinct(CODE)

# # Create productive hours and fte table
# unplanned_absence_table <- unplanned_absence_dat %>%
#   group_by(absence_type) %>% 
#   summarise(sum_hours = round(sum(HOURS), 0),
#             sum_fte = round((sum(HOURS)/80), 0)) %>% 
#   arrange(desc(sum_hours))

# Save data as RDS for future analysis
saveRDS(unplanned_absence_dat, file = "data/output/unPlanned.rds")

# Save CSV to archive
write.csv(unplanned_absence_dat, file = "/Volumes/burnsgr/data/import/mb/unPlanned.csv", row.names = FALSE)
