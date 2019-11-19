# function for writing regression table (fixed effects)

regtab_fun <- function(reg,
                       por_var = "por_score_std",
                       por_name = "Porosity",
                       abs_var = "abs_score_std",
                       abs_name = "Absorption",
                       country_var1 = "country_gh",
                       country_name1 = "Country (Gh.)",
                       country_var2 = "country_th",
                       country_name2 = "Country (Th.)",
                       country_var3 = "country_ch",
                       country_name3 = "Country (Ch.)",
                       country_var4 = "country_vt",
                       country_name4 = "Country (Vt.)",
                       religion_var = "religion_char",
                       religion_name = "Religion (Ch.)",
                       site_var = "site_rural",
                       site_name = "Site (rural)",
                       scale_var = "spirit_scale_spev",
                       scale_name = "Scale (Sp. Ev.)"){
  
  var_key <- c(por_name, abs_name, 
               country_name1, country_name2, country_name3, country_name4, 
               religion_name, site_name, scale_name)
  names(var_key) <- c(por_var, abs_var,
                      country_var1, country_var2, country_var3, country_var4,
                      religion_var, site_var, scale_var)
  
  reg_class <- class(reg)

  if ("lmerModLmerTest" %in% reg_class || reg_class == "lm") {
    regtab <- summary(reg)$coefficients %>%
      data.frame() %>%
      rownames_to_column("Parameter") %>%
      rename(β = Estimate,
              `Std. Err.` = Std..Error,
              t = t.value,
              p = Pr...t..) %>%
      mutate(signif = case_when(p < 0.001 ~ "***",
                                p < 0.01 ~ "**",
                                p < 0.05 ~ "*",
                                TRUE ~ ""),
             p = case_when(p < 0.001 ~ "<0.001",
                           TRUE ~ format(round(p, 3), nsmall = 3))) %>%
      mutate_at(vars(-c(Parameter, p, signif)), 
                funs(format(round(., 2), nsmall = 2))) %>%
      rename(" " = signif)
  }
  
  if (reg_class == "brmsfit") {
    regtab <- fixef(reg) %>%
      data.frame() %>%
      rownames_to_column("Parameter") %>%
      rename(β = Estimate,
              `Std. Err.` = Est.Error) %>%
      mutate(nonzero = case_when((Q2.5 * Q97.5) > 0 ~ "*",
                                 TRUE ~ "")) %>%
      mutate_at(vars(-Parameter, -nonzero), 
                funs(format(round(., 2), nsmall = 2))) %>%
      mutate(`95% CI` = paste0("[", Q2.5, ", ", Q97.5, "]")) %>%
      select(Parameter, β, `Std. Err.`, `95% CI`, nonzero) %>%
      rename(" " = nonzero)
  }
  
  regtab <- regtab %>%
    mutate(Parameter = gsub("\\:", " × ", Parameter),
           Parameter = gsub("\\(Intercept\\)", "Intercept", Parameter),
           Parameter = str_replace_all(string = Parameter, var_key))
  
  return(regtab)
}

# function for writing regression table (random effects, residual variance)
regtab_ran_fun <- function(reg,
                           por_var = "por_score_std",
                           por_name = "Porosity",
                           abs_var = "abs_score_std",
                           abs_name = "Absorption",
                           country_var = "country",
                           country_name = "Country",
                           religion_var = "religion",
                           religion_name = "Religion",
                           site_var = "site",
                           site_name = "Site",
                           subj_var = "subject_id",
                           subj_name = "Individual",
                           scale_var = "spirit_scale",
                           scale_name = "Scale (Sp. Ev.)"){
  
  var_key <- c(por_name, abs_name, 
               country_name, religion_name, site_name, subj_name)
  names(var_key) <- c(por_var, abs_var,
                      country_var, religion_var, site_var, subj_var)
  
  reg_class <- class(reg)

  if ("lmerModLmerTest" %in% reg_class) {
    regtab <- summary(reg)$varcor %>%
      data.frame() %>%
      select(grp, var1, vcov, sdcor) %>%
      mutate(grp = gsub("\\..*$", "", grp))
    
    levels_grp <- c(regtab[(nrow(regtab) - 1):1,"grp"], 
                    regtab[nrow(regtab),"grp"]) %>% unique()
    
    levels_var1 <- c("(Intercept)", por_var, abs_var,
                     country_var, site_var, religion_var, scale_var)
    
    regtab <- regtab %>%
      mutate(grp = factor(grp, levels = levels_grp),
             var1 = factor(var1, levels = levels_var1)) %>%
      arrange(grp, var1) %>%
      mutate_at(vars(grp, var1), funs(as.character)) %>%
      mutate_at(vars(grp, var1), funs(gsub("\\(", "", .))) %>%
      mutate_at(vars(grp, var1), funs(gsub("\\)", "", .))) %>%
      rename(Group = grp, Type = var1, Variance = vcov, `Std. Dev.` = sdcor) %>%
      mutate(Group = gsub("\\:", ", nested within ", Group))
    
  }
  
  if (reg_class == "brmsfit") {
    regsum <- summary(reg)
    
    rantab <- data.frame()
    for (i in 1:length(regsum$group)) {
      temptab <- regsum$random[[regsum$group[i]]] %>%
        data.frame() %>%
        rownames_to_column("Type") %>%
        mutate(grp = regsum$group[[i]])
      rantab <- bind_rows(rantab, temptab)
    }
    
    resid <- regsum$spec_pars %>%
      data.frame() %>%
      bind_cols("grp" = "Residual", Type = "sd(Intercept)")
    
    regtab <- bind_rows(rantab, resid) %>%
      rename(Group = grp, `Std. Dev.` = Estimate) %>%
      mutate(Variance = `Std. Dev.`^2,
             Type = gsub("sd\\(", "", Type),
             Type = gsub("\\)", "", Type)) %>%
      select(Group, Type, Variance, `Std. Dev.`) %>%
      separate(Group, c("grp1", "grp2", "grp3", "grp4", "grp5"), sep = ":") %>%
      unite(Group, c(grp5, grp4, grp3, grp2, grp1), sep = ", nested within ") %>%
      mutate(Group = gsub("NA, nested within ", "", Group))
    
  }

  regtab <- regtab %>%
    mutate_at(vars(Variance, `Std. Dev.`), 
              funs(format(round(., 2), nsmall = 2))) %>%
    mutate_at(vars(Group, Type),
              funs(str_replace_all(string = ., var_key))) %>%
    mutate(Type = case_when(is.na(Type) ~ "", 
                            Type == "Intercept" ~ Type,
                            TRUE ~ paste0("Slope (", Type, ")")))
  
  return(regtab)
}


# function for styling regtab for easy import to word document
regtab_style_fun <- function(regtab,
                             row_emph = NULL,
                             font_sz = 16,
                             text_col = "black"){
  
  if (" " %in% names(regtab)) {
    align_vec = c(rep("r", ncol(regtab) - 1), "l")
  } else {
    align_vec = "r"
  }
  
  regtab_styled <- regtab %>%
    kable(align = align_vec) %>%
    kable_styling(font_size = font_sz) %>%
    row_spec(1:nrow(regtab), color = text_col)
  
  if (length(row_emph) > 0) {
    regtab_styled <- regtab_styled %>%
      row_spec(row_emph, bold = T)
  }
  
  return(regtab_styled)
}

