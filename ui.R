# Required packages
library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(bslib)
library(rsconnect)
library(maps)
source("Summary.R")

# MODIFYING DATA
earthquake_data <- read.csv('https://raw.githubusercontent.com/info-201b-sp23/exploratory-analysis-Ncumic/main/earthquake_data.csv')
earthquake_data_modified <- select(earthquake_data, -c("title","net", "nst", "dmin", "gap", "magType", "depth"))
earthquake_data_modified$Year <- as.integer(format(as.POSIXct(earthquake_data_modified$date, format = "%d-%m-%Y %H:%M"), "%Y"))

# THEME SET
Viz_theme <- bs_theme(
  bg = "#0b3d91", # background color
  fg = "white", # foreground color
  primary = "#FCC780", # primary color
)
# Update BootSwatch Theme
Viz_theme <- bs_theme_update(Viz_theme, bootswatch = "journal")

Title <- h1("Earthquake Data Work", align = "center")


# 1_SECTION
Plot_Description_1 <- p("This is a world map of all magnitudes of earthquakes and their location. It helps people understand
                              where a majority of earthquakes take place and where certain magnitudes are more commen then others. This can help dispel
                              fear related to earthquakes while keeping people informed of the dangers.")

Widget_1 <- sliderInput(inputId = "Variables",
                             label = h3("Magnitude Range"),
                             min = 6,
                             max = 9.5,
                             step = 0.1,
                             value = c(6,6.5)
)

Plot_1 <- mainPanel(
  plotlyOutput(outputId = "Plot_Magnitude")
)

Magnitude_TAB <- tabPanel("Magnitude VIZ",
                       sidebarLayout(
                         sidebarPanel(
                           # ADD WIDGET HERE
                           Widget_1,
                           Plot_Description_1
                         ),
                         Plot_1
                       )
)

# 2_SECTION

Plot_Description_2 <- p("This chart displays the overall accuracy a country has in estimating
 earthquake magnitudes from 2001 to 2020. It shows patterns including variations
 in accuracy among countries and accuracy over time, and individual country trends. This
 chart helps inform how accurate reads on earthquakes truely are.")

Widget_2 <- selectInput(inputId = "country1",
            label = "Country:",
            choices = unique(CountryAccuracy$country)
)

Widget_2.1 <- selectInput(inputId = "country2",
              label = "Country:",
              choices = unique(CountryAccuracy$country)
)

Plot_2 <- mainPanel(
  plotlyOutput("Plot_Accuracy")
)

Accuracy_TAB <- tabPanel(
  "Accuracy VIZ",
  sidebarLayout(
    sidebarPanel(
      Widget_2,
      Widget_2.1,
      Plot_Description_2
    ),
    Plot_2
  )
)



# 3_SECTION

eq_df <- read.csv("https://raw.githubusercontent.com/info-201b-sp23/exploratory-analysis-Ncumic/main/earthquake_data.csv",
                  stringsAsFactors = FALSE)
Plot_Description_3 <- p("This is a world map of all earthquakes around the world, what this Vizualization does is
inform people of which of these earthquakes caused water related accidents like tsunamis. This helps people understand where these forms of
earthquakes happen and where certain measures should be taken to lessen the damage")

Widget_3 <- selectInput("country", "Select a Country:", choices = unique(eq_df$country))

Tsunami_TAB <- tabPanel(
  "Tsunamis VIZ",
  sidebarLayout(
    sidebarPanel(
      Widget_3,
      Plot_Description_3
    ),
    mainPanel(
      plotlyOutput("plot")
    )
  )
)

SUMMARY_Tab <- tabPanel("Data Summary",
                        h2("Takeaways"),
                        h4("1"),
                        p("From the Magnitude Visualization, it is evident that the circum-Pacific seismic belt exhibits a significantly higher frequency of intense magnitude earthquakes compared to other regions. The visualization highlights a concentrated cluster of seismic activity along this belt, indicating the presence of active tectonic plate boundaries. This belt encompasses several subduction zones, where one tectonic plate is forced beneath another, leading to intense seismic energy release. Consequently, this region experiences a higher occurrence of earthquakes with magnitudes exceeding 8 on the Richter scale. The concentration of such high magnitude earthquakes around the circum-Pacific seismic belt underlines the significant seismic hazard potential and the need for increased vigilance and preparedness in the areas within and surrounding this belt."),
                        h4("2"),
                        p("Turning to the Accuracy Visualization, it reveals that the Solomon Islands demonstrated the most accurate average estimation (approximately 99.9) of earthquake intensities in 2022. This suggests that the seismic monitoring and intensity estimation systems in the Solomon Islands were particularly reliable and precise during that period. On a broader timeline analysis, Tajikistan stood out as having the highest average accuracy with a value of 97.22222. This means that the intensity estimations of earthquakes in Tajikistan, on average, were relatively accurate throughout the timeline under consideration. These findings highlight the importance of continuous improvement in earthquake intensity estimation techniques and the need to share best practices to enhance accuracy across different regions. Accurate intensity estimations play a crucial role in assessing the potential impact of earthquakes, informing response efforts, and facilitating effective disaster management."),
                        h4("3"),
                        p("In terms of tsunamis, the Pacific Ocean remains one of the most dangerous regions worldwide. The Tsunamis Visualization underscores this fact, revealing that tsunamis are predominantly generated by earthquakes located in areas surrounding the Pacific Ocean. The visualization indicates a clear association between seismic activity along subduction zones within the circum-Pacific seismic belt and the occurrence of tsunamis. The Pacific Ocean has witnessed some of the most catastrophic tsunamis in history, including the devastating 2004 Indian Ocean tsunami and the destructive 2011 Tohoku tsunami. These tsunamis demonstrated the immense destructive power of seismic events within the Pacific region and their potential to inflict widespread devastation along coastlines. The visualization reinforces the urgent need for robust tsunami early warning systems, effective evacuation plans, and public education programs in vulnerable coastal communities surrounding the Pacific Ocean to minimize loss of life and property in the face of these natural hazards."),

                        h2("Most Important Insight"),
                        p("All the visualizations and analysis have revealed the high extent of the dangers of the circum-Pacific seismic belt. This area is experiencing the highest frequency of intense magnitude earthquakes with magnitudes exceeding 8. These large magnitude earthquakes can cause extensive damage to infrastructure, trigger landslides, and potentially generate tsunamis. The plot does indicate that tsunamis are predominantly generated by earthquakes located in areas surrounding the Pacific Ocean. This implies that the circum-Pacific seismic belt is one of the most dangerous seismic zones on Earth, and it’s necessary to enhance protection measures among these areas. "),

                        h2("Broader Implications"),
                        p("The Circum-Pacific Seismic Belt, also known as the Ring of Fire, is a highly active region that encircles the Pacific Ocean. It’s dangerous due to its propensity for intense seismic activity and numerous geological hazards. The belt is characterized by the convergence of several tectonic plates, resulting in frequent earthquakes, volcanic eruptions, and the formation of deep ocean trenches."),
                        p("These insights about this area highlight the importance of understanding regional seismic activity, accurately estimating earthquake intensities, and recognizing the potential for tsunamis. Also, they emphasize the need for comprehensive tsunami early warning systems, evacuation plans, and public education in coastal regions bordering the Pacific to mitigate the potential devastating impact of tsunamis. By leveraging these findings, policymakers, scientists, and emergency management organizations can prioritize resources, develop effective strategies, and implement measures to mitigate the impact of earthquakes and tsunamis on vulnerable populations and infrastructure."),
                        p("The dangerous extent of the Circum-Pacific Seismic Belt underscores the need for proactive measures in terms of earthquake monitoring, early warning systems, disaster preparedness, and resilient infrastructure. Governments and communities in this region must prioritize efforts to enhance public awareness, emergency response capabilities, and the implementation of stringent building codes to minimize the impact of seismic events and ensure the safety and well-being of their populations.")
)

INTRO_Tab <- tabPanel("INTRODUCTION",
                      h2("Overview"),
                      p("This app explores the fascinating realm of worldwide earthquakes, aiming to uncover patterns, extract insights, and gain a deeper understanding of these seismic events that shape our planet. By analyzing a dataset spanning multiple regions and time periods, we embark on a journey to explore the nature of earthquakes and their impact on our world."),

                      h2("Main Questions"),
                      p("In the project, our main purpose is to determine the countries with the highest accuracy of estimating intensities of earthquakes, the continents or areas with the highest probabilities of getting tsunamis due to earthquakes, and the continents with the most intense magnitudes. These questions are crucial because understanding these patterns is crucial for disaster preparedness and risk assessment. To make the results more intuitive, we’ve built 3 interactive visualizations. "),

                      h2("Data"),
                      p("The dataset employed in this project consists of a comprehensive collection of worldwide earthquakes. The data was published by Chirag Chauhan, an interventional cardiologist at Denver Heart and Rose Medical Center. The data was collected through seismic sensors near/at the locations of earthquakes from all around the world. The data is a massive collaboration between seismic stations around the world by having their data gathered and shared in one location.
                        It provides an extensive record of seismic events across different regions and time periods. The dataset's appropriateness stems from its relevance to the study of earthquakes, enabling us to gain valuable insights into their characteristics, patterns, and impact on a global scale."),

                      h4("Data Link"),
                      p("https://www.kaggle.com/datasets/warcoder/earthquake-dataset"),

                      h2("Ethical Questions and Limitations"),
                      p("The earthquake dataset from Kaggle has the following problems and limitations such as limited coverage, incomplete data, and potential data quality issues. There are some features missing in the dataset, and the dataset only includes the earthquakes that happened from 2001 to 2023. This implies the data can not represent the earthquakes that happen in all regions. Furthermore, this dataset is collected from multiple sources, which may be collected through different methods and standards. Thus, the data may lead to inconsistencies and issues. "),
                      p("One another main limitation is that the accuracy of earthquake data can be affected by the changes of monitoring technology and techniques over time. As the newest methods for detecting and measuring earthquakes are developed, the historical data may become less accurate and reliable compared to the more recent data."),
                      p("To minimize the impact of these restrictions, we cleaned up the dataset before doing the visualizations. All the NA values are removed to ensure the accuracy of the results to the utmost extent. "),
)

# MAIN UI TO CONNECT EVERYTHING
ui <- navbarPage(
  theme = Viz_theme,
  titlePanel(Title),
  INTRO_Tab,
  Magnitude_TAB,
  Accuracy_TAB,
  Tsunami_TAB,
  SUMMARY_Tab
)