## School Grading Walkthrough
# ui.R

library(dplyr)
library(shiny)
library(shinyjs)
library(rhandsontable)

shinyUI(
    fluidPage(
        useShinyjs(),
        fluidRow(
            column(8, offset = 2,

                # Introduction
                div(id = "intro",
                    br(),
                    h4("We're going to ask a series of questions about your school's academic
                        achievement, growth, and other indicators of school success."),
                    strong(p("We'll use your answers to project a grade under the new A-F
                        school grading system. When you are ready, click the button below.")),
                    actionButton("button1", label = "Go!")
                ),

                # Pool
                hidden(div(id = "pool",
                    hr(),
                    h4("First, we'll determine your school's grade pool for accountability purposes."),
                    br(),
                    selectInput("eoc", label = "Will your school have 30 students in grades 9 or above
                        test in a single EOC subject this school year?", choices = c("", "Yes", "No")),
                    br(),
                    htmlOutput("pool_determination"),
                    br(),
                    hidden(actionButton("button2", label = "Got it."))
                )),

                # Comprehensive Support
                hidden(div(id = "minimum_performance",
                    hr(),
                    h4("A success rate is the percentage of students who are on track or mastered,
                        aggregated across all subjects with at least 30 tests."),
                    br(),
                    selectInput("success_3yr", label = "What is your school's success rate?",
                        choices = c("", "Less than 20%", "Between 20% and 35%", "Above 35%")),
                    br(),
                    hidden(selectInput("tvaas_lag", label = "Did your school earn a TVAAS Composite Level 4 or 5 in 2016?",
                        choices = c("", "Yes", "No"))),
                    br(),
                    htmlOutput("comprehensive_determination"),
                    br(),
                    hidden(actionButton("button3", label = "Got it."))
                )),

                # Achievement
                hidden(div(id = "achievement",
                    hr(),
                    h4("About your school's achievement and growth on TNReady:"),
                    br(),
                    p("Using the table below, answer the following about your school's success rate,
                        success rate growth, TVAAS (All Students only), and subgroup growth."),
                    br(),
                    rHandsontableOutput("achievement_table"),
                    br(),
                    div(id = "done_ach",
                        p("When you are done, click the button below."),
                        actionButton("button4", label = "Done")
                    )
                )),

                # Readiness
                hidden(div(id = "readiness",
                    hr(),
                    h4("About your school's ACT and Graduation"),
                    br(),
                    selectInput("readiness_eligible", label = "Does your school have a graduating cohort of 30 or more students?",
                        choices = c("", "Yes", "No")),
                    br(),
                    hidden(div(id = "readiness_table_container",
                        p(strong("Readiness"), "refers to the percentage of students in your school's
                            graduating cohort who earned an ACT Composite score of 21 or higher.
                            Answer the following about your school's readiness."),
                        br(),
                        rHandsontableOutput("readiness_table")
                    )),
                    br(),
                    hidden(div(id = "done_readiness",
                        p("When you are done, click the button below."),
                        actionButton("button5", label = "Done")
                    ))
                )),

                # English Language Proficiency
                hidden(div(id = "elpa",
                    hr(),
                    h4("About your school's English Language Proficiency"),
                    br(),
                    selectInput("elpa_eligible", label = "Does your school have 10 or more students who took an English Language Proficiency Assessment?",
                        choices = c("", "Yes", "No")),
                    br(),
                    hidden(div(id = "elpa_table_container",
                        p("Schools are graded on the percentage of students who exit EL status
                            or met the growth standard on the English Language Proficiency Assessment.
                            Answer the following about your school's ELPA."),
                        br(),
                        rHandsontableOutput("elpa_table")
                    )),
                    br(),
                    hidden(div(id = "done_elpa",
                        p("When you are done, click the button below."),
                        actionButton("button6", label = "Done")
                    ))
                )),

                # Absenteeism
                hidden(div(id = "absenteeism",
                    hr(),
                    h4("About your school's chronic absenteeism"),
                    br(),
                    p(strong("Chronic absenteeism"), "is defined as the percentage of students who
                        are absent for 10% or more of a school year (18 days in a 180 day school year).
                        Answer the following about your school's chronic absenteeism."),
                    br(),
                    rHandsontableOutput("absenteeism_table"),
                    br(),
                    hidden(div(id = "done_absenteeism",
                        p("When you are done, click the button below."),
                        actionButton("button7", label = "Done")
                    ))
                ))

            )
        ),

        # Heat map
        hidden(div(id = "heatmap",
            fluidRow(
                column(8, offset = 2,
                    hr(),
                    tableOutput("heat_map")
                )
            )
        )),

        # Determinations
        hidden(div(id = "determinations",
            fluidRow(
                column(8, offset = 2,
                    hr(),
                    h4("Your School's Final Grade:"),
                    br(),
                    htmlOutput("determinations")
                )
            )
        )),

        fluidRow(
            column(8, offset = 2,
                hr(),
                p("Designed in", tags$a(href = "http://shiny.rstudio.com/", "Shiny"), "for the Tennessee Department of Education."),
                br(),
                br()
            )
        )
    )
)