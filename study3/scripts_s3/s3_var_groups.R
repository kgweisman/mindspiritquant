# GROUPS OF VARIABLES RELEVANT TO STUDY 3

require(tidyverse)

# porosity
s3_var_por <- c("epi_1_01", "epi_1_02", "epi_1_03", "epi_1_04", "epi_1_05", 
                "epi_1_06", "epi_1_07", "epi_1_08", "epi_1_09", "epi_1_10", 
                "epi_1_11", "epi_1_12", "epi_1_13", "epi_1_14", "epi_1_15", 
                "epi_1_16")

# spiritual events
s3_var_spex <- c("epi_2_02", "epi_2_03", "epi_2_04", "epi_2_05",
                 "epi_2_06", "epi_2_07", "epi_2_08", "epi_2_09", "epi_2_10",
                 "epi_2_16", "epi_2_17", "epi_2_18", "epi_2_19", "epi_2_20", 
                 "epi_2_21")

s3_var_being_us <- c("epi_2_usa11", "epi_2_usa12", "epi_2_usa13", 
                     "epi_2_usa14", "epi_2_usa15") 
s3_var_being_gh <- c("epi_2_gha11", "epi_2_gha12", "epi_2_gha13", 
                     "epi_2_gha14", "epi_2_gha15") 
s3_var_being_th <- c("epi_2_thl11", "epi_2_thl12a", "epi_2_thl12b", 
                     "epi_2_thl12c", "epi_2_thl12d", "epi_2_thl12e", 
                     "epi_2_thl12f", "epi_2_thl12g", "epi_2_thl12h", 
                     "epi_2_thl12i", "epi_2_thl12j", "epi_2_thl12k")
s3_var_being_ch <- c("epi_2_chn11", "epi_2_chn12", "epi_2_chn13", 
                     "epi_2_chn14", "epi_2_chn15")
s3_var_being_vt <- c("epi_2_vut11", "epi_2_vut12", "epi_2_vut13", 
                     "epi_2_vut14", "epi_2_vut15")

s3_var_being <- c(s3_var_being_us, s3_var_being_gh, s3_var_being_th, 
                  s3_var_being_ch, s3_var_being_vt)

s3_var_spirit <- c(s3_var_spex, s3_var_being)

# other extraordinary events
s3_var_other <- c("epi_2_22", "epi_2_23")

