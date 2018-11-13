library(gdata)
library(dplyr)

file1 <- "C:\\newFiles\\dslam_in_rete_20_09_18.xlsx"
file2 <- "C:\\newFiles\\descr OPM_310818\\desc2.xlsx"
file3 <- "C:\\newFiles\\descr OPM_310818\\desc3.xlsx"
fogli1 <- 2
fogli2 <- 8
fogli3 <- 2
files <-c(file1,file2,file3)
fogli <-c(fogli1,fogli2,fogli3)
PERL <- "C:\\Perl64\\bin\\perl.exe"


filt_append <- function(df, files,sheets,PERL) {
  
  for(foglio in 1:sheets){
    ffdata = read.xls(files,sheet=foglio, perl=PERL)
    names(ffdata)
    B <- "5VC4"
    ind_sel <- which(grepl(B, ffdata$POLICY)) 
    filtrati <-slice(ffdata,ind_sel) %>% select(CLLI, OPM,PORTA, POLICY)
    df <- rbind(df, filtrati)
    
  }
  return (df)
}

def_db <- data.frame(matrix(ncol = 4, nrow = 0))
for(i in 1:1) { 
  db = filt_append(def_db,files[i],fogli[i], PERL)
}
  



