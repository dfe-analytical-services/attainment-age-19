# ---------------------------------------------------------
# This is the ui file. 
# Use it to call elements created in your server file into the app, and define where they are placed.
# Also use this file to define inputs.
#
# Every UI file should contain:
# - A title for the app
# - A call to a CSS file to define the styling
# - An accessibility statement
# - Contact information   
#
# Other elements like charts, navigation bars etc. are completely up to you to decide what goes in.
# However, every element should meet accessibility requirements and user needs.
#
# This file uses a slider input, but other inputs are available like date selections, multiple choice dropdowns etc.
# Use the shiny cheatsheet to explore more options: https://shiny.rstudio.com/images/shiny-cheatsheet.pdf
# 
# Likewise, this template uses the navbar layout.
# We have used this as it meets accessibility requirements, but you are free to use another layout if it does too.
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# ---------------------------------------------------------


ui <- function(input, output, session) {
  fluidPage(
    title = tags$head(tags$link(rel="shortcut icon",
                                href="dfefavicon.png")),
    
    shinyjs::useShinyjs(),
    useShinydashboard(),
    tags$head(includeHTML(("google-analytics.html"))),
    tags$head(
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = "dfe_shiny_gov_style.css"
      )
    ),
    shinyGovstyle::header(
      main_text = "DfE",
      main_link = "https://www.gov.uk/government/organisations/department-for-education",
      secondary_text = "Level 2 and 3 attainment by age 19",
      logo = "images/DfE_logo.png"
    ),
    shinyGovstyle::banner(
      "beta banner",
      "beta",
      paste0(
        "This Dashboard is in beta phase and we are still reviewing performance and reliability. ",
        "In case of slowdown or connection issues due to high demand, we have produced two instances of this site which can be accessed at the following links: ",
        "<a href=", site_primary, " id='link_site_1'>Site 1</a> and ",
        "<a href=", site_overflow, " id='link_site_2'>Site 2</a>."
      )
    ),
    shiny::navlistPanel(
      "",
      id = "navlistPanel",
      widths = c(2, 8),
      well = FALSE,
      homepage_panel(),
      overall_panel(),
      fsm_panel(),
      sen_panel(),
      a11y_panel(),
      support_links()
    ),
    tags$script(
      src = "script.js"
    ),
    footer(full = TRUE)
  )
}
    
    
    
#     navbarPage("",
#       id = "navbar",
# 
#       # Homepage tab ============================================================
# 
#       tabPanel(
#         "Overview",
#         fluidPage(
#           fluidRow(
#             column(
#               12,
#               h1("Level 2 and 3 attainment by age 19: Local authority dashboard"),
#               br(),
#               
#             ),
# 
#             ## Left panel -------------------------------------------------------
# 
#             column(
#               5,
#               div(
#                 div(
#                   class = "panel panel-info",
#                   div(
#                     class = "panel-heading",
#                     style = "color: white;font-size: 12px;font-style: bold; background-color: #1d70b8;",
#                     h2("Information"),
#                     p("This tool is aimed at enabling users to further understand attainment by age 19 data.")
#                   ),
#                   div(
#                     class = "panel-body",
#                     tags$div(
#                       title = "Level 2 and 3 attainment by local authority and free school meal status",
#                       p(strong("Background")),
#                       br(),
#                       p("The purpose of this dashboard is to provide further insight into breakdowns included within our National Statistics release using data visualisation. It reports on attainment at level 2, level 2 with English and maths and level 3 by age 19 by pupil characteristics as collected at age 15. The data covers pupils in state sector schools at age 15."),
#                       br(),
#                       p(strong("Latest National Statistics")),
#                       br(),
#                       p("All of the data used within this dashboard has been published in the National Statistics release",
#                          a("Statistics: 16 to 19 attainment", 
#                            href = "https://www.gov.uk/government/collections/statistics-attainment-at-19-years",
#                            target="_blank"), "underlying data section and is also available for download via the data and methods tab."),
#                       br(),
#                       p(strong("Guidance and methodology")),
#                       br(),
#                       p("This dashboard shows breakdowns for the number and rate of level 2 and 3 attainment by age 19 at local authority level, including by free school meal (FSM) eligibility and special educational need (SEN).  
#                              Further information, including definitions, is available in the data and methods tab in this dashboard and also in the technical document found on the main publication page."),
#                       br(),
#                       p(strong("Definitons")),
#                       br(),
#                       p("Key defintions relating to statistics used in this application can be found in the data and methods tab.")
#                     )
#                     ),
#                     br()
#                   )
#                 )
#               ),
#             
# 
#             ## Right panel------------------------------------------------------
# 
#             column(
#               7,
#               div(
#                 div(
#                   class = "panel panel-info",
#                   div(
#                     class = "panel-heading",
#                     style = "color: white;font-size: 12px;font-style: bold; background-color: #1d70b8;",
#                     h2("Level 2 and 3 attainment overall"),
#                     br()),
#                     div(
#                       class = "panel-body",
#                     strong("Level 2 attainment by age 19, ", paste(first_year),  " to " , paste(latest_year)), 
#                     br(),
#                     br(),
#                     #em("Young people in state sector at 15"),
#                     radioButtons("bars_type", label=NULL, c("percentage", "number"), inline = TRUE),
#                     plotOutput("l2_bar", height ="8cm"),
#                     hr(),
#                     strong("Level 3 attainment by age 19, " , paste(first_year),  " to " , paste(latest_year)), 
#                     br(),
#                     #em("Young people in state sector at 15"),
#                     radioButtons("bars_type2", label=NULL, c("percentage", "number"), inline = TRUE),
#                     plotOutput("l3_bar", height ="8cm")
#                   ),
#                   div(
#                     class = "panel-body",
#                   )
#                 )
#               )
#             )
#           )
#         )
#       ),
#       tabPanel(
#         #value = "la_fsm",
#         "Local authority - FSM",
# 
#         # Define UI for application that draws a histogram
# 
#         # Sidebar with a slider input for number of bins
#         sidebarLayout(
#           sidebarPanel(
#             h4(strong("Local Authority (LA) level attainment by 19 - FSM")),
#             br(),
#             h5(strong("Pick a local authority")),
#             selectInput(
#               "select2",
#               label = NULL,
#               choices = sort(unique(la_plot_data_fsm$la_name)),
#               selected = 'Darlington'
#             ),
#             h5(strong("Pick a measure")),
#             selectInput(
#               "select_cat",
#               label = NULL,
#               choices = list(
#                 "Level 2" = 'l2',
#                 "Level 2 with English and maths" = 'l2em',
#                 "Level 3" = 'l3'
#               ),
#               selected = 'l2'
#             ),
#             h5(strong(textOutput("la_title"))),
#             textOutput("la_sum_fsm"),
#             hr(),
#             h5(strong(textOutput("region_title"))),
#             textOutput("reg_sum_fsm"),
#             hr(),
#             h5(strong("National summary")),
#             textOutput("nat_sum_fsm"),
#             hr()
#           ),
#           mainPanel(tabsetPanel(
#             tabPanel("Plot",
#                      br(),
#                      fluidRow(column(9,
#                                      br(),
#                                      column(3,
#                                             radioButtons("plot_type", "Which measure?", c("percentage", "number"), inline = TRUE)
#                                      ))),
#                      plotOutput("t1_chart", width = '23cm'),
#                      br(),
#                      tableOutput("t1_table"),
#                      br()
#             ),
#             tabPanel(
#               "Data download",
#               br(),
#               downloadButton("downloadFSM", "Download"),
#               br(),
#               DT::dataTableOutput("fsm_la_data")
#             )
#             
#           ))),
#         hr(),
#         # HTML('<div><img src="Department_for_Education.png" alt="Logo", width="120", height = "71"></div>
#         #                    <br>
#         #                    <div><b>If you would like to provide feedback on this tool please contact Post16.STATISTICS@education.gov.uk</b></div>
#         #                    <br>
#         #                    </br>')),
#         HTML('<div><b>If you would like to provide feedback on this tool please contact Post16.STATISTICS@education.gov.uk</b></div>
#                            <br>
#                            </br>')),
#       # 3. LA SEN Tab  ---- will need to update national reference years and figures
#       
#       tabPanel("LA trends - SEN",
#                sidebarLayout(
#                  sidebarPanel(
#                    h4(strong("Local Authority (LA) level attainment by 19 - Special Educational Need (SEN)")),
#                    br(),
#                    h5(strong("Pick a local authority")),
#                    selectInput(
#                      "select3",
#                      label = NULL,
#                      choices = sort(unique(la_plot_data_sen$la_name)),
#                      selected = 'Darlington'
#                    ),
#                    h5(strong("Pick a measure")),
#                    selectInput( 
#                      "select_cat2",
#                      label = NULL,
#                      choices = list(
#                        "Level 2" = 'l2',
#                        "Level 2 with English and maths" = 'l2em',
#                        "Level 3" = 'l3'
#                      ),
#                      selected = 'l2'
#                    ),
#                    h5(strong(textOutput("la_title2"))),
#                    textOutput("la_sum_sen"),
#                    hr(),
#                    h5(strong(textOutput("region_title2"))),
#                    textOutput("reg_sum_sen"),
#                    hr(),
#                    h5(strong("National summary")),
#                    textOutput("nat_sum_sen"),
#                    hr()
#                  ),
#                  mainPanel(tabsetPanel(
#                    tabPanel("Plot",
#                             br(),
#                             fluidRow(column(9,
#                                             br(),
#                                             column(3,
#                                                    radioButtons("plot_type2", "Which measure?", c("percentage", "number"), inline = TRUE)
#                                             ))),
#                             plotOutput("t2_chart", width = '23cm'),
#                             br(),
#                             tableOutput("t2_table"),
#                             br()
#                    ),
#                    tabPanel(
#                      "Data download",
#                      br(),
#                      downloadButton("downloadSEN", "Download"),
#                      br(),
#                      DT::dataTableOutput("sen_la_data")
#                    )
#                  ))),
#                hr(),
#                HTML('<div><img src="Department_for_Education.png" alt="Logo", width="120", height = "71"></div>
#                            <br>
#                            <div><b>If you would like to provide feedback on this tool please contact Post16.STATISTICS@education.gov.uk</b></div>
#                            <br>
#                            </br>')),
#       
#       # 4. Map----
#       #***Action update the year reference in line 127 below.
#       # tabPanel("Map",
#       #          sidebarLayout(
#       #            sidebarPanel(
#       #              h4(strong("Mapping level 2 and level 3 attainment by 19 rates")),
#       #              em("Young people in state sector at 15, ", paste(latest_year)),
#       #              h5(strong("Pick a measure")),
#       #              selectInput(
#       #                "select_map",
#       #                label = NULL,
#       #                choices = list("Level 2 by 19" = 'l2',
#       #                               "Level 2 with English and maths by 19" = 'l2EM',
#       #                               "Level 3 by 19" = 'l3',
#       #                               "Level 2 English and maths by 19, of those below at 16" = 'l2em19bl16'),
#       #                selected = 'l2'
#       #              ),
#       #              width = 3,
#       #              hr(),
#       #              h5(strong("Instructions")),
#       #              "From the dropdown menu above, please select the attainment rate of interest. Then hover over your selected local authority to find out more information about attainment data in that area.",
#       #              br(),
#       #              br(),
#       #              "The darkest shaded areas are in the bottom 20% of all local authorities for the selected attainment rate and the lightest shaded areas in the top 20% for the selected attainment rate."
#       #            ),
#       #            mainPanel(
#       #              leafletOutput("map", width = '25cm', height = '25cm') %>%
#       #                #spinner to appear while chart is loading
#       #                withSpinner(
#       #                  color = "grey",
#       #                  type = 5,
#       #                  size = getOption("spinner.size", default = 0.4)
#       #                )
#       #            )
#       #          ),
#       #          hr(),
#       #          HTML('<div><img src="Department_for_Education.png" alt="Logo", width="120", height = "71"></div>
#       #                      <br>
#       #                      <div><b>If you would like to provide feedback on this tool please contact Post16.STATISTICS@education.gov.uk</b></div>
#       #                      <br>
#       #                      </br>')
#       # ),
#       # 
#       
#       # 5. Data sources and methodology tab ----
#       # Will need to update any year references and hyperlink in the text below. 
#       
#       tabPanel("Data and methods",
#                h4(strong("Data sources")),
#                "This tool uses open data published alongside the 'Level 2 and 3 attainment by young people aged 19 in '", paste(latest_year) , " 
#                       National Statistics release, available ",
#                tags$a(href="https://www.gov.uk/government/collections/statistics-attainment-at-19-years", "here."),
#                br(),
#                br(),
#                "The local authority figures in this tool show attainment at level 2, level 2 with English and maths and level 3 by age 19 
#                       by pupil characteristics collected at age 15. They cover pupils in state sector schools at age 15.",
#                "Figures are also included on progression rates in level 2 English and maths, that is the proportion of those not achieving level 2 by age 16 
#                       who go on to achieve level 2 by age 19.",
#                br(),
#                br(),
#                "The following underlying dataset contains all the figures included within this tool.",
#                br(),
#                br(),
#                #h5(strong("la_underlying_data")),
#                h5(strong("Local authority underlying data")),
#                #br(),
#                downloadButton("downloadmain_ud", "Download"),
#                br(),
#                br(),
#                h4(strong("Methodology")),
#                "i) Numerators are based upon the number of young people in the state sector at academic age 15 who reached level 2/3 or level 2 with English and maths by 19.",
#                br(),
#                "ii) Denominators are based upon the number that were in the mainstream state sector at academic age 15.",
#                br(),
#                "iii) Pupils attending independent schools, PRUs and alternative provision at academic age 15 are excluded from these figures.",
#                br(),
#                "iv) The figures are calculated for each local authority based on where the pupil was learning at academic age 15.",
#                br(),
#                "v) Regional figures are aggregated from local authority figures and are directly comparable with national estimates in tables 6-24, but not with tables 1-5.",																	
#                br(),
#                br(),
#                h4(strong("Notes")),
#                "a) These local authority figures are comparable with the national figures shown in tables 6 to 15 within the publication.",
#                br(),
#                "b) These estimates include pupils in the state sector at academic age 15.",
#                br(),
#                "c) The characteristics are assigned according to the information in the School Census at academic age 15.",
#                br(),
#                "d) Note that for the purposes of these calculations the LA of a school is based on the administrative LA rather than its postcode (this will only differ in a very small number of cases).",
#                br(),
#                "e) Only reporting on pupils in the state sector at 15 can have a bearing on figures by local authority where a large number of pupils attended independent schools at academic age 15.",
#                br(),
#                "f) Attainment by FSM and SEN can also be variable from year to year, particularly for small local authorities, where the size of the FSM/SEN groups may be relatively small.",
#                br(),
#                "g) A young person aged 19 at the end of academic year 2020/21 is referred to as '19 in 21' in these figures.",
#                br(),
#                "h) These are final figures but historical figures are subject to minor alterations each year.",	
#                hr(),
#                HTML('<div><img src="Department_for_Education.png" alt="Logo", width="120", height = "71"></div>
#                            <br>
#                            <div><b>If you would like to provide feedback on this tool please contact Post16.STATISTICS@education.gov.uk</b></div>
#                            <br>
#                            </br>')
#       ),
#   
#       # Create the accessibility statement-----------------
#       tabPanel(
#         "Accessibility",
#         h2("Accessibility statement"),
#         br("This accessibility statement applies to the **application name**.
#             This application is run by the Department for Education. We want as many people as possible to be able to use this application,
#             and have actively developed this application with accessibilty in mind."),
#         h3("WCAG 2.1 compliance"),
#         br("We follow the reccomendations of the ", a(href = "https://www.w3.org/TR/WCAG21/", "WCAG 2.1 requirements. ", onclick = "ga('send', 'event', 'click', 'link', 'IKnow', 1)"), "This application has been checked using the ", a(href = "https://github.com/ewenme/shinya11y", "Shinya11y tool "), ", which did not detect accessibility issues.
#              This application also fully passes the accessibility audits checked by the ", a(href = "https://developers.google.com/web/tools/lighthouse", "Google Developer Lighthouse tool"), ". This means that this application:"),
#         tags$div(tags$ul(
#           tags$li("uses colours that have sufficient contrast"),
#           tags$li("allows you to zoom in up to 300% without the text spilling off the screen"),
#           tags$li("has its performance regularly monitored, with a team working on any feedback to improve accessibility for all users")
#         )),
#         h3("Limitations"),
#         br("We recognise that there are still potential issues with accessibility in this application, but we will continue
#              to review updates to technology available to us to keep improving accessibility for all of our users. For example, these
#             are known issues that we will continue to monitor and improve:"),
#         tags$div(tags$ul(
#           tags$li("List"),
#           tags$li("known"),
#           tags$li("limitations, e.g."),
#           tags$li("Alternative text in interactive charts is limited to titles and could be more descriptive (although this data is available in csv format)")
#         )),
#         h3("Feedback"),
#         br(
#           "If you have any feedback on how we could further improve the accessibility of this application, please contact us at",
#           a(href = "mailto:email@education.gov.uk", "email@education.gov.uk")
#         )
#       ), # End of accessibility tab
#       # Support links ===========================================================
# 
#       tabPanel(
#         "Support and feedback",
#         support_links() # defined in R/supporting_links.R
#       ),
#       # Footer ====================================================================
# 
#       shinyGovstyle::footer(TRUE)
#   )# End of navBarPage
#   )# End of fluid page
# }
#     
