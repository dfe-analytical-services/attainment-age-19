#When updating, just need to go through and update any of the hardcoded text in each tab below and any hyperlinks.

source("codefile_shiny.R")

shinyUI(
    navbarPage("Level 2 and 3 attainment by age 19", 
               id = "nav",
               theme = "shiny.css", 
               # 1. Front page ----
               
               tabPanel("Overview",
                        sidebarLayout(
                          sidebarPanel(verticalLayout(
                            h3(strong("Understanding level 2 and 3 attainment by age 19 statistics (Pilot)")),
                            br("This tool is aimed at enabling users to further understand attainment by age 19 data and is currently under development."), 
                            hr(),
                            strong("Background"),
                            br("The purpose of this dashboard is to provide insight to lower level breakdowns included within our National Statistics release. 
                               It reports on attainment by 19 of level 2, level 2 with English and maths and level 3 at 19 by pupil characteristics at age 15. 
                               They cover pupils in the state sector at age 15."),
                            br(strong("Latest National Statistics")),
                            br("All of the data used within this dashboard, including additional breakdowns, has been published in the series",
                               a("Statistics: 16 to 19 attainment", 
                                 href = "https://www.gov.uk/government/collections/statistics-attainment-at-19-years",
                                 target="_blank"), "National Statistics release's underlying data section and is also available for download via the data and methods tab."),
                            br(strong("Guidance and methodology")),
                            br("This dashboard shows breakdowns for the number and rate of level 2 and 3 attainment by age 19 at local authority level.  
                               Further info, including definitions, is available in the data and methods tab and the technical document found on the publication page."),
                            br(strong("Definitons")),
                            br("Key defintions relating to statistics used in this application can be found in the data and methods tab.")
                            ), width = 5),
                          mainPanel(
                            br(),
                            strong("Level 2 attainment by age 19, ", paste(first_year),  " to " , paste(latest_year)), 
                            br(),
                            em("Young people in state sector at 15"),
                            radioButtons("bars_type", label=NULL, c("rate", "number"), inline = TRUE),
                            plotOutput("l2_bar", height ="8cm"),
                            hr(),
                            strong("Level 3 attainment by age 19, " , paste(first_year),  " to " , paste(latest_year)), 
                            br(),
                            em("Young people in state sector at 15"),
                            radioButtons("bars_type2", label=NULL, c("rate", "number"), inline = TRUE),
                            plotOutput("l3_bar", height ="8cm"),
                            width = 7)),
                        hr(),
                        HTML('<div><img src="Department_for_Education.png" alt="Logo", width="120", height = "71"></div>
                    <br>
                    <div><b>This is a new service - if you would like to provide feedback on this tool please contact Post16.STATISTICS@education.gov.uk</b></div>
                    <br>
                    </br>')
               ),
                   
                  # 2. LA FSM Tab  ---- will need to update national reference years and figures

                  tabPanel("LA trends - FSM",
                    sidebarLayout(
                      sidebarPanel(
                        h4(strong("Local Authority (LA) level attainment by 19 - FSM")),
                        br(),
                        h5(strong("Pick a local authority")),
                        selectInput(
                          "select2",
                          label = NULL,
                          choices = sort(unique(la_plot_data_fsm$la_name)),
                          selected = 'Darlington'
                        ),
                        h5(strong("Pick a measure")),
                        selectInput(
                          "select_cat",
                          label = NULL,
                          choices = list(
                            "Level 2" = 'l2',
                            "Level 2 with English and maths" = 'l2em',
                            "Level 3" = 'l3'
                          ),
                          selected = 'l2'
                        ),
                        h5(strong(textOutput("la_title"))),
                        textOutput("la_sum_fsm"),
                        hr(),
                        h5(strong(textOutput("region_title"))),
                        textOutput("reg_sum_fsm"),
                        hr(),
                        h5(strong("National summary")),
                        textOutput("nat_sum_fsm"),
                        hr()
                        ),
                      mainPanel(tabsetPanel(
                        tabPanel("Plot",
                          br(),
                          fluidRow(column(9,
                                          br(),
                                          column(3,
                                                 radioButtons("plot_type", "Which measure?", c("rate", "number"), inline = TRUE)
                                          ))),
                          plotOutput("t1_chart", width = '23cm'),
                          br(),
                          tableOutput("t1_table"),
                          br()
                        ),
                        tabPanel(
                          "Data download",
                          br(),
                          downloadButton("downloadFSM", "Download"),
                          br(),
                          DT::dataTableOutput("fsm_la_data")
                        )
                        
                      ))),
                    hr(),
                    HTML('<div><img src="Department_for_Education.png" alt="Logo", width="120", height = "71"></div>
                         <br>
                         <div><b>This is a new service - if you would like to provide feedback on this tool please contact Post16.STATISTICS@education.gov.uk</b></div>
                         <br>
                         </br>')),




                      # 3. LA SEN Tab  ---- will need to update national reference years and figures

                      tabPanel("LA trends - SEN",
                      sidebarLayout(
                      sidebarPanel(
                      h4(strong("Local Authority (LA) level attainment by 19 - SEN")),
                      br(),
                      h5(strong("Pick a local authority")),
                      selectInput(
                      "select3",
                      label = NULL,
                      choices = sort(unique(la_plot_data_sen$la_name)),
                      selected = 'Darlington'
                      ),
                      h5(strong("Pick a measure")),
                      selectInput(
                      "select_cat2",
                      label = NULL,
                      choices = list(
                      "Level 2" = 'l2',
                      "Level 2 with English and maths" = 'l2em',
                      "Level 3" = 'l3'
                      ),
                      selected = 'l2'
                      ),
                      h5(strong(textOutput("la_title2"))),
                      textOutput("la_sum_sen"),
                      hr(),
                      h5(strong(textOutput("region_title2"))),
                      textOutput("reg_sum_sen"),
                      hr(),
                      h5(strong("National summary")),
                      textOutput("nat_sum_sen"),
                      hr()
                      ),
                      mainPanel(tabsetPanel(
                      tabPanel("Plot",
                      br(),
                            fluidRow(column(9,
                                      br(),
                                      column(3,
                                             radioButtons("plot_type2", "Which measure?", c("rate", "number"), inline = TRUE)
                                      ))),
                      plotOutput("t2_chart", width = '23cm'),
                      br(),
                      tableOutput("t2_table"),
                      br()
                      ),
                      tabPanel(
                      "Data download",
                      br(),
                      downloadButton("downloadSEN", "Download"),
                      br(),
                      DT::dataTableOutput("sen_la_data")
                      )
                      ))),
                      hr(),
                      HTML('<div><img src="Department_for_Education.png" alt="Logo", width="120", height = "71"></div>
                           <br>
                           <div><b>This is a new service - if you would like to provide feedback on this tool please contact Post16.STATISTICS@education.gov.uk</b></div>
                           <br>
                           </br>')),



                      # 4. Map----
                      #***Action update the year reference in line 127 below.
                      tabPanel("Map",
                      sidebarLayout(
                      sidebarPanel(
                      h4(strong("Mapping level 2 and level 3 attainment by 19 rates")),
                        em("Young people in state sector at 15, ", paste(latest_year)),
                        h5(strong("Pick a measure")),
                      selectInput(
                      "select_map",
                      label = NULL,
                      choices = list("Level 2 by 19" = 'l2',
                                     "Level 2 with English and maths by 19" = 'l2EM',
                                    "Level 3 by 19" = 'l3',
                                    "Level 2 English and maths by 19, of those below at 16" = 'l2em19bl16'),
                                selected = 'l2'
                      ),
                      width = 3,
                      hr(),
                      h5(strong("Instructions")),
                      "From the dropdown menu above, please select the attainment rate of interest. Then hover over your selected local authority to find out more information about attainment data in that area.",
                      br(),
                      br(),
                      "The darkest shaded areas are in the bottom 20% of all local authorities for the selected attainment rate and the lightest shaded areas in the top 20% for the selected attainment rate."
                      ),
                      mainPanel(
                      leafletOutput("map", width = '25cm', height = '25cm') %>%
                      #spinner to appear while chart is loading
                      withSpinner(
                      color = "grey",
                      type = 5,
                      size = getOption("spinner.size", default = 0.4)
                      )
                      )
                      ),
                      hr(),
                      HTML('<div><img src="Department_for_Education.png" alt="Logo", width="120", height = "71"></div>
                           <br>
                           <div><b>This is a new service - if you would like to provide feedback on this tool please contact Post16.STATISTICS@education.gov.uk</b></div>
                           <br>
                           </br>')
                      ),


# 5. Data sources and methodology tab ----
# Will need to update any year references and hyperlink in the text below. 

tabPanel("Data and methods",
         h4(strong("Data sources")),
         "This tool uses open data published alongside the 'Level 2 and 3 attainment by young people aged 19 in ", paste(latest_year) , " 
         National Statistics release, available ",
         tags$a(href="https://www.gov.uk/government/collections/statistics-attainment-at-19-years", "here."),
         br(),
         br(),
         "The local authority figures in this tool show attainment by 19 of level 2, level 2 with English and maths and level 3 
         by pupil characteristics at age 15. They cover pupils in the state sector at age 15.",
         "Figures are also included on progression rates in level 2 English and maths, that is the proportion of those not achieving level 2 by age 16 
         who go on to achieve level 2 by age 19.",
         br(),
         br(),
         "The following underlying dataset contains all the figures included within this tool.",
         br(),
         br(),
         #h5(strong("la_underlying_data")),
         h5(strong("Local authority underlying data")),
         #br(),
         downloadButton("downloadmain_ud", "Download"),
         br(),
         br(),
         h4(strong("Methodology")),
         "i) Numerators are based upon the number of young people in the state sector at academic age 15 who reached level 2/3 or level 2 with English and Maths by 19.",
         br(),
         "ii) Denominators are based upon the number that were in the mainstream state sector at academic age 15.",
         br(),
         "iii) Pupils attending independent schools, PRUs and alternative provision at academic age 15 are excluded from these figures.",
         br(),
         "iv) The figures are calculated for each local authority based on where the pupil was learning at academic age 15.",
         br(),
         "v) Regional figures are aggregated from local authority figures and are directly comparable with national estimates in tables 6-24, but not with tables 1-5.",																	
         br(),
         br(),
         h4(strong("Notes")),
         "a) These local authority figures are comparable with the national figures shown in tables 6 to 15 within the publication.",
         br(),
         "b) These estimates include pupils in the state sector at academic age 15.",
         br(),
         "c) The characteristics are assigned according to the information in the School Census at academic age 15.",
         br(),
         "d) Note that for the purposes of these calculations the LA of a school is based on the administrative LA rather than its postcode (this will only differ in a very small number of cases).",
         br(),
         "e) Only reporting on pupils in the state sector at 15 can have a bearing on figures by local authority where a large number of pupils attended independent schools at academic age 15.",
         br(),
         "f) Attainment by FSM and SEN can also be variable from year to year, particularly for small local authorities, where the size of the FSM/SEN groups may be relatively small.",
         br(),
         "g) A young person aged 19 at the end of academic year 2016/17 is referred to as '19 in 17' in these figures.",
         br(),
         "h) These are final figures but historical figures are subject to minor alterations each year.",	
         hr(),
         HTML('<div><img src="Department_for_Education.png" alt="Logo", width="120", height = "71"></div>
              <br>
              <div><b>This is a new service - if you would like to provide feedback on this tool please contact Post16.STATISTICS@education.gov.uk</b></div>
              <br>
              </br>')
           )

         )

         )