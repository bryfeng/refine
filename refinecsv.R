refine <- read.csv("refine.csv")

library(dplyr)
library(magrittr)
library(tidyr)
colnames(refine)
refine <- rename(refine[1], "Phillips" = "phillips")
refine$company %<>% tolower()
refine <- refine %<>% 
  mutate(company = replace(company, company %in% c("philips", "phllips", "phillps", "fillips", "phlips"), "phillips")) %>% 
  mutate(company = replace(company, company %in% c("ak zo", "akz0"), "akzo"))%>% 
  mutate(company = replace(company, company %in% c("ak zo", "akz0"), "akzo"))%>% 
  mutate(company = replace(company, company %in% c("unilver"), "unilever"))

refine <- refine %>%
  mutate("product_code" = substr(Product.code...number,1,1))%>%
  mutate("product_number" = substr(Product.code...number,3,5))


refine <-mutate(refine,"product_category" = ifelse(product_code == "p","Smartphone",ifelse(product_code == "x","Laptop",ifelse(product_code == "v","TV","Tablet"))))


refine <-mutate(refine, "full_address" = paste(address,city,country, sep = ","))

refine <- mutate(refine,company_philips = as.numeric((company == "philips")))
refine <- mutate(refine,company_akzo = as.numeric((company == "akzo")))
refine <- mutate(refine,company_van = as.numeric((company == "van houten")))
refine <- mutate(refine,company_unilever = as.numeric((company == "unilever")))
refine <- mutate(refine,product_smartphone = as.numeric((product_code == "p")))
refine <- mutate(refine,product_tv = as.numeric((product_code == "v")))
refine <- mutate(refine,product_laptop = as.numeric((product_code == "x")))
refine <- mutate(refine,product_tablet = as.numeric((product_code == "q")))

write.csv(refine,file = "refine_clean.csv")

