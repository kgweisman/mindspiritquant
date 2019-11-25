# GROUPS OF VARIABLES RELEVANT TO STUDY 4

require(tidyverse)

# d4_byquestion <- read_csv("../data/study4_byquestion.csv") %>% select(-X1)

# porosity -----

# porosity scale

# d4_byquestion %>% select(contains("_por_")) %>% select(-ends_with("_cat"), -contains("total"), -contains("score"), -contains("check")) %>% names() %>% paste(collapse = ", ")

s4_var_por <- c("p7_por_thgs.hrt", 
                # EXCLUDE follow-up questions
                # "p7_por_thgs.hurt_a", "p7_por_thgs.hurt_b", "p7_por_thgs.hurt_c", 
                "p7_por_wifi.thgs", "p7_por_job.wish", "p7_por_angr.cntrl", 
                # EXCLUDE follow-up questions
                # "p7_por_angr.cntrl_a", "p7_por_angr.cntrl_b", "p7_por_angr.cntrl_c", 
                "p7_por_sprt.envy", "p7_por_read.thgs", 
                # EXCLUDE follow-up questions
                # "p7_por_read.thgs_a", "p7_por_read.thgs_b", "p7_por_read.thgs_c", 
                "p7_por_stre.spoil", 
                # EXCLUDE follow-up questions
                # "p7_por_stre.spoil_a", "p7_por_stre.spoil_b", "p7_por_stre.spoil_c", 
                "p7_por_conslt.unseen", "p7_por_mircl.prayer", "p7_por_pry.dead.back", 
                "p7_por_spkn.curse", 
                # EXCLUDE follow-up questions
                # "p7_por_spkn.curse_a", "p7_por_spkn.curse_b", "p7_por_spkn.curse_c", 
                "p7_por_curse.sick", "p7_por_sprt.put.thgs", "p7_por_fall.in.lov", 
                # EXCLUDE follow-up questions
                # "p7_por_fall.in.lov_a", "p7_por_fall.in.lov_b", "p7_por_fall.in.lov_c",
                "p7_por_thgs.heal", "p7_por_visualization")


# porosity vignettes

# d4_byquestion %>% select(contains("_mm_")) %>% select(-ends_with("_cat"), -contains("total"), -contains("score"), -contains("check")) %>% names() %>% paste(collapse = ", ")

s4_var_pv <- c("p7_mm_ang_feel.hurt", "p7_mm_ang_thgs.hurt", "p7_mm_ang_sprt.hurt", 
               # EXCLUDE person making themselves sick/well
               # "p7_mm_ang_physical", 
               "p7_mm_ang_sickness", 
               "p7_mm_car_fel.no.pr", "p7_mm_car_thk.no.pr", "p7_mm_car_sprt.help", 
               # EXCLUDE person making themselves sick/well
               # "p7_mm_car_physical", 
               "p7_mm_car_curing", 
               "p7_mm_env_feel.hurt", "p7_mm_env_thgs.hurt", "p7_mm_env_sprt.hurt", 
               # EXCLUDE person making themselves sick/well
               # "p7_mm_env_physical", 
               "p7_mm_env_sickness", 
               "p7_mm_thnk.feel.hurt", "p7_mm_sprt.thgs.hurt")


# absorption -----

# d4_byquestion %>% select(contains("_abs_")) %>% select(-ends_with("_cat"), -contains("total"), -contains("score"), -contains("check")) %>% names() %>% paste(collapse = ", ")

s4_var_abs <- c("p7_abs_child.exp", "p7_abs_poetic", "p7_abs_tv.real", 
                "p7_abs_see.image", "p7_abs_mind.world", "p7_abs_clouds", 
                "p7_abs_vivid.dreams", "p7_abs_mystic.exp", "p7_abs_step.outside", 
                "p7_abs_textures", "p7_abs_too.real", "p7_abs_music.attn", 
                "p7_abs_heavy.body", "p7_abs_sense.presc", "p7_abs_fire", 
                "p7_abs_nature.art", "p7_abs_colors", "p7_abs_thght.wander", 
                "p7_abs_vivid.past", "p7_abs_makes.sense", "p7_abs_become.chctr", 
                "p7_abs_visual.thghts", "p7_abs_small.things", "p7_abs_music.lift", 
                "p7_abs_noise.music", "p7_abs_scented.mem", "p7_abs_visual.music", 
                "p7_abs_before.said", "p7_abs_physical.mem", "p7_abs_voice.sound", 
                "p7_abs_not.physical", "p7_abs_thgts.image", "p7_abs_odor.to.color", 
                "p7_abs_sunset")


# spiritual experience -----

# daily spiritual experiences

# d4_byquestion %>% select(contains("_dse_")) %>% select(-ends_with("_cat"), -contains("total"), -contains("score"), -contains("check")) %>% names() %>% paste(collapse = ", ")

s4_var_dse <- c("p7_dse_god.prescn", "p7_dse_conect.life", "p7_dse_no.daily.conc", 
                "p7_dse_spi.strength", "p7_dse_spirt.comfort", "p7_dse_inner.peace", 
                "p7_dse_god.help", "p7_dse_guided.daily", "p7_dse_direct.love", 
                "p7_dse_lov.thru.othr", "p7_dse_touch.by.beau", "p7_dse_blessings", 
                "p7_dse_selfless.care", "p7_dse_accept.wrong")


# spiritual events

# d4_byquestion %>% select(contains("_se_")) %>% select(-ends_with("_cat"), -contains("total"), -contains("score"), -contains("check")) %>% names() %>% paste(collapse = ", ")

s4_var_spev <- c("p7_se_voice.out", "p7_se_voice.in", "p7_se_placed.thought", 
                 "p7_se_vision.out", "p7_se_image.in", "p7_se_touch", "p7_se_smell", 
                 "p7_se_taste", "p7_se_dream.sent", "p7_se_stand.beside", 
                 "p7_se_demon.in.room", "p7_se_spnat.presence", "p7_se_shaking.prayer", 
                 "p7_se_emotion.prayer", "p7_se_powrful.prayer", "p7_se_out.body.exp", 
                 "p7_se_body.control", "p7_se_slep.paralysis", "p7_se_god.thru.pain", 
                 "p7_se_god.illness", "p7_se_live.healing", "p7_se_own.healing")
# note: includes sleep paralysis


# secular experience -----

# halluincations

# d4_byquestion %>% select(contains("_unev_")) %>% select(-ends_with("_cat"), -contains("total"), -contains("score"), -contains("check")) %>% names() %>% paste(collapse = ", ")

s4_var_hall <- c("p7_unev_voice.aloud", "p7_unev_phone.ring", "p7_unev_call.name", 
                 "p7_unev_music", "p7_unev_no.ones.vox", "p7_unev_shadows")


# paranormal

# d4_byquestion %>% select(contains("_exsen_")) %>% select(-ends_with("_cat"), -contains("total"), -contains("score"), -contains("check")) %>% names() %>% paste(collapse = ", ")

s4_var_para <- c("p7_exsen_esp.exists", "p7_exsen_esp.exp", "p7_exsen_psychic", 
                 "p7_exsen_view.future", "p7_exsen_dream.true", "p7_exsen_dist.msg", 
                 "p7_exsen_send.msg")


# control scales -----

# sense of control

# d4_byquestion %>% select(contains("_wob_")) %>% select(-ends_with("_cat"), -contains("total"), -contains("score"), -contains("check")) %>% names() %>% paste(collapse = ", ")

s4_var_ctl <- c("p7_wob_set.mind_reverse", "p7_wob_find.ways_reverse", 
                "p7_wob_own.hands_reverse", "p7_wob_future.on.me_reverse", 
                "p7_wob_little.change", "p7_wob_helpless", "p7_wob_others.do", 
                "p7_wob_beynd.control", "p7_wob_interfere", "p7_wob_little.contrl", 
                "p7_wob_cant.solve", "p7_wob_pushed.around")

s4_var_ctl_rev <- c("p7_wob_set.mind_reverse", "p7_wob_find.ways_reverse",
                    "p7_wob_own.hands_reverse", "p7_wob_future.on.me_reverse")


# need for cognition

# d4_byquestion %>% select(contains("_hthk_")) %>% select(-ends_with("_cat"), -contains("total"), -contains("score"), -contains("check")) %>% names() %>% paste(collapse = ", ")

s4_var_cog <- c("p7_hthk_complex", "p7_hthk_responsblt", "p7_hthk_not.fun", 
                "p7_hthk_lil.challeng", "p7_hthk_avoid.think", "p7_hthk_long.hrs", 
                "p7_hthk_hrd.hav.to", "p7_hthk_smal.daily", "p7_hthk_lil.thought", 
                "p7_hthk_way.to.top", "p7_hthk_new.soltions", "p7_hthk_not.exciting", 
                "p7_hthk_puzzles", "p7_hthk_abstract", "p7_hthk_intel.task", 
                "p7_hthk_mental.effrt", "p7_hthk_job.done", "p7_hthk_not.personal")

s4_var_cog_rev <- c("p7_hthk_not.fun", "p7_hthk_lil.challeng", "p7_hthk_avoid.think",
                    "p7_hthk_avoid.think", "p7_hthk_smal.daily", "p7_hthk_lil.thought",
                    "p7_hthk_not.exciting", "p7_hthk_mental.effrt", "p7_hthk_job.done")

