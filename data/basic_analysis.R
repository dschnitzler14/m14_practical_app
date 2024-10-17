library(tidyverse)

data <- read.csv("~/github/m14_practical_analysis_app/data/dummy_blinking_calm_stress.csv", header = TRUE)

head(data)

data_with_average <- data %>%
  mutate(avg_rep = rowMeans(select(., rep1:rep3)))

data_averages <- data_with_average %>%
  group_by(State) %>%
  summarise(mean = mean(avg_rep),
            n = n(),
            sd = sd(avg_rep))

hist(data_with_average$avg_rep)

plot <- ggplot(data_averages, aes(x=State, y=mean)) +
  geom_bar(stat="identity", position=position_dodge()) +
  geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd), width=.2,
                position=position_dodge(.9)) +
  labs(title="Average Blinks per Minute Stress & Calm", 
       x="State", y = "Average BPM")+
  scale_fill_manual(values=c('black','lightgray'))+
  theme_classic()

t_test <- t.test(avg_rep ~ State, var.equal = TRUE, data = data_with_average)

