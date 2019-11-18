# GROUPS OF VARIABLES RELEVANT TO STUDY 1

require(tidyverse)

# demographics
s1_var_demo <- c("date", "researcher", "country", "site", "religion", 
                 "subject_id", "subject_gender", "subject_age", "subject_job", 
                 "subject_schedule", "subject_livedhere", "subject_lang", 
                 "subject_marital", "subject_hs", "subject_liveswith", 
                 "servicesperweek", "specialrole")

# porosity
s1_var_porvig <- c("hurtwfeelings_anger", "hurtwthoughts_anger", 
                   "healtheffectbyproxy_anger", "hurtviaspirit_anger", 
                   "helpwthoughts_caring", "helpviaspirit_caring", 
                   "healtheffectbyproxy_caring", "hurtwfeelings_envy", 
                   "hurtwthoughts_envy", "hurtviaspirit_envy")

s1_var_pordir <- c("thoughtsharmppldirectly", "spiritsusethoughtsharm")

s1_var_por <- c(s1_var_porvig, s1_var_pordir)

# absorption
s1_var_abs <- c("childexp_abs", "forgetsurrounding_abs", "poeticlanguage_abs", 
                "starepicture_abs", "mindenvelopworld_abs", "cloudshapes_abs", 
                "vividdaydream_abs", "mysticalexp_abs", "stepoutsidemyself_abs", 
                "textures_abs", "doublyreal_abs", "caughtupinmusic_abs", 
                "heavybody_abs", "sensepresence_abs", "woodfireimagine_abs", 
                "immersednature_abs", "colormeaning_abs", "wanderthoughtstask_abs", 
                "clearpastexp_abs", "meaninglesstoothers_abs", "actinginplay_abs", 
                "visualthoughts_abs", "delightsmallthings_abs", "organmusic_abs", 
                "changenoise_abs", "vividsmellmemories_abs", "synesthesiasound_abs", 
                "predictwords_abs", "physicalmemories_abs", "fascinatingvoice_abs", 
                "invisiblepresence_abs", "sponthoughtsimages_abs", 
                "synesthesiasmell_abs", "emosunset_abs")
# don't forget about abs_score!

# spiritual experience
s1_var_spirit <- c("godviapeople", "godviascript", "godviamind", "godvoxaloud", 
                   "godcommpics", "godviavisions", "godviadreams", 
                   "godguideviaknowing", "godguideviasensations", 
                   "godviabodyexperiences", "godsenseplaceinbody",  
                   "godviatouch", "godviasmell", 
                   # "godexpviaawe", # omitted because of translation issues
                   "neartangiblegod", "presencenotgod", "presencedemon", 
                   "beingentbody", "seehearnotgod", "whitelight", 
                   "trmblshakespirtpwr", "rushofspiritpwr", "intenseemospiritpwr", 
                   "timeslowpray", "mindspiritexitbody", "humanshapeshift",
                   "spiritbeingencounter")

# other extraordinary experiences
s1_var_other <- c("sleepparalysis", "voxwhenalone", "seethingscornereye")

# scid
s1_var_scid <- c("specialmessagenotgod_scid", "threatening_scid", 
                 "importantperson_scid", "hypochondriasis_scid", 
                 "somaticshift_scid", "terribleact_scid", "alienthought_scid")
# omitted 'specialmessage_scid' (replacded with 'not-god' version)
# omitted 'hearthingsfreq_scid' and 'hearthingscontent_scid' (follow-ups)


# recoded dataset
s1r_var_spirit <- s1_var_spirit %>%
  gsub("godviavisions", "godviavision", .) %>%
  gsub("godguideviaknowing", "godgvk0wing", .) %>%
  gsub("godguideviasensations", "godgvsensation", .) %>%
  gsub("godviabodyexperiences", "godviabodyexp", .) %>%
  gsub("presencenotgod", "presence0tgod", .) %>%
  gsub("seehearnotgod", "seehear0tgod", .) %>%
  gsub("trmblshakespirtpwr", "trmblshksprtpwr", .) %>%
  gsub("rushofspiritpwr", "rushofsprtpwr", .) %>%
  gsub("intenseemospiritpwr", "intensemosprtpwr", .) %>%
  gsub("mindspiritexitbody", "mindsprtextbody", .)

s1r_var_other <- s1_var_other %>%
  gsub("voxwhenalone", "voxwhe.lone", .) %>%
  gsub("seethingscornereye", "seethngcoeye", .)
