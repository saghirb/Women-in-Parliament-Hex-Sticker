# Women in Parliament Hex Sticker & Data

**Use the "Women in Parliament" data teach data wrangling and data analysis in 
[R](https://r-project.org). It will stimulate interesting data driven analyses 
and discussions. It has a hex sticker too ;)**

## Women in Parliament Hex Sticker

<img src="images/Women_in_Parliament_hex.svg" alt="Women in Parliament Hex Sticker" width="400"> 

**Download:** [PNG (754x873)](https://github.com/saghirb/Women-in-Parliament-Hex-Sticker/raw/master/images/Women_in_Parliament_hex.png) or 
[SVG](https://github.com/saghirb/Women-in-Parliament-Hex-Sticker/blob/master/images/Women_in_Parliament_hex.svg).

### Bonus Image

<img src="images/Women_in_Parliament_rect.svg" alt="Women in Parliament Hex Sticker" height="400"> 

**Download:** [PNG (3508x2480)](https://github.com/saghirb/Women-in-Parliament-Hex-Sticker/raw/master/images/Women_in_Parliament_rect.png) or 
[SVG](https://github.com/saghirb/Women-in-Parliament-Hex-Sticker/blob/master/images/Women_in_Parliament_rect.svg).

---

## World Bank "Women in Parliament" Data

The raw data for *"Proportion of seats held by women in national parliaments"* 
(_"single or lower parliamentary chambers only"_) by can be directly downloaded from:

+ https://data.worldbank.org/indicator/SG.GEN.PARL.ZS 

As part of its "open data" mission the World Bank kindly offers *"free and open access to 
global development data"* licensed under the "Creative Commons Attribution 4.0 (CC-BY 4.0)".

### Source Data

The data originates from the ["Inter-Parliamentary Union" (IPU)](https://www.ipu.org/)
which provides an *"Archive of statistical data on the percentage of women in 
national parliaments"* going back to 1997 on a monthly basis:

+ http://archive.ipu.org/wmn-e/classif-arc.htm

The World Bank data is for “single or lower parliamentary chambers only”, while 
the IPU also presents data for “Upper Houses or Senates”. Moreover, the IPU provides 
the actual numbers used to calculate the percentages (which the World Bank does not).
The data has to be scraped from the IPU website (please check the `robots.txt` file
first).

---

## Importing the Data into R

The data can be imported into R using the `wbstats` package or by reading in the CSV file
available from the World Bank's website.

### R `wbstat` package

The R package [`wbstats`](https://cran.r-project.org/web/packages/wbstats/) provides
access to World Bank's indicator data. Use the following code to get the women in 
parliament data:
```
library(wbstats)
WiP <- library(wbstats)
```

### Importing the Raw Data into R

First download the latest `CSV` file from:

+ https://data.worldbank.org/indicator/SG.GEN.PARL.ZS 

Below I will refer to this file as "`WiP-Data.csv`" but please use the actual
file name that you save it as.

#### Using `data.table`

```
library(data.table)
wipdt <- fread("WiP-Data.csv",
               skip = 4, header = TRUE, check.names=TRUE)
WP <- melt(wipdt,
           id.vars = grep("Name|Code", names(wipdt), value = TRUE),
           measure = patterns("^X"),
           variable.name = "YearC",
           value.name = c("pctWiP"),
           na.rm = TRUE)
WP[, Year:=as.numeric(gsub("[^[:digit:].]", "",  YearC))][
   , YearC:=NULL]
```

#### Using `tidyverse`

```
library(readr)
library(dplyr)
library(tidyr)
wiptv <- read_csv("WiP-Data.csv", skip = 4) 
names(wiptv) <- make.names(names(wiptv))
wipTidy <- wiptv %>% 
    gather(key=YearC, value=pctWiP, starts_with("X"), na.rm=TRUE) %>% 
    mutate(Year = parse_number(YearC)) %>% 
    select(-YearC)
```

---

## R Guides Using Women in Parliament Data

Use the following R guides to get ideas on how to teach using the women in parliament 
data:

+ [Women in Parliament -- data.table Edition (PDF)](https://github.com/saghirb/WiP-rdatatable/raw/master/doc/WiP-rdatatable.pdf)
    + GitHub Repo: https://github.com/saghirb/WiP-rdatatable
+ [Women in Parliament – Tidyverse Edition (PDF)](https://github.com/saghirb/WiP-tidyverse/raw/master/doc/WiP-tidyverse.pdf)
    + GitHub Repo: https://github.com/saghirb/WiP-tidyverse

---

## Acknowledgements

The images were create by [Marina Costa](https://cargocollective.com/marinacostaportfolio/ABOUT) 
guided by [Andreia Carlos](https://github.com/agrou) and myself. 

You can view Marina's great portfolio at:

+ https://cargocollective.com/marinacostaportfolio

*Thank you* Marina and Andreia as it was really nice to work with you both.
