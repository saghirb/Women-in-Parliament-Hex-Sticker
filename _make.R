# Creating an image for the README file

# Setup
library(here)
library(pdftools)
library(magick)
library(magrittr)

# Temporary files to be used below for image creation.
pdfdt <- tempfile()
pdftv <- tempfile()
pngdt <- tempfile()
pngtv <- tempfile()

# Download the latest WiP guides from GitHub.
download.file("https://github.com/saghirb/WiP-rdatatable/raw/master/doc/WiP-rdatatable.pdf",
                       destfile = pdfdt)
download.file("https://github.com/saghirb/WiP-tidyverse/raw/master/doc/WiP-tidyverse.pdf",
              destfile = pdftv)

# Automatically create cropped image of the top of each WiP PDF guide.
pdf_convert(pdfdt, "png", pages = 1, dpi = 150, filenames = pngdt) %>%
  image_read() %>%
  image_crop(geometry_area(height = 300, 0, 0), repage = FALSE) %>%
  image_border(geometry = "4x4") %>%
  image_write(., path=here("images", "WiP-dt-head.png"), format="png")

pdf_convert(pdftv, "png", pages = 1, dpi = 150, filenames = pngtv) %>%
  image_read() %>%
  image_crop(geometry_area(height = 300, 0, 0), repage = FALSE) %>%
  image_border(geometry = "4x4") %>%
  image_write(., path=here("images", "WiP-tv-head.png"), format="png")
