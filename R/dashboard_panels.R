homepage_panel <- function() {
  tabPanel(
    "Homepage",
    gov_main_layout(
      gov_row(
        column(
          12,
          h1("Level 2 and 3 attainment by age 19: Local authority figures"),
          br(),
          br()
        ),
        
        ## Left panel -------------------------------------------------------
        
        column(
          12,
          div(
            div(
              class = "panel panel-info",
              div(
                class = "panel-heading",
                style = "color: white;font-size: 18px;font-style: bold; background-color: #1d70b8;",
                h2("Background")
              ),
              div(
                class = "panel-body",
                tags$div(
                  #title = "This section is useful if you want to understand how well different industries retain graduates.",
                  #h3("Introduction (h3)"),
                  #p("This app demonstrates the DfE Analytical Services R-Shiny data dashboard template."),
                  #p("You might want to add some brief introductory text here alongside some links to different tabs within your dashboard. Here's an example of a link working:"),
                  #p(actionLink("link_to_app_content_tab", "Dashboard panel")),
                  #p("You need to add an observeEvent() function to the server.R script for any link that navigates within your App.")
                  p("The purpose of this dashboard is to provide further insight into breakdowns included within our National Statistics release using data visualisation. It reports on attainment at level 2, level 2 with English and maths and level 3 by age 19 by pupil characteristics as collected at age 15. The data covers pupils in state sector schools at age 15."),
                    br(),
                    p(strong("Latest National Statistics")),
                    br(),
                    p("All of the data used within this dashboard has been published in the National Statistics release",
                    a("Statistics: 16 to 19 attainment",
                    href = "https://www.gov.uk/government/collections/statistics-attainment-at-19-years",
                    target="_blank"), "underlying data section and is also available for download via the data and methods tab."),
                    br(),
                    p(strong("Guidance and methodology")),
                    br(),
                    p("This dashboard shows breakdowns for the number and rate of level 2 and 3 attainment by age 19 at local authority level, including by free school meal (FSM) eligibility and special educational need (SEN).
                                               Further information, including definitions, is available in the data and methods tab in this dashboard and also in the technical document found on the main publication page."),
                    br(),
                    p(strong("Definitons")),
                    br(),
                    p("Key defintions relating to statistics used in this application can be found in the data and methods tab.")
                    )
                  ),
                )
            )
          )#,
        
        
        ## Right panel ------------------------------------------------------
        
        # column(
        #   0,
        #   div(
        #     div(
        #       class = "panel panel-info",
        #       div(
        #         class = "panel-heading",
        #         style = "color: white;font-size: 18px;font-style: bold; background-color: #1d70b8;",
        #         h2("Level 2 and 3 attainment overall")
        #       ),
              # div(
              #   class = "panel-body",
              #   h3("Context and purpose (h3)"),
              #   p("This app is the DfE Analytical Service's R-Shiny template demonstration app and is being developed to provide a coherent styling for DfE dashboards alongside some useful example componenets that teams can adapt for their own uses."),
              #   p("DfE teams using this template should avoid changing the styling and layout, keeping the header, footer and side navigation list formats."),
              #                   p("You might want to add some relevant background information for your users here. For example some useful links to your EES publication, data sources and other relevant resources."),
              #   h3("Guidance sources (h3)"),
              #   p("For example, here we'll add some of the key resources we draw on to guide styling and vizualisation...")
              # )
              # div(
              # class = "panel-body",
              #  p("Level 2 attainment by age 19, ", paste(first_year),  " to " , paste(latest_year)),
              #  br(),
              #  br(),
              #  radioButtons("bars_type", label=NULL, c("percentage", "number"), inline = TRUE),
              #  plotOutput("l2_bar", height ="8cm"),
              #  hr(),
              #  p("Level 3 attainment by age 19, " , paste(first_year),  " to " , paste(latest_year)),
              #  br(),
              #  radioButtons("bars_type2", label=NULL, c("percentage", "number"), inline = TRUE),
              #  plotOutput("l3_bar", height ="8cm")
               #),
            #)
          #)
        )
      )
    )
  

  
}

overall_panel <- function() {
  tabPanel(
    value = "dashboard",
    "Overall attainment",
    
    # Define UI for application that draws a histogram
    
    # Sidebar with a slider input for number of bins
    gov_main_layout(
      gov_row(
        column(
          width=12,
          h1("Level 2 and 3 attainment by age 19"),
        ),
        column(
          width=12,
          tabsetPanel(#id = "tabsetpanels",
                      tabPanel(
                        "Level 2",
                        fluidRow(
                          column(
                            width=12,
                            #h2("Level 2 attainment by age 19"),
                            h2("Level 2 attainment by age 19, ", paste(first_year),  " to " , paste(latest_year)),
                            br(),
                            br(),
                            radioButtons("bars_type", label=NULL, c("percentage", "number"), inline = TRUE),
                            plotOutput("l2_bar", height ="8cm"),
                            hr()
                            # p("Level 3 attainment by age 19, " , paste(first_year),  " to " , paste(latest_year)),
                            # br()
                            # radioButtons("bars_type2", label=NULL, c("percentage", "number"), inline = TRUE),
                            # plotOutput("l3_bar", height ="8cm")
                      ))),
                      tabPanel(
                        "Level 3",
                        fluidRow(
                          column(
                            width=12,
                            #h2("Level 2 attainment by age 19"),
                            h2("Level 3 attainment by age 19, ", paste(first_year),  " to " , paste(latest_year)),
                            radioButtons("bars_type2", label=NULL, c("percentage", "number"), inline = TRUE),
                            plotOutput("l3_bar", height ="8cm")
                          ))),
                      )))))
}


fsm_panel <- function() {
  tabPanel(
    value = "LA-FSM",
    "Local authority - FSM",

    # Define UI for application that draws a histogram

    # Sidebar with a slider input for number of bins
    gov_main_layout(
      gov_row(
        column(
          width=12,
        h1("Level 2 and 3 attainment by local authority and Free School Meal (FSM) status"),
        ),
        column(
          width=12,
          div(
            class = "well",
            style = "min-height: 100%; height: 100%; overflow-y: visible",
            fluidRow(
            column(
              width=6,
              selectizeInput( "select_cat",
                            label = "Choose a measure",
                            choices = list(
                            "Level 2" = 'l2', "Level 2 with English and maths" = 'l2em',
                            "Level 3" = 'l3')
                    )),
        column(
          width=6,
          selectizeInput("select2",
            label = "Choose an area",
            choices = sort(unique(la_plot_data_fsm$la_name))
        )
        ))
          )
        ),

        column(
          width=12,
               tabsetPanel(id = "tabsetpanels",
                 tabPanel(
                   "Chart",
                   fluidRow(
                     column(
                       width=12,
          h2("Attainment by Local authority and FSM by age 19"),
            br(),
            column(5,
            radioButtons("plot_type", "Which measure?", c("percentage", "number"), inline = TRUE)
             )),
             plotOutput("t1_chart"#, width = '23cm'
                        ),
             br(),
          
        column(width=12,
              tableOutput("t1_table"),
              br()
        )
          #valueBoxOutput("boxavgRevBal", width = 6),
          #valueBoxOutput("boxpcRevBal", width = 6),
          # box(
          #   width=12,
          # plotlyOutput("lineRevBal")))
        )),
        tabPanel("Data download",
         br(),
         downloadButton("downloadFSM", "Download"),
         br(),
         #DT::dataTableOutput("fsm_la_data")
        )))),
        hr(),
        HTML('<div><b>If you would like to provide feedback on this tool please contact Post16.STATISTICS@education.gov.uk</b></div>
                                   <br>
                                   </br>')))}
        # tabPanel(
        #   "Example panel 2",
        #   fluidRow(
        #     column(
        #       width=12,
        #   h2("Outputs 2 (h2)"),
        #   p("This is the standard paragraph style for adding guiding info around data content."),
        #   column(
        #     width=6,
        #     box(
        #       width=12,
        #       plotlyOutput("colBenchmark")
        #     )
          # ),
          # column(
          #   width=6,
          #   div(
          #     class = "well",
          #     style = "min-height: 100%; height: 100%; overflow-y: visible",
          #     fluidRow(
          #       column(
          #         width=12,
          #         selectizeInput("selectBenchLAs",
          #                        "Select benchamrk LAs",
          #                        choices = choicesLAs$area_name,
          #                        multiple=TRUE,
          #                        options = list(maxItems = 3)
          #         )
          #       )
          #         )
          #     ),
          #       dataTableOutput("tabBenchmark")
          # ))
sen_panel <- function() {
  tabPanel(
    value = "LA-SEN",
    "Local authority - SEN",
    
    # Define UI for application that draws a histogram
    
    # Sidebar with a slider input for number of bins
    gov_main_layout(
      gov_row(
        column(
          width=12,
          h1("Level 2 and 3 attainment by local authority and Special Educational Need (SEN) status"),
        ),
        column(
          width=12,
          div(
            class = "well",
            style = "min-height: 100%; height: 100%; overflow-y: visible",
            fluidRow(
              column(
                width=6,
                selectizeInput( "select_cat2",
                                label = "Choose a measure",
                                choices = list(
                                  "Level 2" = 'l2', "Level 2 with English and maths" = 'l2em',
                                  "Level 3" = 'l3'
                                ))),
                column(
                  width=6,
                  selectizeInput(
                    "select3",
                    label = "Choose an area",
                    choices = sort(unique(la_plot_data_sen$la_name))
                  )
                ))
            )
          ),
          
          column(
            width=12,
            tabsetPanel(id = "tabsetpanels",
                        tabPanel(
                          "Chart",
                          fluidRow(
                            column(
                              width=12,
                              h2("Attainment by Local authority and SEN by age 19"),
                              
                              br(),
                              column(5,
                                     radioButtons("plot_type2", "Which measure?", c("percentage", "number"), inline = TRUE)
                              )),
                          plotOutput("t2_chart"#, width = '23cm'
                                     ),
                          br(),
                          column(width=12,
                                 tableOutput("t2_table"),
                                 br()
                          )
                          #valueBoxOutput("boxavgRevBal", width = 6),
                          #valueBoxOutput("boxpcRevBal", width = 6),
                          # box(
                          #   width=12,
                          # plotlyOutput("lineRevBal")))
                        )),
                        tabPanel("Data download",
                                 br(),
                                 downloadButton("downloadSEN", "Download"),
                                 br(),
                                 DT::dataTableOutput("sen_la_data")
                        )))),
        hr(),
        HTML('<div><b>If you would like to provide feedback on this tool please contact Post16.STATISTICS@education.gov.uk</b></div>
                                   <br>
                                   </br>')))}