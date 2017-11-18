# Project Proposal - Police Shootings

Conner Ardman, Hari Kaushik, Tyler Van Brocklin, Molly Donohue
Group AC3

---
## Project Description

We are working with a data set pertaining to police shootings of civilians (where a police, in their line of duty, shot and killed a civilian). The dataset contains a great deal of information about each shooting (such as the location, if the civilian was carrying a weapon, whether or not a body camera was active, etc.). We will access it from the Washington Post github account. According to their github readme file, the data is collected by &quot;culling local news reports, law enforcement websites and social media and by monitoring independent databases such as Killed by Police and Fatal Encounters&quot;. The Post did some additional data collection in addition to this. The data starts in January 1st, 2015 and is updated nearly daily. There have been 2820 killings in this time period.

We will access the data from this [link.](https://github.com/washingtonpost/data-police-shootings/blob/master/fatal-police-shootings-data.csv)

We will also access Census data to get the projected population of every town. This data is collected by the government to have an understanding of the population of the United States. This information will help us better understand the impact that police shootings are having on different communities (i.e. shootings per capita). We will access this data from [here.](https://www.census.gov/data/datasets/2016/demo/popest/total-cities-and-towns.html)

### Target Audience

Our target audience is federal legislators, particularly members of the U.S Congress in the House and Senate. These legislators have the power to fund and enact laws that enforce local police departments have proper training to avoid this high number of police deaths.

### Key Questions for Audience

1. What is the scope of police shootings in the US, and how have they changed since 2015? By scope we mean who are the affected groups by race, how frequently do killings occur, and how frequently was the victim fleeing or unarmed.

2. Do police act differently when they are wearing a body camera?

3. Where do police killings occur? Is the location of people killing proportionate to the population of the city.

We believe that by answering these questions, we can assist these federal legislators in the process of better allocating funds towards fighting this problem.

### Visuals

Our final project will include various visualizations of aggregated data. Among these visualizations, we&#39;d like to have a **map** of the country when you first open the URL. The map will have an overlay of all police killings and allow users to adjust the time frame to include or exclude certain time periods. Among the time scale, we&#39;d also like to include filters to look for trends and better understand the data. Some of these filters may include view by race, filter whether the officer had a body camera, and might display different colors based off the subject&#39;s weapon.

Another visualization that would be useful to include in our report would be a **pictograph** representing the demographics of victims of police shootings. A pictograph does a great job of demonstrating the enormity of the issue and different keys can allow it to show proportions effectively as well.

Finally, we will also use a **histogram** to show the distribution of the shootings over the year. On this page, users will also be allowed to select individual states in order to visualize the difference in the number of shootings by state.

---
## Technical Description

The format of our final project will be a **Shiny app**. We will be reading in our police shootings data from a . **csv file**. The shooting data is updated extremely frequently so we are going to use the **rcurl** package to refresh the data every time the page is loaded.  The census data is not updated every day so we will only read that in one time.

To wrangle the data we will need to **reformat names** that are &quot;TK TK&quot; (this is a placeholder being using for unknown names). We will also need to **replace the race abbreviation** to the corresponding key value for example &quot;W&quot; will be changed to &quot;White&quot;. We will want to **find the corresponding** latitude and longitude for given the city name for our map.  Finally, we will then need to **join** this data together with the Census data.

We will use a **new library** called rcurl to handle getting the fresh data from the Washington post github. Every time the app is opened we will do this. Shiny is new to us so that will be another new library.

We do not have any plans at this point to apply machine learning to our data. We anticipate it will be hard to apply the data about whether or not the victim was attacking or threatening the police officer. A police officer that shoots and kills someone is likely to almost always say they were threatened, to justify their actions. Applying meaning to this data will have to be handled carefully.

We will however be performing **statistical analysis** in order to determine the statistical significance of the effect of body cameras. Additionally, we can determine statistically if some cities have larger police shooting problems (higher per capita shooting rate) than others. This information along with our data visualizations should be adequate enough to answer the questions of our stakeholders