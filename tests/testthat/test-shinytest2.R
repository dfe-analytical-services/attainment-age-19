library(shinytest2)

standard_inputs <- c(
  "navlistPanel", "plot_type", "plot_type2", "select2", "select3",
  "select_cat", "select_cat2", "tabsetpanels_fsm", "tabsetpanels_fsm_sub",
  "tabsetpanels_sen"
)

outputs <- c(
  "boxFSM_All", "boxFSM_El", "boxFSM_NotEl", "boxSEN_All", "boxSEN_No", "boxSEN_with",
  "boxSEN_without", "la_sum_fsm", "la_sum_sen", "la_title", "la_title2", "nat_sum_fsm",
  "nat_sum_sen", "reg_sum_fsm", "reg_sum_sen", "t1_chart", "t2_chart"
)


test_that("{shinytest2} recording: attainment-age-19", {
  app <- AppDriver$new(name = "attainment-age-19", height = 976, width = 1305)
  app$expect_values(input = standard_inputs, output = outputs)
  app$set_inputs(tabsetpanels_fsm = "Local authority & Special Educational Need")
  app$expect_values(input = standard_inputs, output = outputs)
  app$set_inputs(select3 = "Bedford")
  app$expect_values(input = standard_inputs, output = outputs)
  app$set_inputs(select_cat2 = "Level 3")
  app$expect_values(input = standard_inputs, output = outputs)
  app$set_inputs(select3 = "Birmingham")
  app$expect_values(input = standard_inputs, output = outputs)
  app$set_inputs(tabsetpanels_fsm = "Local authority & Free School Meal Status")
  app$expect_values(input = standard_inputs, output = outputs)
  app$set_inputs(select2 = "Birmingham")
  app$expect_values(input = standard_inputs, output = outputs)
  app$set_inputs(navlistPanel = "Information")
  app$expect_values(input = standard_inputs, output = outputs)
  app$set_inputs(navlistPanel = "Accessibility")
  app$expect_values(input = standard_inputs, output = outputs)
  app$set_inputs(navlistPanel = "Support and feedback")
  app$expect_values(input = standard_inputs, output = outputs)
  app$set_inputs(navlistPanel = "LA & FSM")
  app$expect_values(input = standard_inputs, output = outputs)
})
