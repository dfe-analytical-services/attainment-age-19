# ---------------------------------------------------------
# This is the server file.
# Use it to create interactive elements like tables, charts and text for your app.
#
# Anything you create in the server file won't appear in your app until you call it in the UI file.
# This server script gives an example of a plot and value box that updates on slider input.
# There are many other elements you can add in too, and you can play around with their reactivity.
# The "outputs" section of the shiny cheatsheet has a few examples of render calls you can use:
# https://shiny.rstudio.com/images/shiny-cheatsheet.pdf
#
#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# ---------------------------------------------------------
source("codefile_shiny.R")
 

server <- function(input, output, session) {
  # 1. Front page ----
  
  output$l2_bar <- renderPlot({
    if (input$bars_type == "number") {
      national_bars_num('l2')
    } else if (input$bars_type == "percentage") {
      national_bars_rate('l2')
    }
  })
  
  output$l3_bar <- renderPlot({
    if (input$bars_type2 == "number") {
      national_bars_num('l3')
    } else if (input$bars_type2 == "percentage") {
      national_bars_rate('l3')
    }
  })

  # Loading screen ---------------------------------------------------------------------------
  # Call initial loading screen

  hide(id = "loading-content", anim = TRUE, animType = "fade")
  show("app-content")

  # Simple server stuff goes here ------------------------------------------------------------
  
  
 
  # # Define server logic required to draw a histogram
  # output$distPlot <- renderPlot({
  # 
  #   # generate bins based on input$bins from ui.R
  #   x <- faithful[, 2]
  #   bins <- seq(min(x), max(x), length.out = input$bins + 1)
  # 
  #   # draw the histogram with the specified number of bins
  #   hist(x, breaks = bins, col = "darkgray", border = "white")
  # })
  # 
  # # Define server logic to create a box
  # 
  # output$box_info <- renderValueBox({
  # 
  #   # Put value into box to plug into app
  #   shinydashboard::valueBox(
  #     # take input number
  #     input$bins,
  #     # add subtitle to explain what it's hsowing
  #     paste0("Number that user has inputted"),
  #     color = "blue"
  #   )
  # })
  # 
  # observeEvent(input$link_to_app_content_tab, {
  #   updateTabsetPanel(session, "navbar", selected = "app_content")
  # })
  # LA trends ---- FSM
  #number and rate plot depending on what option is selected.
  output$t1_chart <- renderPlotly({
    if (input$plot_type == "number") {
      la_plot_num_fsm(input$select2, input$select_cat)
    } else if (input$plot_type == "percentage") {
      la_plot_rate_fsm(input$select2, input$select_cat)
    }
  })
  
  #number or rate table depending on what option is selected 
  output$t1_table <- renderTable({
    if (input$plot_type == "number") {
      la_table_num_fsm(input$select2, input$select_cat)
    } else if (input$plot_type == "percentage") {
      la_table_rate_fsm(input$select2, input$select_cat)
    }
  },
  bordered = TRUE,spacing = 'm',align = 'c')
  
  #new
  # Define server logic to create a box
  
  # output$box <- renderValueBox({
  #   
  #   # Put value into box to plug into app
  #   valueBox(
  #     
  #     # take input number
  #     paste0(format((national_bars_rate() %>% 
  #                     
  #           filter(
  #       year == max(year),
  #       category == input$select_cat,
  #       la_name == input$select2
  #     ))
  #     )),
  #     # add subtitle to explain what it's showing
  #     paste0("This is the latest value for the selected inputs"),
  #     color = "blue"
  #   )
  # })
  #end of new
  
  # LA trends ---- SEN
  #number and rate plot depending on what option is selected.
  output$t2_chart <- renderPlot({
    if (input$plot_type2 == "number") {
      la_plot_num_sen(input$select3, input$select_cat2)
    } else if (input$plot_type2 == "percentage") {
      la_plot_rate_sen(input$select3, input$select_cat2)
    }
  })
  
  #number or rate table depending on what option is selected 
  output$t2_table <- renderTable({
    if (input$plot_type2 == "number") {
      la_table_num_sen(input$select3, input$select_cat2)
    } else if (input$plot_type2 == "percentage") {
      la_table_rate_sen(input$select3, input$select_cat2)
    }
  },
  bordered = TRUE,spacing = 'm',align = 'c')
  
  
  #LA summary text - FSM.
  # Gives the latest year changes depending on what measure is selected.
  output$la_title <- renderText({paste(input$select2," summary")})
  
  output$la_sum_fsm <- renderText({
    if (TRUE %in% (any(la_table_num_fsm(input$select2, input$select_cat)[,2:max(ncol(la_table_num_fsm(input$select2, input$select_cat)))] == 'c') | 
                   la_table_num_fsm(input$select2, input$select_cat)[,2:max(ncol(la_table_num_fsm(input$select2, input$select_cat)))] == 'c')){
      paste("Data for the ", input$select2, " has been supressed due to risk of disclosure due to small cohorts.")
    }else {
      if (input$select_cat == "l2") {
        
        
        paste("The percentage achieving level 2 by 19 in ",input$select3," ",change_ed(round(as.numeric(la_l2_rate(input$select2,last_year)),1),round(as.numeric(la_l2_rate(input$select2,latest_year)),1)), 
              "",round(as.numeric(la_l2_rate(input$select2,last_year)),1),
              "% in ",last_year, " to ",round(as.numeric(la_l2_rate(input$select2,latest_year)),1), "% in",latest_year,"."
                        
          
          
          # "The percentage achieving level 2 by 19 in ",input$select2," ",change_ed(round(as.numeric(la_l2_rate(input$select2,last_year)),1),round(as.numeric(la_l2_rate(input$select2,latest_year)),1)), 
          #     " ",round(as.numeric(la_l2_rate(input$select2,last_year)),1),
          #     " per cent in ",last_year, " to ",round(as.numeric(la_l2_rate(input$select2,latest_year)),1), " per cent in ",latest_year,". 
          #     
          #     The percentage of free school meal pupils achieving level 2 by 19 ",change_ed(round(as.numeric(la_l2_rate_fsm(input$select2,last_year)),1),round(as.numeric(la_l2_rate_fsm(input$select2,latest_year)),1)), 
          #     " ",round(as.numeric(la_l2_rate_fsm(input$select2,last_year)),1),
          #     " per cent in ",last_year, " to ",round(as.numeric(la_l2_rate_fsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
          #     
          #     The percentage of non free school meal pupils achieving level 2 by 19 ",change_ed(round(as.numeric(la_l2_rate_nonfsm(input$select2,last_year)),1),round(as.numeric(la_l2_rate_nonfsm(input$select2,latest_year)),1)), 
          #     " ",round(as.numeric(la_l2_rate_nonfsm(input$select2,last_year)),1),
          #     " per cent in ",last_year, " to ",round(as.numeric(la_l2_rate_nonfsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
              )}
      
      else if (input$select_cat == "l2em") {
        paste("The percentage achieving level 2 with English and maths by 19 in ",input$select2," ",change_ed(round(as.numeric(la_l2em_rate(input$select2,last_year)),1),round(as.numeric(la_l2em_rate(input$select2,latest_year)),1)), 
              "",round(as.numeric(la_l2em_rate(input$select2,last_year)),1),
              "% in ",last_year, " to ",round(as.numeric(la_l2em_rate(input$select2,latest_year)),1), "% in",latest_year,"."
              #
          
          
          
          # "The percentage achieving level 2 with English and maths by 19 in ",input$select2," ",change_ed(round(as.numeric(la_l2em_rate(input$select2,last_year)),1),round(as.numeric(la_l2em_rate(input$select2,latest_year)),1)),
          #     "  ",round(as.numeric(la_l2em_rate(input$select2,last_year)),1),
          #     " per cent in ",last_year, " to ",round(as.numeric(la_l2em_rate(input$select2,latest_year)),1), " per cent in ",latest_year,".
          #   
          #   The percentage of free school meal pupils achieving level 2 with English and maths by 19 ",change_ed(round(as.numeric(la_l2em_rate_fsm(input$select2,last_year)),1),round(as.numeric(la_l2em_rate_fsm(input$select2,latest_year)),1)),
          #     "  ",round(as.numeric(la_l2em_rate_fsm(input$select2,last_year)),1),
          #     " per cent in ",last_year, " to ",round(as.numeric(la_l2em_rate_fsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
          #   
          #   The percentage of non free school meal pupils achieving level 2 with English and maths by 19 ",change_ed(round(as.numeric(la_l2em_rate_nonfsm(input$select2,last_year)),1),round(as.numeric(la_l2em_rate_nonfsm(input$select2,latest_year)),1)),
          #     "  ",round(as.numeric(la_l2em_rate_nonfsm(input$select2,last_year)),1),
          #     " per cent in ",last_year, " to ",round(as.numeric(la_l2em_rate_nonfsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
           )}
      
      else if (input$select_cat == "l3") {
        paste("The percentage achieving level 3 by 19 in ",input$select3," ",change_ed(round(as.numeric(la_l3_rate(input$select2,last_year)),1),round(as.numeric(la_l3_rate(input$select2,latest_year)),1)), 
              "",round(as.numeric(la_l3_rate(input$select2,last_year)),1),
              "% in ",last_year, " to ",round(as.numeric(la_l3_rate(input$select2,latest_year)),1), "% in",latest_year,"."
              
              #
          
          # "The percentage achieving level 3 by 19 in ",input$select2," ",change_ed(round(as.numeric(la_l3_rate(input$select2,last_year)),1),round(as.numeric(la_l3_rate(input$select2,latest_year)),1)),
          #     " ",round(as.numeric(la_l3_rate(input$select2,last_year)),1),
          #     " per cent in ",last_year, " to ",round(as.numeric(la_l3_rate(input$select2,latest_year)),1), " per cent in ",latest_year,".
          #   
          #   The percentage of free school meal pupils achieving level 3 by 19 ",change_ed(round(as.numeric(la_l3_rate_fsm(input$select2,last_year)),1),round(as.numeric(la_l3_rate_fsm(input$select2,latest_year)),1)),
          #     " ",round(as.numeric(la_l3_rate_fsm(input$select2,last_year)),1),
          #     " per cent in ",last_year, " to ",round(as.numeric(la_l3_rate_fsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
          #   
          #   The percentage of non free school meal pupils achieving level 3 by 19 ",change_ed(round(as.numeric(la_l3_rate_nonfsm(input$select2,last_year)),1),round(as.numeric(la_l3_rate_nonfsm(input$select2,latest_year)),1)),
          #     " ",round(as.numeric(la_l3_rate_nonfsm(input$select2,last_year)),1),
          #     " per cent in ",last_year, " to ",round(as.numeric(la_l3_rate_nonfsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
            )}
    }
  })
  
  
  #LA summary text - SEN.
  # Gives the latest year changes depending on what measure is selected.
  output$la_title2 <- renderText({paste(input$select3," summary")})
  
  # output$la_sum_sen <- renderText({
  #   
  #   if (TRUE %in% (any(la_table_num_sen(input$select3, input$select_cat2)[,2:max(ncol(la_table_num_sen(input$select3, input$select_cat2)))] == 'c') | 
  #                  la_table_rate_sen(input$select3, input$select_cat2)[,2:max(ncol(la_table_num_sen(input$select3, input$select_cat2)))] == 'c')){
  #     paste("Data for the ", input$select3, " has been supressed due to risk of disclosure due to small cohorts.")
  #   }else {
  #     if (input$select_cat2 == "l2") {
  #       paste("The percentage achieving level 2 by 19 in ",input$select3," ",change_ed(round(as.numeric(la_l2_rate2(input$select3,last_year)),1),round(as.numeric(la_l2_rate2(input$select3,latest_year)),1)), 
  #             " ",round(as.numeric(la_l2_rate2(input$select3,last_year)),1),
  #             " per cent in ",last_year, " to ",round(as.numeric(la_l2_rate2(input$select3,latest_year)),1), " per cent in ",latest_year,".
  #           
  #           The percentage of pupils with a statement of SEN or Education Health Care (EHC) plan achieving level 2 by 19 ",change_ed(round(as.numeric(la_l2_rate2_sen_with(input$select3,last_year)),1),round(as.numeric(la_l2_rate2_sen_with(input$select3,latest_year)),1)), 
  #             " ",round(as.numeric(la_l2_rate2_sen_with(input$select3,last_year)),1),
  #             " per cent in ",last_year, " to ",round(as.numeric(la_l2_rate2_sen_with(input$select3,latest_year)),1), " per cent in ",latest_year,".
  #           
  #           The percentage of pupils with no identified SEN achieving level 2 by 19 ",change_ed(round(as.numeric(la_l2_rate2_nosen(input$select3,last_year)),1),round(as.numeric(la_l2_rate2_nosen(input$select3,latest_year)),1)), 
  #             " ",round(as.numeric(la_l2_rate2_nosen(input$select3,last_year)),1),
  #             " per cent in ",last_year, " to ",round(as.numeric(la_l2_rate2_nosen(input$select3,latest_year)),1), " per cent in ",latest_year,".
  #           ")}
  #new
  output$la_sum_sen <- renderText({
    
    if (TRUE %in% (any(la_table_num_sen(input$select3, input$select_cat2)[,2:max(ncol(la_table_num_sen(input$select3, input$select_cat2)))] == 'c') | 
                   la_table_rate_sen(input$select3, input$select_cat2)[,2:max(ncol(la_table_num_sen(input$select3, input$select_cat2)))] == 'c')){
      paste("Data for the ", input$select3, " has been supressed due to risk of disclosure due to small cohorts.")
    }else {
      if (input$select_cat2 == "l2") {
        paste("The percentage achieving level 2 by 19 in ",input$select3," ",change_ed(round(as.numeric(la_l2_rate2(input$select3,last_year)),1),round(as.numeric(la_l2_rate2(input$select3,latest_year)),1)), 
              "",round(as.numeric(la_l2_rate2(input$select3,last_year)),1),
              "% in ",last_year, " to ",round(as.numeric(la_l2_rate2(input$select3,latest_year)),1), "% in",latest_year,"."
   #          "For those with a statement of SEN or Education Health Care (EHC) plan, "
   #          ,round(as.numeric(la_l2_rate2_sen_with(input$select3,latest_year)),1)
   #          , "% achieved level 2 by 19 in ",latest_year," compared with  "
   #          ,round(as.numeric(la_l2_rate2_nosen(input$select3,latest_year)),1)
   #          , "% of those with no identified SEN.",
   #          "In comparison, in the ", str_sub(region_name2(input$select3),1,25),"region,"
   #          ,round(as.numeric(reg_l2_rate2_sen_with(input$select3,latest_year)),1)
   #          , "% of those with a statement of SEN or Education Health Care (EHC) plan achieved level 2 by 19 ("
   # ,round(as.numeric(nat_l2_rate2_sen_with(latest_year)),1), 
   # "% nationally) compared to", 
   # round(as.numeric(reg_l2_rate2_nosen(input$select3,latest_year)),1), 
   # "% of those with no identified SEN ("
   # ,round(as.numeric(nat_l2_rate2_nosen(latest_year)),1), 
   # "% nationally).         
              
              
              )}
  
  # output$reg_sum_sen <- renderText({
  # if (input$select_cat2 == "l2") {paste("In comparison, in the ", str_sub(region_name2(input$select3),1,25),"region",
  #                                             
      #end of new
  
      
      else if (input$select_cat2 == "l2em") {
        paste("The percentage achieving level 2 with English and maths by 19 in ",input$select3," ",change_ed(round(as.numeric(la_l2em_rate2(input$select3,last_year)),1),round(as.numeric(la_l2em_rate2(input$select3,latest_year)),1)), 
              "",round(as.numeric(la_l2em_rate2(input$select3,last_year)),1),
              "% in ",last_year, " to ",round(as.numeric(la_l2em_rate2(input$select3,latest_year)),1), "% in",latest_year,"."
            # The percentage of pupils with a statement of SEN or Education Health Care (EHC) plan achieving level 2 with English and maths by 19 ",change_ed(round(as.numeric(la_l2em_rate2_sen_with(input$select3,last_year)),1),round(as.numeric(la_l2em_rate2_sen_with(input$select3,latest_year)),1)),
            #   "  ",round(as.numeric(la_l2em_rate2_sen_with(input$select3,last_year)),1),
            #   " per cent in ",last_year, " to ",round(as.numeric(la_l2em_rate2_sen_with(input$select3,latest_year)),1), " per cent in ",latest_year,".
            # 
            # The percentage of pupils with no identified SEN achieving level 2 with English and maths by 19 ",change_ed(round(as.numeric(la_l2em_rate2_nosen(input$select3,last_year)),1),round(as.numeric(la_l2em_rate2_nosen(input$select3,latest_year)),1)),
            #   "  ",round(as.numeric(la_l2em_rate2_nosen(input$select3,last_year)),1),
            #   " per cent in ",last_year, " to ",round(as.numeric(la_l2em_rate2_nosen(input$select3,latest_year)),1), " per cent in ",latest_year,".
            )}
      
      else if (input$select_cat2 == "l3") {
        paste("The percentage achieving level 3 by 19 in ",input$select3," ",change_ed(round(as.numeric(la_l3_rate2(input$select3,last_year)),1),round(as.numeric(la_l3_rate2(input$select3,latest_year)),1)), 
              "",round(as.numeric(la_l3_rate2(input$select3,last_year)),1),
              "% in ",last_year, " to ",round(as.numeric(la_l3_rate2(input$select3,latest_year)),1), "% in",latest_year,"."
          
            # The percentage of pupils with a statement of SEN or Education Health Care (EHC) plan achieving level 3 by 19 ",change_ed(round(as.numeric(la_l3_rate2_sen_with(input$select3,last_year)),1),round(as.numeric(la_l3_rate2_sen_with(input$select3,latest_year)),1)),
            #   " ",round(as.numeric(la_l3_rate2_sen_with(input$select3,last_year)),1),
            #   " per cent in ",last_year, " to ",round(as.numeric(la_l3_rate2_sen_with(input$select3,latest_year)),1), " per cent in ",latest_year,".
            # 
            # The percentage of pupils with no identified SEN achieving level 3 by 19 ",change_ed(round(as.numeric(la_l3_rate2_nosen(input$select3,last_year)),1),round(as.numeric(la_l3_rate2_nosen(input$select3,latest_year)),1)),
            #   " ",round(as.numeric(la_l3_rate2_nosen(input$select3,last_year)),1),
            #   " per cent in ",last_year, " to ",round(as.numeric(la_l3_rate2_nosen(input$select3,latest_year)),1), " per cent in ",latest_year,".
            )}
    }
  })
  
  #regional text - FSM
  output$region_title <- renderText({paste(str_sub(region_name(input$select2),1,25)," region summary")})
  
  output$reg_sum_fsm <- renderText({
    if (input$select_cat == "l2") {paste("For those receiving free school meals, "
                                         ,round(as.numeric(la_l2_rate_fsm(input$select2,latest_year)),1)
                                         , "% achieved level 2 by 19 in ",latest_year," compared with  "
                                         ,round(as.numeric(la_l2_rate_nonfsm(input$select2,latest_year)),1)
                                         , "% of those not receiving free school meals."
      
      
      
      # "The percentage achieving level 2 by 19 in the ", str_sub(region_name(input$select2),1,25)," region",
      #                                    change_ed(reg_l2_rate(input$select2,last_year),reg_l2_rate(input$select2,latest_year)),
      #                                    round(as.numeric(reg_l2_rate(input$select2, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2_rate(input$select2,latest_year)),1), " per cent in ",latest_year,".
      #                                    
      #                                    The percentage of free school meal pupils achieving level 2 by 19 ",
      #                                    change_ed(reg_l2_rate_fsm(input$select2,last_year),reg_l2_rate_fsm(input$select2,latest_year)),
      #                                    round(as.numeric(reg_l2_rate_fsm(input$select2, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2_rate_fsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
      #                                    
      #                                    The percentage of non free school meal pupils achieving level 2 by 19 ",
      #                                    change_ed(reg_l2_rate_nonfsm(input$select2,last_year),reg_l2_rate_nonfsm(input$select2,latest_year)),
      #                                    round(as.numeric(reg_l2_rate_nonfsm(input$select2, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2_rate_nonfsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
                                         )}
    else if (input$select_cat == "l2em") {paste("For those receiving free school meals, "
                                                ,round(as.numeric(la_l2em_rate_fsm(input$select2,latest_year)),1)
                                                , "% achieved level 2 with English and maths by 19 in ",latest_year," compared with  "
                                                ,round(as.numeric(la_l2em_rate_nonfsm(input$select2,latest_year)),1)
                                                , "% of those not receiving free school meals."
                                                
      
      
      
      # "The percentage achieving level 2 with English and maths by 19 in the ", str_sub(region_name(input$select2),1,25),"region",
      #                                           change_ed(reg_l2em_rate(input$select2,last_year),reg_l2em_rate(input$select2,latest_year)),
      #                                           round(as.numeric(reg_l2em_rate(input$select2, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2em_rate(input$select2,latest_year)),1), " per cent in ",latest_year,".
      #                                           
      #                                           The percentage of free school meal pupils achieving level 2 with English and maths by 19 ",
      #                                           change_ed(reg_l2em_rate_fsm(input$select2,last_year),reg_l2em_rate_fsm(input$select2,latest_year)),
      #                                           round(as.numeric(reg_l2em_rate_fsm(input$select2, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2em_rate_fsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
      #                                           
      #                                           The percentage of non free school meal pupils achieving level 2 with English and maths by 19 ",
      #                                           change_ed(reg_l2em_rate_nonfsm(input$select2,last_year),reg_l2em_rate_nonfsm(input$select2,latest_year)),
      #                                           round(as.numeric(reg_l2em_rate_nonfsm(input$select2, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2em_rate_nonfsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
                                                )}
    
    else if (input$select_cat == "l3") {paste("For those receiving free school meals, "
                                              ,round(as.numeric(la_l3_rate_fsm(input$select2,latest_year)),1)
                                              , "% achieved level 3 by 19 in ",latest_year," compared with  "
                                              ,round(as.numeric(la_l3_rate_nonfsm(input$select2,latest_year)),1)
                                              , "% of those not receiving free school meals."
                                              
      
      
      # "The percentage achieving level 3 by 19 in the ", str_sub(region_name(input$select2),1,25),"region",
      #                                         change_ed(reg_l3_rate(input$select2,last_year),reg_l3_rate(input$select2,latest_year)),
      #                                         round(as.numeric(reg_l3_rate(input$select2,last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l3_rate(input$select2,latest_year)),1), " per cent in ",latest_year,".
      #                                         
      #                                         The percentage of free school meal pupils achieving level 3 by 19 ",
      #                                         change_ed(reg_l3_rate_fsm(input$select2,last_year),reg_l3_rate_fsm(input$select2,latest_year)),
      #                                         round(as.numeric(reg_l3_rate_fsm(input$select2,last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l3_rate_fsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
      #                                         
      #                                         The percentage of non free school meal pupils achieving level 3 by 19 ",
      #                                         change_ed(reg_l3_rate_nonfsm(input$select2,last_year),reg_l3_rate_nonfsm(input$select2,latest_year)),
      #                                         round(as.numeric(reg_l3_rate_nonfsm(input$select2,last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l3_rate_nonfsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
                                              )}                                   
  })
  
  #regional text - SEN
  output$region_title2 <- renderText({paste(str_sub(region_name2(input$select3),1,25)," region summary")})
  
  output$reg_sum_sen <- renderText({
    if (input$select_cat2 == "l2") {paste("For those with a statement of SEN or Education Health Care (EHC) plan, "
            ,round(as.numeric(la_l2_rate2_sen_with(input$select3,latest_year)),1)
            , "% achieved level 2 by 19 in ",latest_year," compared with  "
            ,round(as.numeric(la_l2_rate2_nosen(input$select3,latest_year)),1)
            , "% of those with no identified SEN."
                                          )}
    else if (input$select_cat2 == "l2em") {paste("For those with a statement of SEN or Education Health Care (EHC) plan, "
                                                 ,round(as.numeric(la_l2em_rate2_sen_with(input$select3,latest_year)),1)
                                                 , "% achieved level 2 with English and maths by 19 in ",latest_year," compared with  "
                                                 ,round(as.numeric(la_l2em_rate2_nosen(input$select3,latest_year)),1)
                                                 , "% of those with no identified SEN."
      
      # "The percentage achieving level 2 with English and maths by 19 in the ", str_sub(region_name2(input$select3),1,25),"region",
      #                                            change_ed(reg_l2em_rate2(input$select3,last_year),reg_l2em_rate2(input$select3,latest_year)),
      #                                            round(as.numeric(reg_l2em_rate2(input$select3, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2em_rate2(input$select3,latest_year)),1), " per cent in ",latest_year,".
      #                                            
      #                                            The percentage of pupils with a statement of SEN or Education Health Care (EHC) plan achieving level 2 with English and maths by 19 ",
      #                                            change_ed(reg_l2em_rate2_sen_with(input$select3,last_year),reg_l2em_rate2_sen_with(input$select3,latest_year)),
      #                                            round(as.numeric(reg_l2em_rate2_sen_with(input$select3, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2em_rate2_sen_with(input$select3,latest_year)),1), " per cent in ",latest_year,".
      #                                            
      #                                            The percentage of pupils with no identified SEN achieving level 2 with English and maths by 19 ",
      #                                            change_ed(reg_l2em_rate2_nosen(input$select3,last_year),reg_l2em_rate2_nosen(input$select3,latest_year)),
      #                                            round(as.numeric(reg_l2em_rate2_nosen(input$select3, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2em_rate2_nosen(input$select3,latest_year)),1), " per cent in ",latest_year,".
                                                 )}
    
    else if (input$select_cat2 == "l3") {paste("For those with a statement of SEN or Education Health Care (EHC) plan, "
                                               ,round(as.numeric(la_l3_rate2_sen_with(input$select3,latest_year)),1)
                                               , "% achieved level 3 by 19 in ",latest_year," compared with  "
                                               ,round(as.numeric(la_l3_rate2_nosen(input$select3,latest_year)),1)
                                               , "% of those with no identified SEN."
      
      
      # "The percentage achieving level 3 by 19 in the ", str_sub(region_name2(input$select3),1,25),"region",
      #                                          change_ed(reg_l3_rate2(input$select3,last_year),reg_l3_rate2(input$select3,latest_year)),
      #                                          round(as.numeric(reg_l3_rate2(input$select3, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l3_rate2(input$select3,latest_year)),1), " per cent in ",latest_year,".
      #                                          
      #                                          The percentage of pupils with a statement of SEN or Education Health Care (EHC) plan achieving level 3 by 19 ",
      #                                          change_ed(reg_l3_rate2_sen_with(input$select3,last_year),reg_l3_rate2_sen_with(input$select3,latest_year)),
      #                                          round(as.numeric(reg_l3_rate2_sen_with(input$select3, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l3_rate2_sen_with(input$select3,latest_year)),1), " per cent in ",latest_year,".
      #                                          
      #                                          The percentage of pupils with no identified SEN achieving level 3 by 19 ",
      #                                          change_ed(reg_l3_rate2_nosen(input$select3,last_year),reg_l3_rate2_nosen(input$select3,latest_year)),
      #                                          round(as.numeric(reg_l3_rate2_nosen(input$select3, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l3_rate2_nosen(input$select3,latest_year)),1), " per cent in ",latest_year,".
                                               )}                                   
  })
  
  
  #National summary text - FSM
  # Gives the latest year changes depending on what measure is selected.
  output$nat_sum_fsm <- renderText({
    if (input$select_cat == "l2") {
      paste("In comparison, in the ", str_sub(region_name(input$select2),1,25),"region,"
            ,round(as.numeric(reg_l2_rate_fsm(input$select2,latest_year)),1)
            , "% of those with receiving free school meals achieved level 2 by 19 ("
            ,round(as.numeric(nat_l2_rate_fsm(latest_year)),1), 
            "% nationally) compared to", 
            round(as.numeric(reg_l2_rate_nonfsm(input$select2,latest_year)),1), 
            "% of those not receiving free school meals ("
            ,round(as.numeric(nat_l2_rate_nonfsm(latest_year)),1), 
            "% nationally)." 
        
        
        # "The percentage achieving level 2 by 19 in England ",change_ed(round(as.numeric(nat_l2_rate(last_year)),1),round(as.numeric(nat_l2_rate(latest_year)),1)), 
        #     " ",round(as.numeric(nat_l2_rate(last_year)),1),
        #     " per cent in ",last_year, " to ",round(as.numeric(nat_l2_rate(latest_year)),1), " per cent in ",latest_year,".
        #     
        #     The percentage of free school meal pupils achieving level 2 by 19 in England ",change_ed(round(as.numeric(nat_l2_rate_fsm(last_year)),1),round(as.numeric(nat_l2_rate_fsm(latest_year)),1)), 
        #     " ",round(as.numeric(nat_l2_rate_fsm(last_year)),1),
        #     " per cent in ",last_year, " to ",round(as.numeric(nat_l2_rate_fsm(latest_year)),1), " per cent in ",latest_year,".
        #     
        #     The percentage of non free school meal pupils achieving level 2 by 19 in England",change_ed(round(as.numeric(nat_l2_rate_nonfsm(last_year)),1),round(as.numeric(nat_l2_rate_nonfsm(latest_year)),1)), 
        #     " ",round(as.numeric(nat_l2_rate_nonfsm(last_year)),1),
        #     " per cent in ",last_year, " to ",round(as.numeric(nat_l2_rate_nonfsm(latest_year)),1), " per cent in ",latest_year,".
            )}
    
    else if (input$select_cat == "l2em") {
      paste("In comparison, in the ", str_sub(region_name(input$select2),1,25),"region,"
            ,round(as.numeric(reg_l2em_rate_fsm(input$select2,latest_year)),1)
            , "% of those with receiving free school meals achieved level 2 with English and maths by 19 ("
            ,round(as.numeric(nat_l2em_rate_fsm(latest_year)),1), 
            "% nationally) compared to", 
            round(as.numeric(reg_l2em_rate_nonfsm(input$select2,latest_year)),1), 
            "% of those not receiving free school meals ("
            ,round(as.numeric(nat_l2em_rate_nonfsm(latest_year)),1), 
            "% nationally)." 
        
        
        # "The percentage achieving level 2 with English and maths by 19 in England ",change_ed(round(as.numeric(nat_l2em_rate(last_year)),1),round(as.numeric(nat_l2em_rate(latest_year)),1)),
        #     "  ",round(as.numeric(nat_l2em_rate(last_year)),1),
        #     " per cent in ",last_year, " to ",round(as.numeric(nat_l2em_rate(latest_year)),1), " per cent in ",latest_year,".
        #     
        #     The percentage of free school meal pupils achieving level 2 with English and maths by 19 in England",change_ed(round(as.numeric(nat_l2em_rate_fsm(last_year)),1),round(as.numeric(nat_l2em_rate_fsm(latest_year)),1)),
        #     "  ",round(as.numeric(nat_l2em_rate_fsm(last_year)),1),
        #     " per cent in ",last_year, " to ",round(as.numeric(nat_l2em_rate_fsm(latest_year)),1), " per cent in ",latest_year,".
        #     
        #     The percentage of non free school meal pupils achieving level 2 with English and maths by 19 in England ",change_ed(round(as.numeric(nat_l2em_rate_nonfsm(last_year)),1),round(as.numeric(nat_l2em_rate_nonfsm(latest_year)),1)),
        #     "  ",round(as.numeric(nat_l2em_rate_nonfsm(last_year)),1),
        #     " per cent in ",last_year, " to ",round(as.numeric(nat_l2em_rate_nonfsm(latest_year)),1), " per cent in ",latest_year,".
            )}
    
    else if (input$select_cat == "l3") {
      paste("In comparison, in the ", str_sub(region_name(input$select2),1,25),"region,"
            ,round(as.numeric(reg_l3_rate_fsm(input$select2,latest_year)),1)
            , "% of those with receiving free school meals achieved level 3 by 19 ("
            ,round(as.numeric(nat_l3_rate_fsm(latest_year)),1), 
            "% nationally) compared to", 
            round(as.numeric(reg_l3_rate_nonfsm(input$select2,latest_year)),1), 
            "% of those not receiving free school meals ("
            ,round(as.numeric(nat_l3_rate_nonfsm(latest_year)),1), 
            "% nationally)." 
        
        # "The percentage achieving level 3 by 19 in England ",change_ed(round(as.numeric(nat_l3_rate(last_year)),1),round(as.numeric(nat_l3_rate(latest_year)),1)),
        #     " ",round(as.numeric(nat_l3_rate(last_year)),1),
        #     " per cent in ",last_year, " to ",round(as.numeric(nat_l3_rate(latest_year)),1), " per cent in ",latest_year,".
        #     
        #     The percentage of free school meal pupils achieving level 3 by 19 in England ",change_ed(round(as.numeric(nat_l3_rate_fsm(last_year)),1),round(as.numeric(nat_l3_rate_fsm(latest_year)),1)),
        #     " ",round(as.numeric(nat_l3_rate_fsm(last_year)),1),
        #     " per cent in ",last_year, " to ",round(as.numeric(nat_l3_rate_fsm(latest_year)),1), " per cent in ",latest_year,".
        #     
        #     The percentage of non free school meal pupils achieving level 3 by 19 in England ",change_ed(round(as.numeric(nat_l3_rate_nonfsm(last_year)),1),round(as.numeric(nat_l3_rate_nonfsm(latest_year)),1)),
        #     " ",round(as.numeric(nat_l3_rate_nonfsm(last_year)),1),
        #     " per cent in ",last_year, " to ",round(as.numeric(nat_l3_rate_nonfsm(latest_year)),1), " per cent in ",latest_year,".
            )}
  })
  
  
  #National summary - SEN
  # Gives the latest year changes depending on what measure is selected.
  output$nat_sum_sen <- renderText({
    if (input$select_cat2 == "l2") {
      paste("In comparison, in the ", str_sub(region_name2(input$select3),1,25),"region,"
            ,round(as.numeric(reg_l2_rate2_sen_with(input$select3,latest_year)),1)
            , "% of those with a statement of SEN or Education Health Care (EHC) plan achieved level 2 by 19 ("
            ,round(as.numeric(nat_l2_rate2_sen_with(latest_year)),1), 
            "% nationally) compared to", 
            round(as.numeric(reg_l2_rate2_nosen(input$select3,latest_year)),1), 
            "% of those with no identified SEN ("
            ,round(as.numeric(nat_l2_rate2_nosen(latest_year)),1), 
            "% nationally). 
            ")}
    
    else if (input$select_cat2 == "l2em") {
      paste("In comparison, in the ", str_sub(region_name2(input$select3),1,25),"region,"
            ,round(as.numeric(reg_l2em_rate2_sen_with(input$select3,latest_year)),1)
            , "% of those with a statement of SEN or Education Health Care (EHC) plan achieved level 2 with English and maths by 19 ("
            ,round(as.numeric(nat_l2em_rate2_sen_with(latest_year)),1), 
            "% nationally) compared to", 
            round(as.numeric(reg_l2em_rate2_nosen(input$select3,latest_year)),1), 
            "% of those with no identified SEN ("
            ,round(as.numeric(nat_l2em_rate2_nosen(latest_year)),1), 
            "% nationally)." 
        
        
        # "The percentage achieving level 2 with English and maths by 19 in England ",change_ed(round(as.numeric(nat_l2em_rate2(last_year)),1),round(as.numeric(nat_l2em_rate2(latest_year)),1)),
        #     "  ",round(as.numeric(nat_l2em_rate2(last_year)),1),
        #     " per cent in ",last_year, " to ",round(as.numeric(nat_l2em_rate2(latest_year)),1), " per cent in ",latest_year,".
        #     
        #     The percentage of pupils with a statement of SEN or Education Health Care (EHC) plan achieving level 2 with English and maths by 19 in England ",change_ed(round(as.numeric(nat_l2em_rate2_sen_with(last_year)),1),round(as.numeric(nat_l2em_rate2_sen_with(latest_year)),1)),
        #     "  ",round(as.numeric(nat_l2em_rate2_sen_with(last_year)),1),
        #     " per cent in ",last_year, " to ",round(as.numeric(nat_l2em_rate2_sen_with(latest_year)),1), " per cent in ",latest_year,".
        #     
        #     The percentage of pupils with no identified SEN achieving level 2 with English and maths by 19 in England ",change_ed(round(as.numeric(nat_l2em_rate2_nosen(last_year)),1),round(as.numeric(nat_l2em_rate2_nosen(latest_year)),1)),
        #     "  ",round(as.numeric(nat_l2em_rate2_nosen(last_year)),1),
        #     " per cent in ",last_year, " to ",round(as.numeric(nat_l2em_rate2_nosen(latest_year)),1), " per cent in ",latest_year,".
            )}
    
    else if (input$select_cat2 == "l3") {
      paste("In comparison, in the ", str_sub(region_name2(input$select3),1,25),"region,"
            ,round(as.numeric(reg_l3_rate2_sen_with(input$select3,latest_year)),1)
            , "% of those with a statement of SEN or Education Health Care (EHC) plan achieved level 3 by 19 ("
            ,round(as.numeric(nat_l3_rate2_sen_with(latest_year)),1), 
            "% nationally) compared to", 
            round(as.numeric(reg_l3_rate2_nosen(input$select3,latest_year)),1), 
            "% of those with no identified SEN ("
            ,round(as.numeric(nat_l3_rate2_nosen(latest_year)),1), 
            "% nationally)." 
        
        # "The percentage achieving level 3 by 19 in England ",change_ed(round(as.numeric(nat_l3_rate2(last_year)),1),round(as.numeric(nat_l3_rate2(latest_year)),1)),
        #     " ",round(as.numeric(nat_l3_rate2(last_year)),1),
        #     " per cent in ",last_year, " to ",round(as.numeric(nat_l3_rate2(latest_year)),1), " per cent in ",latest_year,".
        #     
        #     The percentage of pupils with a statement of SEN or Education Health Care (EHC) plan achieving level 3 by 19 in England ",change_ed(round(as.numeric(nat_l3_rate2_sen_with(last_year)),1),round(as.numeric(nat_l3_rate2_sen_with(latest_year)),1)),
        #     " ",round(as.numeric(nat_l3_rate2_sen_with(last_year)),1),
        #     " per cent in ",last_year, " to ",round(as.numeric(nat_l3_rate2_sen_with(latest_year)),1), " per cent in ",latest_year,".
        #     
        #     The percentage of pupils with no identified SEN achieving level 3 by 19 in England ",change_ed(round(as.numeric(nat_l3_rate2_nosen(last_year)),1),round(as.numeric(nat_l3_rate2_nosen(latest_year)),1)),
        #     " ",round(as.numeric(nat_l3_rate2_nosen(last_year)),1),
        #     " per cent in ",last_year, " to ",round(as.numeric(nat_l3_rate2_nosen(latest_year)),1), " per cent in ",latest_year,".
            )}
  })
  
  
  
  #download data buttons - FSM
  output$fsm_la_data <- DT::renderDataTable({fsm_la_table(input$select2)},extensions = 'FixedColumns', options = list(paging = FALSE,
                                                                                                                      scrollX = TRUE,
                                                                                                                      fixedColumns = list(leftColumns = 5),
                                                                                                                      deferRender = TRUE,
                                                                                                                      scrollY = 700,
                                                                                                                      scroller = TRUE))
  output$downloadFSM <- downloadHandler(
    filename = function() {
      paste(input$select2, ".csv", sep = "") #creates file name
    },
    content = function(file) {
      write.csv(fsm_la_table(input$select2), file, row.names = FALSE) #converts dataframe to csv
    }
  )
  
  #download data buttons - SEN   
  output$sen_la_data <- DT::renderDataTable({sen_la_table(input$select3)},extensions = 'FixedColumns', options = list(paging = FALSE,
                                                                                                                      scrollX = TRUE,
                                                                                                                      fixedColumns = list(leftColumns = 5),
                                                                                                                      deferRender = TRUE,
                                                                                                                      scrollY = 700,
                                                                                                                      scroller = TRUE))
  output$downloadSEN <- downloadHandler(
    filename = function() {
      paste(input$select3, ".csv", sep = "") #creates file name
    },
    content = function(file) {
      write.csv(sen_la_table(input$select3), file, row.names = FALSE) #converts dataframe to csv
    }
  )
  
  
  
  # Map ----
  
  output$map <- renderLeaflet({excmap(input$select_map)})
  
  
  
  # Data sources and methods
  #Underlying data download
  
  output$downloadmain_ud <- downloadHandler(
    filename = function() {
      paste("la_underlying_data", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(la_ud, file, row.names = FALSE)
    }
  ) 




  # Stop app ---------------------------------------------------------------------------------

  session$onSessionEnded(function() {
    stopApp()
  })
}
