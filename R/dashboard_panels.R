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
                  # title = "This section is useful if you want to understand how well different industries retain graduates.",
                  # h3("Introduction (h3)"),
                  # p("This app demonstrates the DfE Analytical Services R-Shiny data dashboard template."),
                  # p("You might want to add some brief introductory text here alongside some links to different tabs within your dashboard. Here's an example of a link working:"),
                  # p(actionLink("link_to_app_content_tab", "Dashboard panel")),
                  # p("You need to add an observeEvent() function to the server.R script for any link that navigates within your App.")
                  p("The purpose of this dashboard is to provide further insight into breakdowns included within our National Statistics release using data visualisation. It reports on attainment at level 2, level 2 with English and maths and level 3 by age 19 by pupil characteristics. The data covers pupils in state sector schools at age 15."),
                  br(),
                  p(strong("Latest National Statistics")),
                  br(),
                  p(
                    "All of the data used within this dashboard has been published in the National Statistics release",
                    a("Level 2 and 3 attainment age 16 to 25",
                      href = "https://explore-education-statistics.service.gov.uk/find-statistics/level-2-and-3-attainment-by-young-people-aged-19",
                      target = "_blank"
                    ), "underlying data section and is also available for download via the data and methods tab."
                  ),
                  br(),
                  p(strong("Guidance and methodology")),
                  br(),
                  p(
                    "Further information about coverage, data sources etc. is available in the",
                    a("Level 2 and 3 attainment methodology",
                      href = "https://explore-education-statistics.service.gov.uk/methodology/level-2-and-3-attainment-by-young-people-aged-19-methodology",
                      target = "_blank"
                    ), "found on the main publication page."
                  ),
                  br(),
                  p(strong("Definitons")),
                  br(),
                  p(strong("Level 2:"), "5 GCSEs 9-4 or equivalent"),
                  p(strong("Level 2 with English and maths:"), "5 GCSEs 9-4 or equivalent including English and maths"),
                  p(strong("Level 3:"), "2 A levels or equivalent")
                )
              ),
            )
          )
        ) # ,


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
        # ),
        # )
        # )
      )
    )
  )
}

# overall_panel <- function() {
#   tabPanel(
#     value = "dashboard",
#     "Overall attainment",
#
#     # Define UI for application that draws a histogram
#
#     # Sidebar with a slider input for number of bins
#     gov_main_layout(
#       gov_row(
#         column(
#           width=12,
#           h1("Level 2 and 3 attainment by age 19"),
#         ),
#         column(
#           width=12,
#           tabsetPanel(#id = "tabsetpanels",
#                       tabPanel(
#                         "Level 2",
#                         gov_row(
#                           column(
#                             width=12,
#                             #h2("Level 2 attainment by age 19"),
#                             h2("Level 2 attainment by age 19, ", paste(first_year),  " to " , paste(latest_year)),
#                             br(),
#                             br(),
#                             radioButtons("bars_type", label=NULL, c("percentage", "number"), inline = TRUE),
#                             plotOutput("l2_bar", height ="8cm"),
#                             hr()
#                             # p("Level 3 attainment by age 19, " , paste(first_year),  " to " , paste(latest_year)),
#                             # br()
#                             # radioButtons("bars_type2", label=NULL, c("percentage", "number"), inline = TRUE),
#                             # plotOutput("l3_bar", height ="8cm")
#                       ))),
#                       tabPanel(
#                         "Level 3",
#                         gov_row(
#                           column(
#                             width=12,
#                             #h2("Level 2 attainment by age 19"),
#                             h2("Level 3 attainment by age 19, ", paste(first_year),  " to " , paste(latest_year)),
#                             radioButtons("bars_type2", label=NULL, c("percentage", "number"), inline = TRUE),
#                             plotOutput("l3_bar", height ="8cm")
#                           ))),
#                       )))))
# }


dashboard_panel <- function() {
  tabPanel(
    value = "LA & FSM",
    "Dashboard",

    # Define UI for application that draws a histogram

    # Sidebar with a slider input for number of bins
    gov_main_layout(
      gov_row(
        column(
          width = 12,
          tabsetPanel(
            id = "tabsetpanels_fsm",
            tabPanel(
              "Local authority & Free School Meal Status",
              gov_row(
                # new
                column(
                  width = 12,
                  h2("Level 2 and 3 attainment by local authority and Free School Meal (FSM) status"),
                  h3(strong(textOutput("la_title"))),
                  textOutput("la_sum_fsm"),
                  br(),
                  # h5(strong(textOutput("region_title"))),
                  textOutput("reg_sum_fsm"),
                  br(),
                  # h5(strong("National summary")),
                  textOutput("nat_sum_fsm"),
                  hr()
                ),
                column(
                  width = 12,
                  div(
                    class = "well",
                    style = "min-height: 100%; height: 100%; overflow-y: visible",
                    gov_row(
                      column(
                        width = 6,
                        selectizeInput("select_cat",
                          label = "Choose a measure",
                          choices = list(
                            "Level 2" = "Level 2", "Level 2 with English and maths" = "Level 2 with English & maths",
                            "Level 3" = "Level 3"
                          )
                        )
                      ),
                      column(
                        width = 6,
                        selectizeInput("select2",
                          label = "Choose an area",
                          choices = sort(unique(la_plot_data_fsm$la_name))
                        )
                      )
                    )
                  ),
                  valueBoxOutput("boxFSM_All"),
                  valueBoxOutput("boxFSM_El"),
                  valueBoxOutput("boxFSM_NotEl")
                ),
                column(
                  width = 12,
                  tabsetPanel(
                    id = "tabsetpanels_fsm_sub",
                    tabPanel(
                      "Chart",
                      gov_row(
                        column(
                          width = 12,
                          h2("Attainment by Local authority and FSM by age 19"),
                          # valueBoxOutput("box", width = 6),
                          br(),
                          # column(5,
                          radioButtons("plot_type", "Which measure?", c("percentage", "number"), inline = TRUE),
                          # ),
                          plotlyOutput("t1_chart"),
                          br(),

                          # column(width=12,
                          # tableOutput("t1_table"),
                          br()
                        )
                      )
                    ),
                    tabPanel(
                      "Data download",
                      gov_row(
                        br(),
                        downloadButton("downloadFSM", "Download"),
                        br(),
                        DT::dataTableOutput("fsm_la_data")
                      )
                    )
                  )
                ),
                column(
                  width = 12,
                  hr(),
                  br(),
                  HTML("<div><b>If you would like to provide feedback on this tool please contact Post16.STATISTICS@education.gov.uk</b></div>
                                   <br>
                                   </br>")
                )
              )
            ),
            tabPanel(
              "Local authority & Special Educational Need",
              gov_row(

                # new
                column(
                  width = 12,
                  h2("Level 2 and 3 attainment by local authority and Special Educational Need (SEN) status"),
                  h3(strong(textOutput("la_title2"))),
                  textOutput("la_sum_sen"),
                  br(),
                  # h5(strong(textOutput("region_title2"))),
                  textOutput("reg_sum_sen"),
                  br(),
                  # h5(strong("National summary")),
                  textOutput("nat_sum_sen"),
                  hr()
                ),
                column(
                  width = 12,
                  div(
                    class = "well",
                    style = "min-height: 100%; height: 100%; overflow-y: visible",
                    gov_row(
                      column(
                        width = 6,
                        selectizeInput("select_cat2",
                          label = "Choose a measure",
                          choices = list(
                            "Level 2" = "Level 2", "Level 2 with English and maths" = "Level 2 with English & maths",
                            "Level 3" = "Level 3"
                          )
                        )
                      ),
                      column(
                        width = 6,
                        selectizeInput(
                          "select3",
                          label = "Choose an area",
                          choices = sort(unique(la_plot_data_sen$la_name))
                        )
                      )
                    )
                  ),
                  valueBoxOutput("boxSEN_All", width = 3),
                  valueBoxOutput("boxSEN_No", width = 3),
                  valueBoxOutput("boxSEN_with", width = 3),
                  valueBoxOutput("boxSEN_without", width = 3)
                ),
                column(
                  width = 12,
                  tabsetPanel(
                    id = "tabsetpanels_sen",
                    tabPanel(
                      "Chart",
                      gov_row(
                        column(
                          width = 12,
                          h2("Attainment by Local authority and SEN by age 19"),
                          br(),
                          # column(5,
                          radioButtons("plot_type2", "Which measure?", c("percentage", "number"), inline = TRUE),
                          # )

                          plotlyOutput(
                            "t2_chart" # , width = '23cm'
                          ),
                          br(),
                          # column(width=12,
                          #        tableOutput("t2_table"),
                          br()
                        )
                      )
                    ),
                    tabPanel(
                      "Data download",
                      gov_row(
                        column(
                          width = 12,
                          br(),
                          downloadButton("downloadSEN", "Download"),
                          br(),
                          DT::dataTableOutput("sen_la_data")
                        )
                      )
                    )
                  )
                )
              ),
              hr(),
              HTML("<div><b>If you would like to provide feedback on this tool please contact Post16.STATISTICS@education.gov.uk</b></div>
                                   <br>
                                   </br>")
            )
          )
        )
      )
    )
  )
}
# tabPanel(
#   "Example panel 2",
#   gov_row(
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
#     gov_row(
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
    "LA & SEN",

    # Define UI for application that draws a histogram

    # Sidebar with a slider input for number of bins
    gov_main_layout(
      gov_row(
        column(
          width = 12,
          h1("Level 2 and 3 attainment by local authority and Special Educational Need (SEN) status"),
        ),
        # new
        column(
          width = 12,
          h3(strong(textOutput("la_title2"))),
          textOutput("la_sum_sen"),
          br(),
          # h5(strong(textOutput("region_title2"))),
          textOutput("reg_sum_sen"),
          br(),
          # h5(strong("National summary")),
          textOutput("nat_sum_sen"),
          hr()
        ),
        column(
          width = 12,
          div(
            class = "well",
            style = "min-height: 100%; height: 100%; overflow-y: visible",
            gov_row(
              column(
                width = 6,
                selectizeInput("select_cat2",
                  label = "Choose a measure",
                  choices = list(
                    "Level 2" = "Level 2", "Level 2 with English and maths" = "Level 2 with English & maths",
                    "Level 3" = "Level 3"
                  )
                )
              ),
              column(
                width = 6,
                selectizeInput(
                  "select3",
                  label = "Choose an area",
                  choices = sort(unique(la_plot_data_sen$la_name))
                )
              )
            )
          ),
          valueBoxOutput("boxSEN_All", width = 3),
          valueBoxOutput("boxSEN_No", width = 3),
          valueBoxOutput("boxSEN_with", width = 3),
          valueBoxOutput("boxSEN_without", width = 3)
        ),
        column(
          width = 12,
          tabsetPanel(
            id = "tabsetpanels_sen_sub",
            tabPanel(
              "Chart",
              gov_row(
                # column(
                # width=12,
                h2("Attainment by Local authority and SEN by age 19"),
                br(),
                # column(5,
                radioButtons("plot_type2", "Which measure?", c("percentage", "number"), inline = TRUE),
                # )

                plotlyOutput(
                  "t2_chart" # , width = '23cm'
                ),
                br(),
                # column(width=12,
                #        tableOutput("t2_table"),
                br()
              )
              # valueBoxOutput("boxavgRevBal", width = 6),
              # valueBoxOutput("boxpcRevBal", width = 6),
              # box(
              #   width=12,
              # plotlyOutput("lineRevBal")))
            ),
            tabPanel(
              "Data download",
              br(),
              downloadButton("downloadSEN", "Download"),
              br(),
              DT::dataTableOutput("sen_la_data")
            )
          )
        )
      ),
      hr(),
      HTML("<div><b>If you would like to provide feedback on this tool please contact Post16.STATISTICS@education.gov.uk</b></div>
                                   <br>
                                   </br>")
    )
  )
}
