

source("codefile_shiny.R")


server <- function(input, output) {
  # 1. Front page ----
  
  output$l2_bar <- renderPlot({
    if (input$bars_type == "number") {
      national_bars_num('l2')
    } else if (input$bars_type == "rate") {
      national_bars_rate('l2')
    }
  })
  
  output$l3_bar <- renderPlot({
    if (input$bars_type2 == "number") {
      national_bars_num('l3')
    } else if (input$bars_type2 == "rate") {
      national_bars_rate('l3')
    }
  })
  
  # LA trends ---- FSM
  #number and rate plot depending on what option is selected.
    output$t1_chart <- renderPlot({
    if (input$plot_type == "number") {
      la_plot_num_fsm(input$select2, input$select_cat)
    } else if (input$plot_type == "rate") {
      la_plot_rate_fsm(input$select2, input$select_cat)
    }
  })
 
  #number or rate table depending on what option is selected 
  output$t1_table <- renderTable({
    if (input$plot_type == "number") {
      la_table_num_fsm(input$select2, input$select_cat)
    } else if (input$plot_type == "rate") {
      la_table_rate_fsm(input$select2, input$select_cat)
    }
  },
  bordered = TRUE,spacing = 'm',align = 'c')
  
  # LA trends ---- SEN
  #number and rate plot depending on what option is selected.
  output$t2_chart <- renderPlot({
    if (input$plot_type2 == "number") {
      la_plot_num_sen(input$select3, input$select_cat2)
    } else if (input$plot_type2 == "rate") {
      la_plot_rate_sen(input$select3, input$select_cat2)
    }
  })
  
  #number or rate table depending on what option is selected 
  output$t2_table <- renderTable({
    if (input$plot_type2 == "number") {
      la_table_num_sen(input$select3, input$select_cat2)
    } else if (input$plot_type2 == "rate") {
      la_table_rate_sen(input$select3, input$select_cat2)
    }
  },
  bordered = TRUE,spacing = 'm',align = 'c')
  
 
#LA summary text - FSM.
 # Gives the latest year changes depending on what measure is selected.
  output$la_title <- renderText({paste(input$select2," summary")})

  output$la_sum_fsm <- renderText({
    if (TRUE %in% is.na(as.numeric(la_l2_rate(input$select2,2005:2017)))){
      paste("Some data for the ", input$select2, " contains small numbers and is supressed. This is represented by an 'x' in the table below. Please refer to the graph and the table for data about this local authority.")
    }else {
    if (input$select_cat == "l2") {

        
        paste("The percentage achieving level 2 by 19 in ",input$select2," ",change_ed(round(as.numeric(la_l2_rate(input$select2,last_year)),1),round(as.numeric(la_l2_rate(input$select2,latest_year)),1)), 
              " ",round(as.numeric(la_l2_rate(input$select2,last_year)),1),
              " per cent in ",last_year, " to ",round(as.numeric(la_l2_rate(input$select2,latest_year)),1), " per cent in ",latest_year,". 
              
              The percentage of free school meal pupils achieving level 2 by 19 ",change_ed(round(as.numeric(la_l2_rate_fsm(input$select2,last_year)),1),round(as.numeric(la_l2_rate_fsm(input$select2,latest_year)),1)), 
              " ",round(as.numeric(la_l2_rate_fsm(input$select2,last_year)),1),
              " per cent in ",last_year, " to ",round(as.numeric(la_l2_rate_fsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
              
              The percentage of non free school meal pupils achieving level 2 by 19 ",change_ed(round(as.numeric(la_l2_rate_nonfsm(input$select2,last_year)),1),round(as.numeric(la_l2_rate_nonfsm(input$select2,latest_year)),1)), 
              " ",round(as.numeric(la_l2_rate_nonfsm(input$select2,last_year)),1),
              " per cent in ",last_year, " to ",round(as.numeric(la_l2_rate_nonfsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
              ")
        }
    
    else if (input$select_cat == "l2em") {
      paste("The percentage achieving level 2 with English and maths by 19 in ",input$select2," ",change_ed(round(as.numeric(la_l2em_rate(input$select2,last_year)),1),round(as.numeric(la_l2em_rate(input$select2,latest_year)),1)),
            "  ",round(as.numeric(la_l2em_rate(input$select2,last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(la_l2em_rate(input$select2,latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of free school meal pupils achieving level 2 with English and maths by 19 ",change_ed(round(as.numeric(la_l2em_rate_fsm(input$select2,last_year)),1),round(as.numeric(la_l2em_rate_fsm(input$select2,latest_year)),1)),
            "  ",round(as.numeric(la_l2em_rate_fsm(input$select2,last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(la_l2em_rate_fsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of non free school meal pupils achieving level 2 with English and maths by 19 ",change_ed(round(as.numeric(la_l2em_rate_nonfsm(input$select2,last_year)),1),round(as.numeric(la_l2em_rate_nonfsm(input$select2,latest_year)),1)),
            "  ",round(as.numeric(la_l2em_rate_nonfsm(input$select2,last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(la_l2em_rate_nonfsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
           ")}
    
    else if (input$select_cat == "l3") {
      paste("The percentage achieving level 3 by 19 in ",input$select2," ",change_ed(round(as.numeric(la_l3_rate(input$select2,last_year)),1),round(as.numeric(la_l3_rate(input$select2,latest_year)),1)),
            " ",round(as.numeric(la_l3_rate(input$select2,last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(la_l3_rate(input$select2,latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of free school meal pupils achieving level 3 by 19 ",change_ed(round(as.numeric(la_l3_rate_fsm(input$select2,last_year)),1),round(as.numeric(la_l3_rate_fsm(input$select2,latest_year)),1)),
            " ",round(as.numeric(la_l3_rate_fsm(input$select2,last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(la_l3_rate_fsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of non free school meal pupils achieving level 3 by 19 ",change_ed(round(as.numeric(la_l3_rate_nonfsm(input$select2,last_year)),1),round(as.numeric(la_l3_rate_nonfsm(input$select2,latest_year)),1)),
            " ",round(as.numeric(la_l3_rate_nonfsm(input$select2,last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(la_l3_rate_nonfsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
            ")}
  }
    })
    
  
  #LA summary text - SEN.
  # Gives the latest year changes depending on what measure is selected.
   output$la_title2 <- renderText({paste(input$select3," summary")})
  
  output$la_sum_sen <- renderText({
    
    if (TRUE %in% is.na(as.numeric(la_l2_rate2(input$select3,2005:2017)))){
      paste("Some data for the ", input$select3, " contains small numbers and is supressed. This is represented by an 'x' in the table below. Please refer to the graph and the table for data about this local authority.")
    }else {
    if (input$select_cat2 == "l2") {
      paste("The percentage achieving level 2 by 19 in ",input$select3," ",change_ed(round(as.numeric(la_l2_rate2(input$select3,last_year)),1),round(as.numeric(la_l2_rate2(input$select3,latest_year)),1)), 
            " ",round(as.numeric(la_l2_rate2(input$select3,last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(la_l2_rate2(input$select3,latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of pupils with a statement of SEN or EHC plan achieving level 2 by 19 ",change_ed(round(as.numeric(la_l2_rate2_sen_with(input$select3,last_year)),1),round(as.numeric(la_l2_rate2_sen_with(input$select3,latest_year)),1)), 
            " ",round(as.numeric(la_l2_rate2_sen_with(input$select3,last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(la_l2_rate2_sen_with(input$select3,latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of pupils with no identified SEN achieving level 2 by 19 ",change_ed(round(as.numeric(la_l2_rate2_nosen(input$select3,last_year)),1),round(as.numeric(la_l2_rate2_nosen(input$select3,latest_year)),1)), 
            " ",round(as.numeric(la_l2_rate2_nosen(input$select3,last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(la_l2_rate2_nosen(input$select3,latest_year)),1), " per cent in ",latest_year,".
            ")}
    
    else if (input$select_cat2 == "l2em") {
      paste("The percentage achieving level 2 with English and maths by 19 in ",input$select3," ",change_ed(round(as.numeric(la_l2em_rate2(input$select3,last_year)),1),round(as.numeric(la_l2em_rate2(input$select3,latest_year)),1)),
            "  ",round(as.numeric(la_l2em_rate2(input$select3,last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(la_l2em_rate2(input$select3,latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of pupils with a statement of SEN or EHC plan achieving level 2 with English and maths by 19 ",change_ed(round(as.numeric(la_l2em_rate2_sen_with(input$select3,last_year)),1),round(as.numeric(la_l2em_rate2_sen_with(input$select3,latest_year)),1)),
            "  ",round(as.numeric(la_l2em_rate2_sen_with(input$select3,last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(la_l2em_rate2_sen_with(input$select3,latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of pupils with no identified SEN achieving level 2 with English and maths by 19 ",change_ed(round(as.numeric(la_l2em_rate2_nosen(input$select3,last_year)),1),round(as.numeric(la_l2em_rate2_nosen(input$select3,latest_year)),1)),
            "  ",round(as.numeric(la_l2em_rate2_nosen(input$select3,last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(la_l2em_rate2_nosen(input$select3,latest_year)),1), " per cent in ",latest_year,".
            ")}
    
    else if (input$select_cat2 == "l3") {
      paste("The percentage achieving level 3 by 19 in ",input$select3," ",change_ed(round(as.numeric(la_l3_rate2(input$select3,last_year)),1),round(as.numeric(la_l3_rate2(input$select3,latest_year)),1)),
            " ",round(as.numeric(la_l3_rate2(input$select3,last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(la_l3_rate2(input$select3,latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of pupils with a statement of SEN or EHC plan achieving level 3 by 19 ",change_ed(round(as.numeric(la_l3_rate2_sen_with(input$select3,last_year)),1),round(as.numeric(la_l3_rate2_sen_with(input$select3,latest_year)),1)),
            " ",round(as.numeric(la_l3_rate2_sen_with(input$select3,last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(la_l3_rate2_sen_with(input$select3,latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of pupils with no identified SEN achieving level 3 by 19 ",change_ed(round(as.numeric(la_l3_rate2_nosen(input$select3,last_year)),1),round(as.numeric(la_l3_rate2_nosen(input$select3,latest_year)),1)),
            " ",round(as.numeric(la_l3_rate2_nosen(input$select3,last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(la_l3_rate2_nosen(input$select3,latest_year)),1), " per cent in ",latest_year,".
            ")}
   }
    })
  
  #regional text - FSM
  output$region_title <- renderText({paste(str_sub(region_name(input$select2),3,25)," region summary")})
  
  output$reg_sum_fsm <- renderText({
    if (input$select_cat == "l2") {paste("The percentage achieving level 2 by 19 in the ", str_sub(region_name(input$select2),3,25)," region",
                                         change_ed(reg_l2_rate(input$select2,last_year),reg_l2_rate(input$select2,latest_year)),
                                         round(as.numeric(reg_l2_rate(input$select2, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2_rate(input$select2,latest_year)),1), " per cent in ",latest_year,".
                                         
                                         The percentage of free school meal pupils achieving level 2 by 19 ",
                                         change_ed(reg_l2_rate_fsm(input$select2,last_year),reg_l2_rate_fsm(input$select2,latest_year)),
                                         round(as.numeric(reg_l2_rate_fsm(input$select2, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2_rate_fsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
                                         
                                         The percentage of non free school meal pupils achieving level 2 by 19 ",
                                         change_ed(reg_l2_rate_nonfsm(input$select2,last_year),reg_l2_rate_nonfsm(input$select2,latest_year)),
                                         round(as.numeric(reg_l2_rate_nonfsm(input$select2, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2_rate_nonfsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
                                         ")}
    else if (input$select_cat == "l2em") {paste("The percentage achieving level 2 with English and maths by 19 in the ", str_sub(region_name(input$select2),3,25),"region",
                                                change_ed(reg_l2em_rate(input$select2,last_year),reg_l2em_rate(input$select2,latest_year)),
                                                round(as.numeric(reg_l2em_rate(input$select2, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2em_rate(input$select2,latest_year)),1), " per cent in ",latest_year,".
                                                
                                                The percentage of free school meal pupils achieving level 2 with English and maths by 19 ",
                                                change_ed(reg_l2em_rate_fsm(input$select2,last_year),reg_l2em_rate_fsm(input$select2,latest_year)),
                                                round(as.numeric(reg_l2em_rate_fsm(input$select2, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2em_rate_fsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
                                                
                                                The percentage of non free school meal pupils achieving level 2 with English and maths by 19 ",
                                                change_ed(reg_l2em_rate_nonfsm(input$select2,last_year),reg_l2em_rate_nonfsm(input$select2,latest_year)),
                                                round(as.numeric(reg_l2em_rate_nonfsm(input$select2, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2em_rate_nonfsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
                                                ")}
    
    else if (input$select_cat == "l3") {paste("The percentage achieving level 3 by 19 in the ", str_sub(region_name(input$select2),3,25),"region",
                                              change_ed(reg_l3_rate(input$select2,last_year),reg_l3_rate(input$select2,latest_year)),
                                              round(as.numeric(reg_l3_rate(input$select2,last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l3_rate(input$select2,latest_year)),1), " per cent in ",latest_year,".
                                              
                                              The percentage of free school meal pupils achieving level 3 by 19 ",
                                              change_ed(reg_l3_rate_fsm(input$select2,last_year),reg_l3_rate_fsm(input$select2,latest_year)),
                                              round(as.numeric(reg_l3_rate_fsm(input$select2,last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l3_rate_fsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
                                              
                                              The percentage of non free school meal pupils achieving level 3 by 19 ",
                                              change_ed(reg_l3_rate_nonfsm(input$select2,last_year),reg_l3_rate_nonfsm(input$select2,latest_year)),
                                              round(as.numeric(reg_l3_rate_nonfsm(input$select2,last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l3_rate_nonfsm(input$select2,latest_year)),1), " per cent in ",latest_year,".
                                              ")}                                   
    })
  
  #regional text - SEN
  output$region_title2 <- renderText({paste(str_sub(region_name2(input$select3),3,25)," region summary")})
  
  output$reg_sum_sen <- renderText({
    if (input$select_cat2 == "l2") {paste("The percentage achieving level 2 by 19 in the ", str_sub(region_name2(input$select3),3,25),"region",
                                          change_ed(reg_l2_rate2(input$select3,last_year),reg_l2_rate2(input$select3,latest_year)),
                                          round(as.numeric(reg_l2_rate2(input$select3, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2_rate2(input$select3,latest_year)),1), " per cent in ",latest_year,".
                                          
                                          The percentage of pupils with a statement of SEN or EHC plan achieving level 2 by 19 ",
                                          change_ed(reg_l2_rate2_sen_with(input$select3,last_year),reg_l2_rate2_sen_with(input$select3,latest_year)),
                                          round(as.numeric(reg_l2_rate2_sen_with(input$select3, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2_rate2_sen_with(input$select3,latest_year)),1), " per cent in ",latest_year,".
                                          
                                          The percentage of pupils with no identified SEN achieving level 2 by 19 ",
                                          change_ed(reg_l2_rate2_nosen(input$select3,last_year),reg_l2_rate2_nosen(input$select3,latest_year)),
                                          round(as.numeric(reg_l2_rate2_nosen(input$select3, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2_rate2_nosen(input$select3,latest_year)),1), " per cent in ",latest_year,".
                                          ")}
    else if (input$select_cat2 == "l2em") {paste("The percentage achieving level 2 with English and maths by 19 in the ", str_sub(region_name2(input$select3),3,25),"region",
                                                 change_ed(reg_l2em_rate2(input$select3,last_year),reg_l2em_rate2(input$select3,latest_year)),
                                                 round(as.numeric(reg_l2em_rate2(input$select3, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2em_rate2(input$select3,latest_year)),1), " per cent in ",latest_year,".
                                                 
                                                 The percentage of pupils with a statement of SEN or EHC plan achieving level 2 with English and maths by 19 ",
                                                 change_ed(reg_l2em_rate2_sen_with(input$select3,last_year),reg_l2em_rate2_sen_with(input$select3,latest_year)),
                                                 round(as.numeric(reg_l2em_rate2_sen_with(input$select3, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2em_rate2_sen_with(input$select3,latest_year)),1), " per cent in ",latest_year,".
                                                 
                                                 The percentage of pupils with no identified SEN achieving level 2 with English and maths by 19 ",
                                                 change_ed(reg_l2em_rate2_nosen(input$select3,last_year),reg_l2em_rate2_nosen(input$select3,latest_year)),
                                                 round(as.numeric(reg_l2em_rate2_nosen(input$select3, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l2em_rate2_nosen(input$select3,latest_year)),1), " per cent in ",latest_year,".
                                                 ")}
    
    else if (input$select_cat2 == "l3") {paste("The percentage achieving level 3 by 19 in the ", str_sub(region_name2(input$select3),3,25),"region",
                                               change_ed(reg_l3_rate2(input$select3,last_year),reg_l3_rate2(input$select3,latest_year)),
                                               round(as.numeric(reg_l3_rate2(input$select3, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l3_rate2(input$select3,latest_year)),1), " per cent in ",latest_year,".
                                               
                                               The percentage of pupils with a statement of SEN or EHC plan achieving level 3 by 19 ",
                                               change_ed(reg_l3_rate2_sen_with(input$select3,last_year),reg_l3_rate2_sen_with(input$select3,latest_year)),
                                               round(as.numeric(reg_l3_rate2_sen_with(input$select3, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l3_rate2_sen_with(input$select3,latest_year)),1), " per cent in ",latest_year,".
                                               
                                               The percentage of pupils with no identified SEN achieving level 3 by 19 ",
                                               change_ed(reg_l3_rate2_nosen(input$select3,last_year),reg_l3_rate2_nosen(input$select3,latest_year)),
                                               round(as.numeric(reg_l3_rate2_nosen(input$select3, last_year)),1)," per cent in ",last_year, " to ", round(as.numeric(reg_l3_rate2_nosen(input$select3,latest_year)),1), " per cent in ",latest_year,".
                                               ")}                                   
    })
  
  
  #National summary text - FSM
  # Gives the latest year changes depending on what measure is selected.
    output$nat_sum_fsm <- renderText({
    if (input$select_cat == "l2") {
      paste("The percentage achieving level 2 by 19 in England ",change_ed(round(as.numeric(nat_l2_rate(last_year)),1),round(as.numeric(nat_l2_rate(latest_year)),1)), 
            " ",round(as.numeric(nat_l2_rate(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l2_rate(latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of free school meal pupils achieving level 2 by 19 in England ",change_ed(round(as.numeric(nat_l2_rate_fsm(last_year)),1),round(as.numeric(nat_l2_rate_fsm(latest_year)),1)), 
            " ",round(as.numeric(nat_l2_rate_fsm(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l2_rate_fsm(latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of non free school meal pupils achieving level 2 by 19 in England",change_ed(round(as.numeric(nat_l2_rate_nonfsm(last_year)),1),round(as.numeric(nat_l2_rate_nonfsm(latest_year)),1)), 
            " ",round(as.numeric(nat_l2_rate_nonfsm(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l2_rate_nonfsm(latest_year)),1), " per cent in ",latest_year,".
            ")}
    
    else if (input$select_cat == "l2em") {
      paste("The percentage achieving level 2 with English and maths by 19 in England ",change_ed(round(as.numeric(nat_l2em_rate(last_year)),1),round(as.numeric(nat_l2em_rate(latest_year)),1)),
            "  ",round(as.numeric(nat_l2em_rate(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l2em_rate(latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of free school meal pupils achieving level 2 with English and maths by 19 in England",change_ed(round(as.numeric(nat_l2em_rate_fsm(last_year)),1),round(as.numeric(nat_l2em_rate_fsm(latest_year)),1)),
            "  ",round(as.numeric(nat_l2em_rate_fsm(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l2em_rate_fsm(latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of non free school meal pupils achieving level 2 with English and maths by 19 in England ",change_ed(round(as.numeric(nat_l2em_rate_nonfsm(last_year)),1),round(as.numeric(nat_l2em_rate_nonfsm(latest_year)),1)),
            "  ",round(as.numeric(nat_l2em_rate_nonfsm(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l2em_rate_nonfsm(latest_year)),1), " per cent in ",latest_year,".
            ")}
    
    else if (input$select_cat == "l3") {
      paste("The percentage achieving level 3 by 19 in England ",change_ed(round(as.numeric(nat_l3_rate(last_year)),1),round(as.numeric(nat_l3_rate(latest_year)),1)),
            " ",round(as.numeric(nat_l3_rate(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l3_rate(latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of free school meal pupils achieving level 3 by 19 in England ",change_ed(round(as.numeric(nat_l3_rate_fsm(last_year)),1),round(as.numeric(nat_l3_rate_fsm(latest_year)),1)),
            " ",round(as.numeric(nat_l3_rate_fsm(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l3_rate_fsm(latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of non free school meal pupils achieving level 3 by 19 in England ",change_ed(round(as.numeric(nat_l3_rate_nonfsm(last_year)),1),round(as.numeric(nat_l3_rate_nonfsm(latest_year)),1)),
            " ",round(as.numeric(nat_l3_rate_nonfsm(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l3_rate_nonfsm(latest_year)),1), " per cent in ",latest_year,".
            ")}
    })
  
  
  #National summary - SEN
  # Gives the latest year changes depending on what measure is selected.
    output$nat_sum_sen <- renderText({
    if (input$select_cat2 == "l2") {
      paste("The percentage achieving level 2 by 19 in England ",change_ed(round(as.numeric(nat_l2_rate2(last_year)),1),round(as.numeric(nat_l2_rate2(latest_year)),1)), 
            " ",round(as.numeric(nat_l2_rate2(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l2_rate2(latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of pupils with a statement of SEN or EHC plan achieving level 2 by 19 in England ",change_ed(round(as.numeric(nat_l2_rate2_sen_with(last_year)),1),round(as.numeric(nat_l2_rate2_sen_with(latest_year)),1)), 
            " ",round(as.numeric(nat_l2_rate2_sen_with(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l2_rate2_sen_with(latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of pupils with no identified SEN achieving level 2 by 19 in England ",change_ed(round(as.numeric(nat_l2_rate2_nosen(last_year)),1),round(as.numeric(nat_l2_rate2_nosen(latest_year)),1)), 
            " ",round(as.numeric(nat_l2_rate2_nosen(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l2_rate2_nosen(latest_year)),1), " per cent in ",latest_year,".
            ")}
    
    else if (input$select_cat2 == "l2em") {
      paste("The percentage achieving level 2 with English and maths by 19 in England ",change_ed(round(as.numeric(nat_l2em_rate2(last_year)),1),round(as.numeric(nat_l2em_rate2(latest_year)),1)),
            "  ",round(as.numeric(nat_l2em_rate2(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l2em_rate2(latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of pupils with a statement of SEN or EHC plan achieving level 2 with English and maths by 19 in England ",change_ed(round(as.numeric(nat_l2em_rate2_sen_with(last_year)),1),round(as.numeric(nat_l2em_rate2_sen_with(latest_year)),1)),
            "  ",round(as.numeric(nat_l2em_rate2_sen_with(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l2em_rate2_sen_with(latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of pupils with no identified SEN achieving level 2 with English and maths by 19 in England ",change_ed(round(as.numeric(nat_l2em_rate2_nosen(last_year)),1),round(as.numeric(nat_l2em_rate2_nosen(latest_year)),1)),
            "  ",round(as.numeric(nat_l2em_rate2_nosen(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l2em_rate2_nosen(latest_year)),1), " per cent in ",latest_year,".
            ")}
    
    else if (input$select_cat2 == "l3") {
      paste("The percentage achieving level 3 by 19 in England ",change_ed(round(as.numeric(nat_l3_rate2(last_year)),1),round(as.numeric(nat_l3_rate2(latest_year)),1)),
            " ",round(as.numeric(nat_l3_rate2(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l3_rate2(latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of pupils with a statement of SEN or EHC plan achieving level 3 by 19 in England ",change_ed(round(as.numeric(nat_l3_rate2_sen_with(last_year)),1),round(as.numeric(nat_l3_rate2_sen_with(latest_year)),1)),
            " ",round(as.numeric(nat_l3_rate2_sen_with(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l3_rate2_sen_with(latest_year)),1), " per cent in ",latest_year,".
            
            The percentage of pupils with no identified SEN achieving level 3 by 19 in England ",change_ed(round(as.numeric(nat_l3_rate2_nosen(last_year)),1),round(as.numeric(nat_l3_rate2_nosen(latest_year)),1)),
            " ",round(as.numeric(nat_l3_rate2_nosen(last_year)),1),
            " per cent in ",last_year, " to ",round(as.numeric(nat_l3_rate2_nosen(latest_year)),1), " per cent in ",latest_year,".
            ")}
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
}
