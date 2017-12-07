# Police Shootings In The United States

Conner Ardman, Hari Kaushik, Tyler Van Brocklin, Molly Donohue

Group AC3

[Project Proposal](proposal.md)

---
## Project Description

We are working with a data set pertaining to police shootings of civilians (where a police, in their line of duty, shot and killed a civilian). The dataset contains a great deal of information about each shooting (such as the location, if the civilian was carrying a weapon, whether or not a body camera was active, etc.). We are accessing it from the Washington Post Github account. According to their Github readme file, the data is collected by &quot;culling local news reports, law enforcement websites and social media and by monitoring independent databases such as Killed by Police and Fatal Encounters&quot;. The Post did some additional data collection in addition to this. The data starts in January 1st, 2015 and is updated nearly daily. There have been over 2820 killings in this time period.

The raw data can be accessed from this [link.](https://github.com/washingtonpost/data-police-shootings/blob/master/fatal-police-shootings-data.csv)

We are also using United States Census data to get the populations of every town. This data is collected by the government to have an understanding of the population of the United States. This information will help us better understand the impact that police shootings are having on different communities (i.e.shootings per capita). This data comes from [here.](https://www.census.gov/data/datasets/2016/demo/popest/total-cities-and-towns.html)

### Target Audience

Our target audience is federal legislators, particularly members of the U.S Congress in the House and Senate. These legislators have the power to fund and enact laws that enforce local police departments have proper training to avoid this high number of police deaths.

### Key Questions for Audience

1. What is the scope of police shootings in the US, and how have they changed since 2015? By scope we mean who are the affected groups by race, how frequently do killings occur, and how frequently was the victim fleeing or unarmed.

2. Do police act differently when they are wearing a body camera?

3. Where do police killings occur? Is the location of people killing proportionate to the population of the city/state.

We believe that by answering these questions, we can assist these federal legislators in the process of better allocating funds towards fighting this problem.

### Visuals

Our final project contains multiple visuals in order to allow users to quickly understand the dataset. First, we address the scope of the problem by mapping out the shootings across the United States. Additionally, we have analyzed  this information to determine that states (for the most part) are facing this problem at the same rate proportionate to their populations.

Next, we provide an intuitive user interface to allow for a breakdown of victims based on qualities such as race and gender. This visual is extremely important in pinpointing the underlying cause of our problem.

Finally, we will utilize pie graphs to demonstrate the difference of behavior between police officers with and without body cameras on. This information allows us to determine the effectiveness of this popular solution.

---
## Technical Description

The format of our final project is a **Shiny app**. We are reading in our police shootings data from a . **csv file**. The shooting data is updated extremely frequently so we refresh the data every time the page is loaded. The census data is not updated every day so we only read that in one time.

To wrangle the data we needed to **reformat names** that are &quot;TK TK&quot; (this is a placeholder being using for unknown names). We also needed to **replace the race abbreviation** to the corresponding key value for example &quot;W&quot; is changed to &quot;White&quot;. We also needed to **find the corresponding** county for given the city name for our map.  Finally, we then needed to **join** this data together with the Census data.

---
## Conclusions

Looking at our maps and the relatively linear pattern to the graph of proportions by state, we have concluded that this issue is spread significantly across all of the states (There are of course outliers such as New York and New Mexico with significantly higher of lower proportions than average). For this reason, we believe that the issue is most relevant at the federal legislative level.

Overall, we have also found that this issue of police shootings is widespread amongst most of our factors. Additionally, we see no clear trend towards improving on this issue. There are however some very interesting data points. For example, police are significantly more likely to shoot a male than a female. Additionally, police are more likely to shoot someone who they claim was attacking them (however this could be due to the clear response bias associated with the officers not wanting to incriminate themselves. These data clearly demonstrate that this is a major issue that needs to be addressed on a federal level. Police (like all people) carry unconscious biases, and it is imperative to work towards legislation that minimizes these issues.


---
## Proposed Solutions

Given that the Police Shooting issue is spread across all states, impacts every part of the population, and the initial solution of using body cameras on police officers has had little effect thus far, there remains to be a huge improvement.

When body cameras are used, the video recordings belong to the government, and they are kept private. Many of the high profile police shootings were high-profile because a bystander recorded the incident on their phone and posted it online. With body cameras, the recordings will never be viral, and the truth of the incident is kept behind red tape. We propose that body cameras continue to be used, but that the data be made public.

For example, just today, a police officer was convicted for 20 years in jail for shooting an unarmed, fleeing, black male. There was a viral video in this case that demonstrates the police officer was acting out of line with the misbehavior of the victim. We need more videos like this, and more police officers to be punished based on body camera footage. 

--
Finally, we wanted to say that our thoughts are with the families of the victims of these police shootings, and we hope that legistlators will act quickly to come to a solution in this matter.