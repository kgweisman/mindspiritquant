# LOADING DATASETS FOR ALL STUDIES

# study 1 -----
d1 <- read_csv("../../study1/data/study1.csv") %>%
  mutate(country = factor(country, levels = levels_country),
         site = factor(site, levels = levels_site),
         religion = factor(religion, levels = levels_religion),
         researcher = factor(researcher, levels = levels_researcher))

contrasts(d1$country) <- contrasts_country
contrasts(d1$site) <- contrasts_site; contrasts(d1$site)
contrasts(d1$religion) <- contrasts_religion; contrasts(d1$religion)

d1_byquestion <- read_csv("../../study1/data/study1_byquestion.csv") %>%
  mutate(country = factor(country, levels = levels_country),
         site = factor(site, levels = levels_site),
         religion = factor(religion, levels = levels_religion),
         researcher = factor(researcher, levels = levels_researcher),
         study = "study 1")

contrasts(d1_byquestion$country) <- contrasts_country
contrasts(d1_byquestion$site) <- contrasts_site
contrasts(d1_byquestion$religion) <- contrasts_religion


# study 2 -----
d2_byquestion <- read_csv("../../study2/data/packets123/packets123_data_byquestion_wide.csv") %>%
  filter(packet == 1) %>%
  rename(country = ctry) %>%
  mutate(country = factor(country, levels = tolower(levels_country),
                          labels = levels_country))

contrasts(d2_byquestion$country) <- contrasts_country

# d2 <- read_csv("../../study2/data/packets123/packets123_data_bysubscale_wide.csv") %>%
#   filter(packet == 1) %>%
#   rename(country = ctry,
#          abs_score = exwl,
#          dse_score = dse_01to14,
#          spev_score = spev)

d2 <- d2_byquestion %>% 
  select(country, subj, s2_var_abs, s2_var_dse, s2_var_spev) %>%
  gather(question, response, -c(country, subj)) %>%
  mutate(scale = case_when(grepl("dse_", question) ~ "dse_score",
                           grepl("spev", question) ~ "spev_score",
                           grepl("exwl", question) ~ "abs_score")) %>%
  # mutate(scale = paste0(gsub("_.*$", "", question), "_score")) %>%
  group_by(country, subj, scale) %>%
  summarise(score = mean(response, na.rm = T)) %>%
  # summarise(score = sum(response, na.rm = T)) %>%
  # filter(!is.na(response)) %>%
  # summarise(score = n()) %>%
  ungroup() %>%
  spread(scale, score)

d2 <- d2 %>%
  mutate(study = "study 2") %>%
  group_by(study) %>%
  mutate(abs_score_std = scale(abs_score),
         dse_score_std = scale(dse_score),
         spev_score_std = scale(spev_score)) %>%
  ungroup() %>%
  group_by(country) %>%
  mutate(abs_score_std2 = scale(abs_score),
         dse_score_std2 = scale(dse_score),
         spev_score_std2 = scale(spev_score)) %>%
  ungroup() %>%
  mutate(country = factor(country, levels = levels_country))
  # mutate(country = factor(country, levels = tolower(levels_country),
  #                         labels = levels_country))

contrasts(d2$country) <- contrasts_country

# study 3 -----
source("../../study3/scripts_s3/s3_var_groups.R")

d3a <- read_csv("../../study3/data/d_demo.csv") %>% 
  select(-X1) %>%
  # correct duplicate entry by hand
  filter(!(epi_subj == "50807" & is.na(epi_charc))) %>%
  distinct() %>%
  full_join(read_csv("../../study3/data/d_por_scored.csv") %>% 
              select(-X1) %>%
              rename(por_score = score)) %>%
  full_join(read_csv("../../study3/data/d_spex_base_q2to23_scored_propall.csv") %>% 
              select(-X1) %>%
              rename(spirit_score = score)) %>%
  mutate(study = "study 3") %>%
  group_by(study) %>%
  mutate_at(vars(por_score, spirit_score), funs(std = scale(.))) %>%
  ungroup() %>%
  group_by(epi_ctry) %>%
  mutate_at(vars(por_score, spirit_score), funs(std2 = scale(.))) %>%
  ungroup() %>%
  mutate(epi_ctry = factor(epi_ctry, levels = levels_country),
         epi_sample = factor(epi_charc, 
                             levels = c(0, 1), 
                             labels = c("general population", "charismatic")))

d3_byquestion <- full_join(read_csv("../../study3/data/d_por.csv") %>% 
                             select(-X1),
                           read_csv("../../study3/data/d_spex_base_q2to23.csv") %>% 
                             select(-X1)) %>%
  mutate(study = "study 3") %>%
  filter(question %in% c(s3_var_por, s3_var_spex, s3_var_being, s3_var_other)) %>%
  select(epi_ctry, epi_subj, question, response) %>%
  distinct() %>%
  spread(question, response) %>%
  full_join(d3a %>% distinct(epi_ctry, epi_sample, epi_subj)) %>%
  mutate(epi_ctry = factor(epi_ctry, levels = levels_country),
         epi_sample = factor(epi_sample, levels = c("general population", "charismatic")))

contrasts(d3_byquestion$epi_ctry) <- contrasts_country
contrasts(d3_byquestion$epi_sample) <- cbind("_ch" = c(-1, 1))

d3 <- bind_rows(d3_byquestion %>%
                  filter(epi_ctry == "US") %>%
                  select(epi_subj, s3_var_spex, s3_var_being_us) %>%
                  gather(question, response, -epi_subj) %>%
                  mutate(scale = "spirit_score"),
                d3_byquestion %>%
                  filter(epi_ctry == "Ghana") %>%
                  select(epi_subj, s3_var_spex, s3_var_being_gh) %>%
                  gather(question, response, -epi_subj) %>%
                  mutate(scale = "spirit_score"),
                d3_byquestion %>%
                  filter(epi_ctry == "Thailand") %>%
                  select(epi_subj, s3_var_spex, s3_var_being_th) %>%
                  gather(question, response, -epi_subj) %>%
                  mutate(scale = "spirit_score"),
                d3_byquestion %>%
                  filter(epi_ctry == "China") %>%
                  select(epi_subj, s3_var_spex, s3_var_being_ch) %>%
                  gather(question, response, -epi_subj) %>%
                  mutate(scale = "spirit_score"),
                d3_byquestion %>%
                  filter(epi_ctry == "Vanuatu") %>%
                  select(epi_subj, s3_var_spex, s3_var_being_vt) %>%
                  gather(question, response, -epi_subj) %>%
                  mutate(scale = "spirit_score"),
                d3_byquestion %>%
                  select(epi_subj, s3_var_por, s3_var_other) %>%
                  gather(question, response, -epi_subj) %>%
                  mutate(scale = case_when(
                    question %in% s3_var_por ~ "por_score",
                    question %in% s3_var_other ~ "other_score"))) %>%
  full_join(d3a %>% distinct(epi_ctry, epi_sample, epi_subj)) %>%
  mutate(scale = factor(scale,
                        levels = c("por_score", "spirit_score",
                                   "other_score")),
         study = "study 3") %>%
  group_by(study, scale, epi_ctry, epi_sample, epi_subj) %>%
  summarise(score = mean(response, na.rm = T)) %>%
  ungroup() %>%
  spread(scale, score) %>%
  group_by(study) %>%
  mutate_at(vars(ends_with("_score")), funs(std = scale(.))) %>%
  ungroup() %>%
  group_by(study, epi_ctry) %>%
  mutate_at(vars(ends_with("_score")), funs(std2 = scale(.))) %>%
  ungroup()

contrasts(d3$epi_ctry) <- contrasts_country
contrasts(d3$epi_sample) <- cbind("_ch" = c(-1, 1))

rm(d3a)


# study 4 -----

d4_byquestion_raw <- read_csv("../../study4/data/study4_byquestion.csv") %>%
  select(-X1) %>%
  mutate(p7_ctry = factor(p7_ctry, levels = levels_country))

d4_byquestion <- full_join(d4_byquestion_raw %>%
                             select(p7_ctry, p7_subj, s4_var_pv) %>%
                             gather(question, response, s4_var_pv) %>%
                             mutate(scale = "pv_score"),
                           d4_byquestion_raw %>%
                             select(p7_ctry, p7_subj, s4_var_por) %>%
                             gather(question, response, s4_var_por) %>%
                             mutate(scale = "por_score")) %>%
  full_join(d4_byquestion_raw %>%
              select(p7_ctry, p7_subj, s4_var_abs) %>%
              gather(question, response, s4_var_abs) %>%
              mutate(scale = "abs_score")) %>%
  full_join(d4_byquestion_raw %>%
              select(p7_ctry, p7_subj, s4_var_dse) %>%
              gather(question, response, s4_var_dse) %>%
              mutate(scale = "dse_score")) %>%
  full_join(d4_byquestion_raw %>%
              select(p7_ctry, p7_subj, s4_var_spev) %>%
              gather(question, response, s4_var_spev) %>%
              mutate(scale = "spev_score")) %>%
  full_join(d4_byquestion_raw %>%
              select(p7_ctry, p7_subj, s4_var_hall) %>%
              gather(question, response, s4_var_hall) %>%
              mutate(scale = "hall_score")) %>%
  full_join(d4_byquestion_raw %>%
              select(p7_ctry, p7_subj, s4_var_para) %>%
              gather(question, response, s4_var_para) %>%
              mutate(scale = "para_score")) %>%
  full_join(d4_byquestion_raw %>%
              select(p7_ctry, p7_subj, s4_var_cog) %>%
              gather(question, response, s4_var_cog) %>%
              mutate(scale = "cog_score")) %>%
  full_join(d4_byquestion_raw %>%
              select(p7_ctry, p7_subj, s4_var_ctl) %>%
              gather(question, response, s4_var_ctl) %>%
              mutate(scale = "ctl_score")) %>%
  mutate(p7_ctry = factor(p7_ctry, levels = levels_country))

d4_0 <- d4_byquestion %>%
  group_by(p7_subj, scale) %>%
  mutate(score = mean(response, na.rm = T)) %>%
  ungroup() %>%
  mutate(study = "study 4") %>%
  distinct(study, p7_ctry, p7_subj, scale, score) %>%
  spread(scale, score)

d4_std <- d4_0 %>%
  group_by(study) %>%
  mutate_at(vars(ends_with("_score")), funs(std = scale)) %>%
  ungroup()

d4_std2 <- d4_0 %>%
  group_by(study, p7_ctry) %>%
  mutate_at(vars(ends_with("_score")), funs(std2 = scale)) %>%
  ungroup()

d4 <- d4_0 %>% full_join(d4_std) %>% full_join(d4_std2) %>%
  mutate(p7_ctry = factor(p7_ctry, levels = levels_country))

rm(d4_byquestion_raw, d4_0, d4_std, d4_std2)

contrasts(d4_byquestion$p7_ctry) <- contrasts_country
contrasts(d4$p7_ctry) <- contrasts_country


