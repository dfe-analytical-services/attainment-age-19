#Elisha Duddle
#11.08.2022
#Using Sue and Anneka's code to run the app with 2020/21 data.

#Sue Wallace
#15.02.2019
# Using Anneka's code to run the app with the aim of updating with 2019 data. 


#install packages ----

# If you don't already have the libraries below installed then you will need to 
#install them first

#This project is using packrat. Meaning that any installed libraries will
#appear in attainment-age-19-master>packrat>lib>x86...> 3.5.1

#### 
# 1. Load packages ----
# install.packages('leaflet')
# install.packages('geojsonio')
# install.packages('rgdal')
# install.packages('sp')
# install.packages('data.table')
# install.packages('RColorBrewer')
# install.packages('raster')
# install.packages('pander')
# install.packages('DT')
# install.packages('ggalt')
# install.packages('magrittr')
# install.packages('tidyverse')
# install.packages('shinycssloaders')
# install.packages('dplyr')
# install.packages('shinyjs')
# install.packages('testthat')
# install.packages('styler')
# install.packages('shinyGovstyle')
# install.packages('shiny')
# install.packages('shinytest')
# install.packages('shinydashboard')
# install.packages('shinyWidgets')


####
# 2. Creating useful functions
# Here we create a function to say increased/decreased for yearly changes which we need in the text on the app. 
# past tense

change_ed <- function(numA, numB) {
  
  if(numA < numB) {return ('increased from')}
  
  if(numA > numB) {return ('decreased from')}
  
  else {return('stayed the same at')}
  
}

## Set year references:
#***Action update the latest year reference below when we have new data.

latest_year <- 2021
last_year   <- latest_year - 1
first_year  <- 2005

####
# 3. Load the data required ----
#***Action save the new underlying data in the required format within the data folder and update name below. 

#la_ud <- read_csv('data/LA_UD_v3_supp.csv', col_types = cols(.default = "c"))
#la_ud <- read_csv('data/LA_UD_draft_mockup_v4_SM.csv', col_types = cols(.default = "c"))
la_ud <- read_csv('data\\L23_Attainment_2021.csv', col_types = cols(.default = "c"))
la_ud_VB <- read_csv('data\\L23_Attainment_2021_VB_V2.csv', col_types = cols(.default = "c"))

la_ud_VB$value <- round((as.numeric(la_ud_VB$value)), digits = 1)
#4. Overview tab



# National bar charts (front page)

national_bars_rate <- function(category) {
  if (category == 'Level 2') {
    data <- filter(la_ud, gender == 'ALL', fsm=='ALL', sen=='ALL', la_name=='ALL', region=='ALL',cohort_19_in<=latest_year) %>%
      mutate(year = as.factor(cohort_19_in),
             value = as.numeric(l2_by19_rate))
    
    plot <- data %>%
      ggplot(aes(x = year, y = value)) +
      geom_bar(fill = 'dodgerblue4', stat = "identity") +
      ylab("Level 2 by age 19 percentage")
  }
  
  if (category == 'Level 3') {
    data <- filter(la_ud, gender == 'ALL', fsm=='ALL', sen=='ALL', la_name=='ALL', region=='ALL', cohort_19_in<=latest_year) %>%
      mutate(year = as.factor(cohort_19_in),
             value = as.numeric(l3_by19_rate))
    
    plot <- data %>%
      ggplot(aes(x = year, y = value)) +
      geom_bar(fill = 'dodgerblue3', stat = "identity") +
      ylab("Level 3 by age 19 percentage")
  }
  
  plot <- plot +
    #scale_y_continuous(breaks = seq(0, max(data$value + 0.5), 0.50)) +
    theme_classic() +
    theme(axis.title.x = element_blank(),
          text = element_text(size = 14)) +
    geom_text(
      data = data,
      aes(label = sprintf("%.1f", value)),
      colour = "white",
      vjust = 2
    )
  
  return(plot)
} 


national_bars_num <- function(category) {
  if (category == 'Level 2') {
    data <- filter(la_ud, gender == 'ALL', fsm=='ALL', sen=='ALL', la_name=='ALL', region=='ALL', cohort_19_in<=latest_year) %>%
      mutate(year = as.factor(cohort_19_in),
             value = as.numeric(l2_by19))
    
    plot <- data %>% 
      ggplot(aes(x = year, y = value)) +
      geom_bar(fill = 'dodgerblue4', stat = "identity") +
      ylab("Level 2 by age 19")
  }
  
  if (category == 'Level 3') {
    data <- filter(la_ud, gender == 'ALL', fsm=='ALL', sen=='ALL', la_name=='ALL', region=='ALL', cohort_19_in<=latest_year) %>%
      mutate(year = as.factor(cohort_19_in),
             value = as.numeric(l3_by19))
    
    plot <- data %>%
      ggplot(aes(x = year, y = value)) +
      geom_bar(fill = 'dodgerblue3', stat = "identity") +
      ylab("Level 3 by age 19") 
  }
  
  plot <- plot + 
    theme_classic() +
    theme(axis.title.x = element_blank(),
          text=element_text(size=14)) +
    geom_text(
      data = data,
      aes(label = prettyNum(value, big.mark = ",")),
      colour="white",
      vjust = 2) +
    scale_y_continuous(labels = scales::comma)
  
  return(plot)
}


####
# 5. LA trends - FSM ----
#First we define the FSM data we want in the plots. 

la_plot_data_fsm <-
  dplyr::select(
    filter(la_ud, la_name!='ALL', gender=='ALL', sen=='ALL', cohort_19_in<=latest_year),
    cohort_19_in,
    number_in_ss_cohort,
    la_name,
    fsm,
    l2_by19,
    l2_with_em_by19,
    l3_by19,
    l2_by19_rate,
    l2_with_em_by19_rate,
    l3_by19_rate) %>%
  mutate(fsm = ifelse(
    fsm == "ALL","All",
    ifelse(fsm == "Not eligible for FSM","Not eligible for FSM",
           ifelse(fsm == "Eligible for FSM", "Eligible for FSM", "NA")))) 


#Now we define the FSM rate plot.
la_plot_rate_fsm <- function(la, category) {
  
  d <- filter(la_plot_data_fsm, la_name == la) 
  
  if (category == 'Level 2') {
    ylabtitle <- "Level 2 by 19 percentage"
    d <- d %>% mutate(y_var = l2_by19_rate) %>% filter(y_var != 'x') 
  }
  
  if (category == 'Level 2 with English & maths') {
    ylabtitle <- "Level 2 with English & maths by 19 %"
    d <- d %>% mutate(y_var = l2_with_em_by19_rate) %>% filter(y_var != 'x') 
  }
  
  if (category == 'Level 3') {
    ylabtitle <- "Level 3 by 19 percentage"
    d <- d %>% mutate(y_var = l3_by19_rate) %>% filter(y_var != 'x') 
  }
  d <- d %>% rename(`Cohort 19 in`=cohort_19_in, Percentage=y_var, FSM=fsm) %>% 
    mutate(
      Percentage=round(as.numeric(Percentage),1),
      FSM=as.factor(FSM)
      )
  return(
      (ggplot(d,
       aes(x = `Cohort 19 in`, 
           y = Percentage, 
           group = FSM, colour = FSM,
           text=paste("x = ",`Cohort 19 in`,"<br>y=",Percentage))) +
      geom_path(size = 1) +
      xlab("Cohort 19 in") +
      ylab(ylabtitle) +
      scale_y_continuous(limits = c(0, max(d$Percentage)*1.1), breaks=seq(0,100,10)) +
      theme_classic() +
      labs(colour = NULL) +
      scale_color_manual(values = c("#28A197","#801650","#12436D"))+
      theme(legend.title=element_blank(),
            axis.text=element_text(size=12),
            axis.title=element_text(size=12,face="bold"),
            axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))) %>%
    ggplotly(tooltip=c("text"))
  )
}

#Similarly we define the FSM number plot.
la_plot_num_fsm <- function(la, category) {
  
  d <- filter(la_plot_data_fsm, la_name == la) 
  
  if (category == 'Level 2') {
    ylabtitle <- "Level 2 by 19"
    d <- d %>% mutate(y_var = l2_by19) %>% filter(y_var != 'c') 
  }
  
  if (category == 'Level 2 with English & maths') {
    ylabtitle <- "Level 2 with English & maths by 19"
    d <- d %>% mutate(y_var = l2_with_em_by19) %>% filter(y_var != 'c') 
  }
  
  if (category == 'Level 3') {
    ylabtitle <- "Level 3 by 19"
    d <- d %>% mutate(y_var = l3_by19) %>% filter(y_var != 'c') 
  }
  
  return(
    d %>%
      ggplot +
      aes(x = cohort_19_in, 
          y = as.numeric(y_var), 
          group = fsm, colour = as.factor(fsm)) +
      geom_path(size = 1) +
      xlab("Cohort 19 in") +
      ylab(ylabtitle) +
      scale_y_continuous(limits = c(0, max(as.numeric(d$y_var))*1.1)) +
      theme_classic() +
      # geom_text(
      #   d = d %>% filter(cohort_19_in == min(as.numeric(cohort_19_in))+1),
      #   aes(label = fsm),
      #   size = 5,
      #   hjust = 0,
      #   vjust = -0.5,
      #   check_overlap = TRUE) +
      #theme(legend.position = "none") +
      #labs(fill = "FSM Eligibility") +
      #scale_color_discrete(name = "New Legend Title") +
      #guides(fill=guide_legend(title="New Legend Title")) +
    labs(colour = NULL) +
      scale_color_manual(values = c("#28A197","#801650","#12436D"))+
      theme(legend.title=element_blank())+
      theme(axis.text=element_text(size=12),
            axis.title=element_text(size=12,face="bold"),
            axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)))
}



### FSM LA time series tables to go under the charts

#Numbers table
la_table_num_fsm <- function(la, category) {
  
  d <- filter(la_plot_data_fsm, la_name == la)
  
  if(category=='Level 2') { 
    d <- d %>% mutate(t_var = l2_by19)
  }
  if(category=='Level 2 with English & maths') {
    d <- d %>% mutate(t_var = l2_with_em_by19)
  }  
  if(category=='Level 3') {
    d <- d %>% mutate(t_var = l3_by19)
  }  
  
  table <- d %>%
    mutate(
      yearf = cohort_19_in,
      value = t_var,
      Type = fsm
    ) %>%
    dplyr::select(yearf, Type, value) %>%
    spread(key = yearf, value)
  
  row.names(table) <- NULL
  
  table[is.na(table)] <- "c"
  
  table[table == "NA"] <- "c"
  
  return(table)
  
}

#Rates table
la_table_rate_fsm <- function(la, category) {
  
  d <- filter(la_plot_data_fsm, la_name == la)
  
  if(category=='Level 2') { 
    d <- d %>% mutate(t_var = round(as.numeric(l2_by19_rate),1))
  }
  if(category=='Level 2 with English & maths') {
    d <- d %>% mutate(t_var = round(as.numeric(l2_with_em_by19_rate),1))
  }  
  if(category=='Level 3') {
    d <- d %>% mutate(t_var = round(as.numeric(l3_by19_rate),1))
  }  
  
  table <- d %>%
    mutate(
      yearf = cohort_19_in,
      value = sprintf("%.1f", t_var),
      Type = fsm
    ) %>%
    dplyr::select(yearf, Type, value) %>%
    spread(key = yearf, value)
  
  row.names(table) <- NULL
  
  table[is.na(table)] <- "c"
  
  table[table == "NA"] <- "c"
  
  return(table)
  
}

# Numbers for LA summary text - we dont currenly include numbers just rates but defined below if ever needed.

la_l2_num <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL') %>%
           dplyr::select(l2_by19))
  
}

la_l2_num_fsm <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='Eligible for FSM', sen=='ALL') %>%
           dplyr::select(l2_by19))
  
}

la_l2_num_nonfsm <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='Not eligible for FSM', sen=='ALL') %>%
           dplyr::select(l2_by19))
  
}

la_l2em_num <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL') %>%
           dplyr::select(l2_with_em_by19))
  
}

la_l2em_num_fsm <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='Eligible for FSM', sen=='ALL') %>%
           dplyr::select(l2_with_em_by19))
  
}

la_l2em_num_nonfsm <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='Not eligible for FSM', sen=='ALL') %>%
           dplyr::select(l2_with_em_by19))
  
}

la_l3_num <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL') %>%
           dplyr::select(l3_by19))
  
}

la_l3_num_fsm <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='Eligible for FSM', sen=='ALL') %>%
           dplyr::select(l3_by19))
  
}

la_l3_num_nonfsm <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='Not eligible for FSM', sen=='ALL') %>%
           dplyr::select(l3_by19))
  
}

# Rates for LA summary text

la_l2_rate <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

la_l2_rate_fsm <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='Eligible for FSM', sen=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

la_l2_rate_nonfsm <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='Not eligible for FSM', sen=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

la_l2em_rate <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

la_l2em_rate_fsm <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='Eligible for FSM', sen=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

la_l2em_rate_nonfsm <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='Not eligible for FSM', sen=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

la_l3_rate <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

la_l3_rate_fsm <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='Eligible for FSM', sen=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

la_l3_rate_nonfsm <- function(la, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='Not eligible for FSM', sen=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

#region reference - FSM

#region name for the regional summary text.
region_name <- function (la) {
  d <- filter(la_ud, la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL', cohort_19_in==latest_year) %>%
           dplyr::select(region))
  
}

#region rates for the regional summary text
reg_l2_rate <- function(la, refyear) {
  reg<- as.character(region_name(la))
  
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL', la_name=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

reg_l2_rate_fsm <- function(la, refyear) {
  reg<- as.character(region_name(la))
  
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='Eligible for FSM', sen=='ALL', la_name=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

reg_l2_rate_nonfsm <- function(la, refyear) {
  reg<- as.character(region_name(la))
  
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='Not eligible for FSM', sen=='ALL', la_name=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

reg_l2em_rate <- function(la, refyear) {
  reg<- as.character(region_name(la))
  
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL', la_name=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

reg_l2em_rate_fsm <- function(la, refyear) {
  reg<- as.character(region_name(la))
  
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='Eligible for FSM', sen=='ALL', la_name=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

reg_l2em_rate_nonfsm <- function(la, refyear) {
  reg<- as.character(region_name(la))
  
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='Not eligible for FSM', sen=='ALL', la_name=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

reg_l3_rate <- function(la, refyear) {
  reg<- as.character(region_name(la))
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL', la_name=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

reg_l3_rate_fsm <- function(la, refyear) {
  reg<- as.character(region_name(la))
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='Eligible for FSM', sen=='ALL', la_name=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

reg_l3_rate_nonfsm <- function(la, refyear) {
  reg<- as.character(region_name(la))
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='Not eligible for FSM', sen=='ALL', la_name=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

#National rates for the national summary - FSM

nat_l2_rate <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

nat_l2_rate_fsm <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='Eligible for FSM', sen=='ALL', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

nat_l2_rate_nonfsm <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='Not eligible for FSM', sen=='ALL', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

nat_l2em_rate <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL',la_name=='ALL', region=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

nat_l2em_rate_fsm <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='Eligible for FSM', sen=='ALL', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

nat_l2em_rate_nonfsm <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='Not eligible for FSM', sen=='ALL', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

nat_l3_rate <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

nat_l3_rate_fsm <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='Eligible for FSM', sen=='ALL', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

nat_l3_rate_nonfsm <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='Not eligible for FSM', sen=='ALL', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

# 6. LA trends - SEN ----
#Here we define the SEN plot data

la_plot_data_sen <-
  dplyr::select(
    filter(la_ud, la_name!='ALL', gender=='ALL', fsm=='ALL', cohort_19_in!=first_year, cohort_19_in<=latest_year, 
           sen %in% c('ALL', 'No SEN','SEN with statements or EHC plans','SEN without statements or EHC plans')),
    cohort_19_in,
    number_in_ss_cohort,
    la_name,
    sen,
    l2_by19,
    l2_with_em_by19,
    l3_by19,
    l2_by19_rate,
    l2_with_em_by19_rate,
    l3_by19_rate) %>%
  mutate(sen = ifelse(
    sen == "ALL","All",
    ifelse(sen == "No SEN","No identified SEN",
           ifelse(sen == "SEN with statements or EHC plans", "SEN with statements or EHC plan",
                  ifelse(sen == "SEN without statements or EHC plans", "SEN without statements or EHC plans","NA")))))


#Defining the SEN rate plot.
la_plot_rate_sen <- function(la2, category2) {
  
  d <- filter(la_plot_data_sen, la_name == la2) 
  
  if (category2 == 'Level 2') {
    ylabtitle <- "Level 2 by 19 percentage"
    d <- d %>% mutate(y_var = l2_by19_rate) %>% filter(y_var != 'x') 
  }
  
  if (category2 == 'Level 2 with English & maths') {
    ylabtitle <- "Level 2 with English & maths by 19 %"
    d <- d %>% mutate(y_var = l2_with_em_by19_rate) %>% filter(y_var != 'x') 
  }
  
  if (category2 == 'Level 3') {
    ylabtitle <- "Level 3 by 19 percentage"
    d <- d %>% mutate(y_var = l3_by19_rate) %>% filter(y_var != 'x') 
  }
  
  return(
    d %>%
      ggplot +
      aes(x = cohort_19_in, 
          y = round(as.numeric(y_var),1), 
          group = sen, colour = as.factor(sen)) +
      geom_path(size = 1) +
      xlab("Cohort 19 in") +
      ylab(ylabtitle) +
      scale_y_continuous(limits = c(0, max(as.numeric(d$y_var))*1.1), breaks=seq(0,100,10)) +
      theme_classic() +
      # geom_text(
      #   d = d %>% filter(cohort_19_in == min(as.numeric(cohort_19_in))+1),
      #   aes(label = sen),
      #   size = 5,
      #   hjust = 0,
      #   vjust = -0.5) +
      labs(colour = NULL) +
      #theme(legend.position = "none") +
      scale_color_manual(values = c("#28A197","#801650","#12436D","#F46A25"))+
      theme(axis.text=element_text(size=12),
            axis.title=element_text(size=12,face="bold"),
            axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)))
}

#Defining the SEN number plot. 
la_plot_num_sen <- function(la2, category2) {
  
  d <- filter(la_plot_data_sen, la_name == la2) 
  
  if (category2 == 'Level 2') {
    ylabtitle <- "Level 2 by 19"
    d <- d %>% mutate(y_var = l2_by19) %>% filter(y_var != 'c') 
  }
  
  if (category2 == 'Level 2 with English & maths') {
    ylabtitle <- "Level 2 with English & maths by 19"
    d <- d %>% mutate(y_var = l2_with_em_by19) %>% filter(y_var != 'c') 
  }
  
  if (category2 == 'Level 3') {
    ylabtitle <- "Level 3 by 19"
    d <- d %>% mutate(y_var = l3_by19) %>% filter(y_var != 'c') 
  }
  
  return(
    d %>%
      ggplot +
      aes(x = cohort_19_in, 
          y = as.numeric(y_var), 
          group = sen, colour = as.factor(sen)) +
      geom_path(size = 1) +
      xlab("Cohort 19 in") +
      ylab(ylabtitle) +
      scale_y_continuous(limits = c(0, max(as.numeric(d$y_var))*1.1)) +
      theme_classic() +
      # geom_text(
      #   d = d %>% filter(cohort_19_in == min(as.numeric(cohort_19_in))+1),
      #   aes(label = sen),
      #   size = 5,
      #   hjust = 0,
      #   vjust = -0.5) +
      #theme(legend.position = "none") +
      labs(colour = NULL) +
      scale_color_manual(values = c("#28A197","#801650","#12436D","#F46A25"))+
      theme(axis.text=element_text(size=12),
            axis.title=element_text(size=12,face="bold"),
            axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)))
}



### LA time series tables to go under the plots
#As we want to show all categories including school action, school action plus in the tables, we need to define 
#a different set of data for the tables.

la_table_data_sen <-
  dplyr::select(
    filter(la_ud, la_name!='ALL', gender=='ALL', fsm=='ALL', cohort_19_in!=first_year, cohort_19_in<=latest_year), 
    cohort_19_in,
    number_in_ss_cohort,
    la_name,
    sen,
    l2_by19,
    l2_with_em_by19,
    l3_by19,
    l2_by19_rate,
    l2_with_em_by19_rate,
    l3_by19_rate) %>%
  mutate(sen = ifelse(
    sen == "ALL","All",
    ifelse(sen == "No SEN","No identified SEN",
           ifelse(sen == "SEN with statements or EHC plans", "SEN with statements or EHC plan",
                  ifelse(sen == "SEN without statements or EHC plans", "SEN without statements or EHC plans","NA")))))

#SEN numbers table.
la_table_num_sen <- function(la2, category2) {
  
  d <- filter(la_table_data_sen, la_name == la2)
  
  if(category2=='Level 2') { 
    d <- d %>% mutate(t_var = l2_by19)
  }
  if(category2=='Level 2 with English & maths') {
    d <- d %>% mutate(t_var = l2_with_em_by19)
  }  
  if(category2=='Level 3') {
    d <- d %>% mutate(t_var = l3_by19)
  }  
  
  table <- d %>%
    mutate(
      yearf = cohort_19_in,
      value = t_var,
      Type = sen
    ) %>%
    dplyr::select(yearf, Type, value) %>%
    spread(key = yearf, value)
  
  row.names(table) <- NULL
  
  table[is.na(table)] <- "c"
  
  table[table == "NA"] <- "c"
  
  return(table)
  
}

#SEN rates table.
la_table_rate_sen <- function(la2, category2) {
  
  d <- filter(la_table_data_sen, la_name == la2)
  
  if(category2=='Level 2') { 
    d <- d %>% mutate(t_var = round(as.numeric(l2_by19_rate),1))
  }
  if(category2=='Level 2 with English & maths') {
    d <- d %>% mutate(t_var = round(as.numeric(l2_with_em_by19_rate),1))
  }  
  if(category2=='Level 3') {
    d <- d %>% mutate(t_var = round(as.numeric(l3_by19_rate),1))
  }  
  
  table <- d %>%
    mutate(
      yearf = cohort_19_in,
      value = sprintf("%.1f", t_var),
      Type = sen
    ) %>%
    dplyr::select(yearf, Type, value) %>%
    spread(key = yearf, value)
  
  row.names(table) <- NULL
  
  table[is.na(table)] <- "c"
  
  table[table == "NA"] <- "c"
  
  return(table)
  
}

# Numbers for LA summary text - SEN. We dont currenly include numbers just rates but defined below if ever needed.

la_l2_num2 <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL') %>%
           dplyr::select(l2_by19))
  
}

la_l2_num2_sen_with <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN with statements or EHC plans') %>%
           dplyr::select(l2_by19))
  
}

la_l2_num2_sen_without <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN without statements or EHC plans') %>%
           dplyr::select(l2_by19))
  
}

la_l2_num2_nosen <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='No SEN') %>%
           dplyr::select(l2_by19))
  
}

la_l2em_num2 <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL') %>%
           dplyr::select(l2_with_em_by19))
  
}

la_l2em_num2_sen_with <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN with statements or EHC plans') %>%
           dplyr::select(l2_with_em_by19))
  
}

la_l2em_num2_sen_without <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN without statements or EHC plans') %>%
           dplyr::select(l2_with_em_by19))
  
}

la_l2em_num2_nosen <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='No SEN') %>%
           dplyr::select(l2_with_em_by19))
  
}

la_l3_num2 <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL') %>%
           dplyr::select(l3_by19))
  
}

la_l3_num2_sen_with <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN with statements or EHC plans') %>%
           dplyr::select(l3_by19))
  
}

la_l3_num2_sen_without <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN without statements or EHC plans') %>%
           dplyr::select(l3_by19))
  
}

la_l3_num2_nosen <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='No SEN') %>%
           dplyr::select(l3_by19))
  
}


#Rates for LA summary text - SEN
la_l2_rate2 <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

#Rates for LA summary text - SEN to evaluate NA's across all years to bring error message
la_l2_rate3 <- function(la2, refyear) {
  
  d <- filter(la_ud,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

la_l2_rate2_sen_with <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN with statements or EHC plans') %>%
           dplyr::select(l2_by19_rate))
  
}

la_l2_rate2_sen_without <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN without statements or EHC plans') %>%
           dplyr::select(l2_by19_rate))
  
}

la_l2_rate2_nosen <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='No SEN') %>%
           dplyr::select(l2_by19_rate))
  
}

la_l2em_rate2 <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

la_l2em_rate2_sen_with <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN with statements or EHC plans') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

la_l2em_rate2_sen_without <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN without statements or EHC plans') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

la_l2em_rate2_nosen <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='No SEN') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}


la_l3_rate2 <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

la_l3_rate2_sen_with <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN with statements or EHC plans') %>%
           dplyr::select(l3_by19_rate))
  
}

la_l3_rate2_sen_without <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN without statements or EHC plans') %>%
           dplyr::select(l3_by19_rate))
  
}

la_l3_rate2_nosen <- function(la2, refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear,la_name == la2)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='No SEN') %>%
           dplyr::select(l3_by19_rate))
  
}

#region reference - SEN

#region name for the regional summary text.
region_name2 <- function (la) {
  d <- filter(la_ud, la_name == la)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL', cohort_19_in==latest_year) %>%
           dplyr::select(region))
  
}

#region rates for the regional summary text
reg_l2_rate2 <- function(la, refyear) {
  reg<- as.character(region_name2(la))
  
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL', la_name=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

reg_l2_rate2_sen_with <- function(la, refyear) {
  reg<- as.character(region_name2(la))
  
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN with statements or EHC plans', la_name=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

reg_l2_rate2_sen_without <- function(la, refyear) {
  reg<- as.character(region_name2(la))
  
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN without statements or EHC plans', la_name=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

reg_l2_rate2_nosen <- function(la, refyear) {
  reg<- as.character(region_name2(la))
  
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='ALL', sen=='No SEN', la_name=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

reg_l2em_rate2 <- function(la, refyear) {
  reg<- as.character(region_name2(la))
  
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL', la_name=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

reg_l2em_rate2_sen_with <- function(la, refyear) {
  reg<- as.character(region_name2(la))
  
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN with statements or EHC plans', la_name=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

reg_l2em_rate2_sen_without <- function(la, refyear) {
  reg<- as.character(region_name2(la))
  
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN without statements or EHC plans', la_name=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

reg_l2em_rate2_nosen <- function(la, refyear) {
  reg<- as.character(region_name2(la))
  
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='ALL', sen=='No SEN', la_name=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

reg_l3_rate2 <- function(la, refyear) {
  reg<- as.character(region_name2(la))
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL', la_name=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

reg_l3_rate2_sen_with <- function(la, refyear) {
  reg<- as.character(region_name2(la))
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN with statements or EHC plans', la_name=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

reg_l3_rate2_sen_without <- function(la, refyear) {
  reg<- as.character(region_name2(la))
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN without statements or EHC plans', la_name=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

reg_l3_rate2_nosen <- function(la, refyear) {
  reg<- as.character(region_name2(la))
  d <- dplyr::filter(la_ud, cohort_19_in == refyear, region == reg)
  
  return(dplyr::filter(d, gender == 'ALL', fsm=='ALL', sen=='No SEN', la_name=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}


#National rates for the national summary - SEN

nat_l2_rate2 <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear, la_name=='ALL', region=='ALL')
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

nat_l2_rate2_sen_with <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN with statements or EHC plans', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

nat_l2_rate2_sen_without <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN without statements or EHC plans', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

nat_l2_rate2_nosen <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='No SEN', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l2_by19_rate))
  
}

nat_l2em_rate2 <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL',la_name=='ALL', region=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

nat_l2em_rate2_sen_with <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN with statements or EHC plans',la_name=='ALL', region=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

nat_l2em_rate2_sen_without <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN without statements or EHC plans',la_name=='ALL', region=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}

nat_l2em_rate2_nosen <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='No SEN', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l2_with_em_by19_rate))
  
}


nat_l3_rate2 <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='ALL', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

nat_l3_rate2_sen_with <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN with statements or EHC plans', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

nat_l3_rate2_sen_without <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='SEN without statements or EHC plans', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}

nat_l3_rate2_nosen <- function(refyear) {
  
  d <- filter(la_ud, cohort_19_in == refyear)
  
  return(filter(d, gender == 'ALL', fsm=='ALL', sen=='No SEN', la_name=='ALL', region=='ALL') %>%
           dplyr::select(l3_by19_rate))
  
}


####7. Download LA tables

##FSM

fsm_la_table <- function(la) {
  
  d <- filter(la_ud, la_name == la, gender=='ALL', sen=='ALL', cohort_19_in<=latest_year) %>%
    select(
      cohort_19_in,
      number_in_ss_cohort,
      region,
      la_name,
      fsm,
      l2_by19,
      l2_with_em_by19,
      l3_by19,
      l2_by19_rate,
      l2_with_em_by19_rate,
      l3_by19_rate
    )
  
  return(d)
}

##SEN

sen_la_table <- function(la) {
  
  d <- filter(la_ud, la_name == la, gender=='ALL', fsm=='ALL', cohort_19_in!=first_year, cohort_19_in<=latest_year) %>%
    dplyr::select(
      cohort_19_in,
      number_in_ss_cohort,
      region,
      la_name,
      sen,
      l2_by19,
      l2_with_em_by19,
      l3_by19,
      l2_by19_rate,
      l2_with_em_by19_rate,
      l3_by19_rate
    )
  
  return(d)
}



####
# 8. MAP ----

# ukLocalAuthoritises <- shapefile("data/England_LA_2016.shp")
# 
# underlying_data <- filter(la_ud, gender=='ALL', fsm=='ALL', sen=='ALL', cohort_19_in ==latest_year) %>%
#   dplyr::select(la_code_3,l2_by19_rate, l2_with_em_by19_rate, l3_by19_rate, l2_em_by19_belowat16_rate)
# 
# underlying_data$l2_by19_rate <- round(as.numeric(underlying_data$l2_by19_rate),1)
# underlying_data$l2_with_em_by19_rate <- round(as.numeric(underlying_data$l2_with_em_by19_rate),1)
# underlying_data$l3_by19_rate <- round(as.numeric(underlying_data$l3_by19_rate),1)
# underlying_data$l2_em_by19_belowat16_rate <- round(as.numeric(underlying_data$l2_em_by19_belowat16_rate),1)
# 
# ukLocalAuthoritises <- spTransform(ukLocalAuthoritises, CRS("+proj=longlat +ellps=GRS80"))
# englishLocalAuthorities = subset(ukLocalAuthoritises, LA15CD %like% "E") # Code begins with E
# 
# englishLocalAuthorityData <- sp::merge(englishLocalAuthorities, 
#                                    underlying_data, 
#                                    by.x = 'LA_Code', 
#                                    by.y = 'la_code_3',
#                                    all.y = TRUE,
#                                    duplicateGeoms = TRUE)
# 
# #level 2
# 
# # Create bins for colour plotting
# l2_rate_Pal <- colorQuantile('YlOrRd', englishLocalAuthorityData$l2_by19_rate, n = 5, reverse = TRUE)
# #colorQuantile defaults to 0-20%, 20-40%, 40-60%, 60-80%, 80-100% as the labels on the legend
# #whereas colorNumeric gives a scale
# #colorBin splits into a defined number of bins
# 
# # Add a label for tooltip (bit of html)
# l2_rate_Labels <- sprintf("<strong>%s</strong><br/>Level 2 by 19 rate <strong>%g</strong> <sup></sup>",
#                                  englishLocalAuthorityData$LA15NM, englishLocalAuthorityData$l2_by19_rate) %>%
#   lapply(htmltools::HTML)
# 
# #level 2 EM
# 
# # Create bins for colour plotting
# l2EM_rate_Pal = colorQuantile('YlOrRd', englishLocalAuthorityData$l2_with_em_by19_rate, n = 5,reverse = TRUE)
# 
# # Add a label for tooltip (bit of html)
# l2EM_rate_Labels <- sprintf("<strong>%s</strong><br/>Level 2 with English and maths by 19 rate <strong>%g</strong> <sup></sup>",
#                           englishLocalAuthorityData$LA15NM, englishLocalAuthorityData$l2_with_em_by19_rate) %>%
#   lapply(htmltools::HTML)
# 
# #level 3
# 
# # Create bins for colour plotting
# l3_rate_Pal = colorQuantile('YlOrRd', englishLocalAuthorityData$l3_by19_rate, n = 5, reverse = TRUE)
# 
# # Add a label for tooltip (more html...)
# l3_rate_Labels <- sprintf("<strong>%s</strong><br/>Level 3 by 19 rate <strong>%g</strong> <sup></sup>",
#                                   englishLocalAuthorityData$LA15NM, englishLocalAuthorityData$l3_by19_rate) %>%
#   lapply(htmltools::HTML)
# 
# #level 2 EM by 19, below at 16
# 
# # Create bins for colour plotting
# l2em19bl16_rate_Pal = colorQuantile('YlOrRd', englishLocalAuthorityData$l2_em_by19_belowat16_rate, n = 5, reverse = TRUE)
# 
# # Add a label for tooltip (more html...)
# l2em19bl16_rate_Labels <- sprintf("<strong>%s</strong><br/>Level 2 English and maths by 19, of those below at 16 rate <strong>%g</strong> <sup></sup>",
#                           englishLocalAuthorityData$LA15NM, englishLocalAuthorityData$l2_em_by19_belowat16_rate) %>%
#   lapply(htmltools::HTML)
# 
# 
# excmap <- function(measure) {
#   
#   if(measure == 'l2') {
#     
#     return(
#       leaflet(englishLocalAuthorityData) %>%
#         addProviderTiles(providers$CartoDB.Positron,
#                          options = providerTileOptions(minZoom = 6, maxZoom = 10)) %>%
#         addPolygons(fillColor = ~l2_rate_Pal(englishLocalAuthorityData$l2_by19_rate),
#                     weight = 2,
#                     opacity = 1,
#                     color = "white",
#                     dashArray = "3",
#                     fillOpacity = 0.7,
#                     highlight = highlightOptions(
#                       weight = 5,
#                       color = "#666",
#                       dashArray = "",
#                       fillOpacity = 0.7,
#                       bringToFront = TRUE),
#                     label = l2_rate_Labels,
#                     labelOptions = labelOptions(
#                       style = list("font-weight" = "normal", padding = "3px 8px"),
#                       textsize = "15px",
#                       direction = "auto")) %>%
#         addLegend(colors = c("#BD0026","#F03B20","#FD8D3C","#FECC5C","#FFFFB2"), 
#                   opacity = 0.7, 
#                   title = NULL,
#                   position = "topright",
#                   labels= c("Lowest attainment rates", "","","","Highest attainment rates"))
#       
#     )
#   }
#   
#   if(measure == 'l2EM') {
#     
#     return(
#       leaflet(englishLocalAuthorityData) %>%
#         addProviderTiles(providers$CartoDB.Positron,
#                          options = providerTileOptions(minZoom = 6, maxZoom = 10)) %>%
#         addPolygons(fillColor = ~l2EM_rate_Pal(englishLocalAuthorityData$l2_with_em_by19_rate),
#                     weight = 2,
#                     opacity = 1,
#                     color = "white",
#                     dashArray = "3",
#                     fillOpacity = 0.7,
#                     highlight = highlightOptions(
#                       weight = 5,
#                       color = "#666",
#                       dashArray = "",
#                       fillOpacity = 0.7,
#                       bringToFront = TRUE),
#                     label = l2EM_rate_Labels,
#                     labelOptions = labelOptions(
#                       style = list("font-weight" = "normal", padding = "3px 8px"),
#                       textsize = "15px",
#                       direction = "auto")) %>%
#         addLegend(colors = c("#BD0026","#F03B20","#FD8D3C","#FECC5C","#FFFFB2"), 
#                   opacity = 0.7, 
#                   title = NULL,
#                   position = "topright",
#                   labels= c("Lowest attainment rates", "","","","Highest attainment rates"))
#     )
#   }
#   
#   if(measure == 'l3') {
#     
#     return(
#       leaflet(englishLocalAuthorityData) %>%
#         addProviderTiles(providers$CartoDB.Positron,
#                          options = providerTileOptions(minZoom = 6, maxZoom = 10)) %>%
#         addPolygons(fillColor = ~l3_rate_Pal(englishLocalAuthorityData$l3_by19_rate),
#                     weight = 2,
#                     opacity = 1,
#                     color = "white",
#                     dashArray = "3",
#                     fillOpacity = 0.7,
#                     highlight = highlightOptions(
#                       weight = 5,
#                       color = "#666",
#                       dashArray = "",
#                       fillOpacity = 0.7,
#                       bringToFront = TRUE),
#                     label = l3_rate_Labels,
#                     labelOptions = labelOptions(
#                       style = list("font-weight" = "normal", padding = "3px 8px"),
#                       textsize = "15px",
#                       direction = "auto")) %>%
#         addLegend(colors = c("#BD0026","#F03B20","#FD8D3C","#FECC5C","#FFFFB2"), 
#                   opacity = 0.7, 
#                   title = NULL,
#                   position = "topright",
#                   labels= c("Lowest attainment rates", "","","","Highest attainment rates"))
#     )
#   }
#   
#   if(measure == 'l2em19bl16') {
#     
#     return(
#       leaflet(englishLocalAuthorityData) %>%
#         addProviderTiles(providers$CartoDB.Positron,
#                          options = providerTileOptions(minZoom = 6, maxZoom = 10)) %>%
#         addPolygons(fillColor = ~l2em19bl16_rate_Pal(englishLocalAuthorityData$l2_em_by19_belowat16_rate),
#                     weight = 2,
#                     opacity = 1,
#                     color = "white",
#                     dashArray = "3",
#                     fillOpacity = 0.7,
#                     highlight = highlightOptions(
#                       weight = 5,
#                       color = "#666",
#                       dashArray = "",
#                       fillOpacity = 0.7,
#                       bringToFront = TRUE),
#                     label = l2em19bl16_rate_Labels,
#                     labelOptions = labelOptions(
#                       style = list("font-weight" = "normal", padding = "3px 8px"),
#                       textsize = "15px",
#                       direction = "auto")) %>%
#         addLegend(colors = c("#BD0026","#F03B20","#FD8D3C","#FECC5C","#FFFFB2"), 
#                   opacity = 0.7, 
#                   title = NULL,
#                   position = "topright",
#                   labels= c("Lowest attainment rates", "","","","Highest attainment rates"))
#     )
#   }
# }


####

