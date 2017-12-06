library(dplyr)
library(ggplot2)
library(plotly)

shooting.data <- read.csv("data.csv", stringsAsFactors = FALSE)

# Seperating data based off whether officer had bodycam
bodycam.false <- shooting.data %>% filter(body_camera == "False")
bodycam.true <- shooting.data %>% filter(body_camera == "True")



# Percentage of unarmed/armed suspects killed of officers WITH body cameras.
unarmed.bc.true <- bodycam.true %>% filter(armed == "unarmed")
unarmed.bc.true.perc <- round(nrow(unarmed.bc.true) / nrow(bodycam.true) * 100)
armed.bc.true.perc <- 100 - unarmed.bc.true.perc

# Plot
unarmed.bc.true.graph <- plot_ly(bodycam.true, 
                                 labels = ~c("Unarmed", "Armed"), 
                                 values = ~c(unarmed.bc.true.perc, armed.bc.true.perc), 
                                 type = 'pie') %>%
  layout(title = 'Unarmed Suspects Killed (with bodycams)',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

# Percentage of unarmed/armed suspects killed of officers WITHOUT body cameras.
unarmed.bc.false <- bodycam.false %>% filter(armed == "unarmed")
unarmed.bc.false.perc <- round(nrow(unarmed.bc.false) / nrow(bodycam.false) * 100)
armed.bc.false.perc <- round((nrow(bodycam.false) - nrow(unarmed.bc.false)) / nrow(bodycam.false) * 100)

# Plot
unarmed.bc.false.graph <- plot_ly(bodycam.false, 
                                  labels = ~c("Unarmed", "Armed"), 
                                  values = ~c(unarmed.bc.false.perc, armed.bc.false.perc), 
                                  type = 'pie') %>%
  layout(title = 'Unarmed Suspects Killed (without bodycams)',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))




# Percentage of fleeing/non fleeing suspects killed of officers WITH body cameras.
not.flee.bc.true <- bodycam.true %>% filter(flee == "Not fleeing")
not.flee.bc.true.perc <- round(nrow(not.flee.bc.true) / nrow(bodycam.true) * 100)
flee.bc.true.perc <- (100 - not.flee.bc.true.perc)

# Plot
flee.bc.true.plot <- plot_ly(bodycam.true, 
                                 labels = ~c("Didn't Flee", "Fleed"), 
                                 values = ~c(not.flee.bc.true.perc, flee.bc.true.perc), 
                                 type = 'pie') %>%
  layout(title = 'Fleeing Suspects Killed (with bodycams)',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

# Percentage of flee/not flee suspects killed of officers WITHOUT body cameras.
not.flee.bc.false <- bodycam.false %>% filter(flee == "Not fleeing")
not.flee.bc.false.perc <- round(nrow(not.flee.bc.false) / nrow(bodycam.false) * 100)
flee.bc.false.perc <- (100 - not.flee.bc.false.perc)

# Plot
flee.bc.false.plot <- plot_ly(bodycam.false, 
                             labels = ~c("Didn't Flee", "Fleed"), 
                             values = ~c(not.flee.bc.false.perc, flee.bc.false.perc), 
                             type = 'pie') %>%
  layout(title = 'Fleeing Suspects Killed (with bodycams)',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
