library(gdata)
library(dplyr)
fogli1 <- 2
file1 <- "C:\\newFiles\\dslam_in_rete_20_09_18.xlsx"
def_db <- data.frame(matrix(ncol = 4, nrow = 0))
PERL <- "C:\\Perl64\\bin\\perl.exe"
for(foglio in 1:fogli1){
  ffdata <- read.xls(file1,sheet=foglio, perl=PERL)
  names(ffdata)
  B <- "5VC4"
  ind_sel <- which(grepl(B, ffdata$POLICY)) 
  filtrati <-slice(ffdata,ind_sel) %>% select(CLLI, OPM,PORTA, POLICY)
  def_db <- rbind(def_db, filtrati)
}
