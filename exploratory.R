## ---- exploratory.R
## ---- do some exploratory data analysis.

library(ggplot2)

data_m$reservation_type<-factor(reservation_type)
ggplot(data_m, aes(x=total)) + 
  geom_bar(aes(fill=factor(reservation_type)), position = "dodge")

ggplot(data_m, aes(x=total)) + 
  geom_bar(aes(fill=factor(technology)), position = "dodge")

ggplot(data_m, aes(x=actual_price, y=log(total)))+geom_point(aes(colour=technology)) +
  geom_smooth()

ggplot(data_m, aes(x=description, y=total)) + 
  geom_point(aes(colour=factor(technology))) + 
  scale_y_log10()

ggplot(data_m, aes(x=actual_price, y=recommended_price)) + 
  geom_point(aes(colour=total, size=factor(technology))) + 
  scale_colour_gradient(low = "darkblue", high="orange") + 
  theme_bw() + 
  xlab("Actual Price") + 
  ylab("Recommended Price") +
  geom_hline(yintercept=50, colour='orange', linetype="longdash") + 
  geom_vline(xintercept=50, colour='orange', linetype="longdash")+
  geom_abline(intercept = 0, colour='orange', linetype='longdash')

ggplot(data_m, aes(x=num_images, y=total)) + 
  geom_point(aes(colour=reservation_type,
                 size=factor(technology))) + 
  scale_colour_gradient(low = "darkblue", high="orange") + 
  theme_bw() + 
  xlab("Number of Images") + 
  ylab("Total Reservation") 


