
# Functions ---------------------------------------------------------------

# Function to group import data 
group.fun <- function(dat) {
                dat %>% 
                  group_by(campus, month, year, DATE, productive_hour_type) %>% 
                  summarise(sum_hours = round(sum(HOURS), 0),
                            sum_fte = round(sum(fte), 2))
}
