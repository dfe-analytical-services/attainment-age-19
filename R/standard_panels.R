a11y_panel <- function() {
  tabPanel(
    "Accessibility",
    gov_layout(
      size = "full",
      h2("Accessibility statement"),
      h3("Using this dashboard"),
      p("This R-shiny dashboard is run by Department for Education (DfE). We follow the recommendations of the WCAG 2.1 requirements."),
      p("We want as many people as possible to be able to use the report by: "),
      tags$ul(
        tags$li("Navigating most of the dashboard using keyboard and speech recognition software"),
        tags$li("Use most of the dashboard using a screen reader (including the most recent version of JAWS)"),
        tags$li("Using assistive technologies such as ZoomText and Fusion"),
        tags$li("Using different platforms including laptops, tablets and mobile phones"),
        tags$li("Zoom in up to 300% without the text spilling off the screen")
      ),
      h3("How accessible this dashboard is"),
      p("We know some parts of this dashboard are not fully accessible, for example:"),
      tags$ul(
        tags$li("Screen reader and keyboard users cannot navigate through the interactive graphs effectively. An accessible alternative is provided in a CSV format for users to download on this dashboard."),
        tags$li("Users may have difficultly reading the graph due to the use of colour. An accessible alternative is provided in a CSV format for users to download on this dashboard."),
        tags$li("Keyboard users may find it difficult to navigate through the dashboard due to the lack of instructions and interactive elements not working in a logical way. To navigate through the navigation bar, use the arrow keys and press tab to enter into the page."),
        tags$li("Keyboard users cannot navigate through the list boxes in a logical way. To use the dropdowns, the space bar and the up and down arrow keys can be used to expand the drop down. The tab key must be used to navigate through the options and enter must be clicked to choose an option."),
        tags$li("Tick boxes can only be selected using the space bar rather than the enter key."),
        tags$li("While using the tab key to navigate through the different selections of the list boxes, the screen reader does not read out the text to the users."),
        tags$li("Some users are not able to reflow up to 300% on this dashboard."),
        tags$li("Some text and interactive elements may not translate well to a screen reader."),
        tags$li("Some features within the tables of data may be limited to users of assistive technology.")
      ),
      h3("Enforcement procedure"),
      p("The Equality and Human Rights Commission (EHRC) is responsible for enforcing the accessibility regulations. If you’re not happy with how we respond to your complaint, contact the ", a(href = "https://www.equalityadvisoryservice.com/", "Equality Advisory and Support Service (EASS).")),
      h3("Technical information about this dashboard's accessibility"),
      p("The Department for Education is committed to making its dashboards accessible, in accordance with the Public Sector Bodies (Websites and Mobile Applications) (No. 2) Accessibility Regulations 2018."),
      h3("Compliance status"),
      p("This dashboard is partially compliant with the Web Content Accessibility Guidelines version 2.1 AA standard, due to the non-compliances listed."),
      h2("Non-compliance with the accessibility regulations"),
      p("The content below is non-accessible:"),
      tags$ul(
        tags$li("Graphs will not always reflow correctly depending on aspect ratio of screen. This can cause loss of information. This fails WCAG 2.1 A success criterion 1.4.10 (Reflow)."),
        tags$li("No guidance given to keyboard or screen reader users on how to navigate through the list box elements and navigation bar. This fails WCAG 2.1 A success criterion 3.3.2 (Labels or Instructions)."),
        tags$li("For some tablets and phone devices, when viewing vertically may not reflow correctly which can cause loss of information. This fails WCAG 2.1 A success criterion 1.3.4 (Orientation)."),
        tags$li("List box elements within this dashboard do not work in a logical manor when navigating with a keyboard. Some keys do not work as expected. This fails WCAG 2.1 A success criterion 2.1.1 (Keyboard)."),
        tags$li("Features within all the graphs cannot be navigated to using the keyboard. This means certain features will not be available to keyboard users. This fails WCAG 2.1 A success criterion 2.1.1 (Keyboard)."),
        tags$li("Some text is not read out in a consistent way while using screen readers. This fails WCAG 2.1 A success criterion 4.1.1 (Parsing)."),
        tags$li("List box elements do not have accessible names that can be programmatically determined. This may affect users of assistive technologies. This fails WCAG 2.1 A success criterion 4.1.2 (Name, Role, Value)."),
        tags$li("Text is not read out on a screen reader when using the tab key to navigate through all the list box options. This fails WCAG 2.1 A success criterion 4.1.1 (Parsing) & success criterion 4.1.2 (Name, Role, Value)."),
        tags$li("Features within all the graphs cannot be navigated to using assistive technologies. This means certain features will not be available to users of assistive technologies. This fails WCAG 2.1 A success criterion 4.1.1 (Parsing)."),
        tags$li("Text is not read out in a logical manner as text within the list boxes is repeated while using a screen reader. This fails WCAG 2.1 A success criterion 4.1.1 (Parsing) & A success criterion 4.1.2 (Name, Role, Value)."),
        tags$li("The search bar within the tables of data do not have accessible names that can be programmatically determined. This My affect users of assistive technologies. This fails WCAG 2.1 A success criterion 4.1.2 (Name, Role, Value)."),
        tags$li("Certain buttons within the table of data tab are unable to be pressed while using a screen reader. This fails WCAG 2.1 A success criterion 4.1.1 (Parsing)."),
        tags$li("Focus can get lost when navigating through the page after ‘View full screen’ is clicked. This fails WCAG 2.1 A success criterion 2.4.7 (Focus Visible)."),
        tags$li("Screen reader reads out text which is not on the current page once ‘View full screen’ has been navigated to. This fails WCAG 2.1 A success criterion 4.1.1 (Parsing)."),
        tags$li("Due to the limitations of using RShiny and the shinyGovstyle package, some parsing errors may occur when using assistive technologies. This may specifically be affected when using the 'user guide' and 'view full screen' features. This fails WCAG 2.1 A success criterion 4.1.1 (Parsing)."),
        tags$li("Some keyboard users may have difficulty when using the ‘View full screen’ due to a missing keyboard event handler. This fails WCAG 2.1 A success criterion 2.1.1 (Keyboard).")
      ),
      p("In March 2024, we will review the dashboard again and hope to address these errors."),
      h3("How we tested this dashboard"),
      p("This dashboard was last tested on [19/04/2023]. The test was carried out by the DfE."),
      p("Testing was carried out using:"),
      tags$ul(
        tags$li("Dragon NaturallySpeaking (V15.5), a voice recognition (speech to text) program which requires minimal user interface from a mouse or keyboard."),
        tags$li("JAWS (2021), a screen reader (text to speech) program developed for users whose vision loss prevents them from seeing screen content or navigating with a mouse."),
        tags$li("Zoomtext (2020), a magnification and reading program tailored for low-vision users. It enlarges and enhances everything on screen, echoes typing and essential program activity, and reads screen content."),
        tags$li("Fusion (2020), is a hybrid of ZoomText with its screen magnification and visual enhancements, coupled with the power and speed of JAWS for screen reading functionality."),
        tags$li("Sortsite (V6.45), a one-click web automation testing tool."),
        tags$li("aXe Devtools."),
        tags$li("Shinya11y, an R shiny automation testing package."),
      ),
      p("At the time of testing, these were the DfE’s supported versions of accessibility software."),
      h3("Testing methodology and browser compatibility"),
      h4("Testing Methodology"),
      p("The service was manually tested following the user acceptance scripts which involved:"),
      tags$ul(
        tags$li("using Screen readers (Jaws)"),
        tags$li("manual visual and programmatic testing"),
        tags$li("using only a keyboard to navigate through the service"),
        tags$li("using only speech recognition to navigate through the service"),
        tags$li("using automations testing tools such as Sortsite and Shinya11y")
      ),
      p("During testing, the following disabilities were considered:"),
      tags$ul(
        tags$li("Keyboard Only: The user has a motor impairment that limits them to using only a keyboard to operate a computer."),
        tags$li("Voice Activation: The user has a motor impairment that limits them to using only voice commands to operate a computer via assistive technology such as a microphone and dictation software."),
        tags$li("Screen Reader: The user has a visual impairment that limits them to using accessibility software such as a screen reader to operate a computer via keyboard control and feedback via audible descriptions of visual elements."),
        tags$li("Low Vision: The user has a visual impairment that limits their access to content presented at 100% magnification. The user utilises system/browser controls or accessibility software to increase screen magnification."),
        tags$li("Deaf or Hard of Hearing: The user has a hearing impairment that limits their access to audio content."),
        tags$li("Learning Difficulties: The user has a learning disability that limits their access to content that is presented in a way that requires a high level of literacy.")
      ),
      h4("Browser compatibility"),
      p("The browsers used were Edge Chromium and Chrome as these are standard in the DfE and its agencies. The operating system used was Windows."),
      br(),
      p("This statement was prepared on 25th April 2023."),
      p("This statement was last updated on 25th April 2023."),
      h3("Feedback"),
      p(
        "If you have any feedback on how we could further improve the accessibility of this application, please contact us at",
        a(href = "mailto:post16.statistics@education.gov.uk", "post16.statistics@education.gov.uk")
      )
    )
  )
}

support_links <- function() {
  tabPanel(
    "Support and feedback",
    gov_main_layout(
      gov_row(
        column(
          width = 12,
          h2("Give us feedback"),
          "This dashboard is a new service that we are developing. If you have any feedback or suggestions for improvements, please submit them using our ",
          a(
            href = "https://forms.office.com/Pages/ResponsePage.aspx?id=yXfS-grGoU2187O4s0qC-e0qiSlFLgZOtXP2V2ICM4NUNUFGQ09IWTg3UllJUTZUSEdYQUo4T1ZJRC4u",
            "feedback form", .noWS = c("after")
          ), ".", br(),
          "If you spot any errors or bugs while using this dashboard, please screenshot and email them to ",
          a(href = "mailto:post16.statistics@education.gov.uk", "post16.statistics@education.gov.uk", .noWS = c("after")), ".",
          br(),
          h2("Find more information on the data"),
          "The data used to produce the dashboard, along with methodological information can be found at the ",
          a(href = "https://explore-education-statistics.service.gov.uk/find-statistics/level-2-and-3-attainment-by-young-people-aged-19", "Level 2 and 3 attainment age 16 to 25 publication", .noWS = c("after")),
          ".",
          br(),
          h2("Contact us"),
          "If you have questions about the dashboard or data within it, please contact us at ",
          a(href = "mailto:post16.statistics@education.gov.uk", "post16.statistics@education.gov.uk", .noWS = c("after")), br(),
          h2("See the source code"),
          "The source code for this dashboard is available in our ",
          a(href = "https://github.com/dfe-analytical-services/attainment-age-19", "GitHub repository", .noWS = c("after")),
          ".",
          br(),
          br(),
          br(),
          br(),
          br(),
          br()
        )
      )
    )
  )
}
