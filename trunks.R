library(gdata)
library(dplyr)
PERL <- "C:\\Perl64\\bin\\perl.exe"
file1 <- "C:\\newFiles\\descr OPM_310818\\desc1.xlsx"
file2 <- "C:\\newFiles\\descr OPM_310818\\desc2.xlsx"
file3 <- "C:\\newFiles\\descr OPM_310818\\desc3.xlsx"
fogli1 <- 4
fogli2 <- 8
fogli3 <- 2
files <-c(file1,file2,file3)
fogli <-c(fogli1,fogli2,fogli3)



filt_append <- function(df, files,sheets,PERL) {
  for(foglio in 1:sheets){
    ffdata = read.xls(files,sheet=foglio, perl=PERL)
    names(ffdata)
    B <- "TRUNK"
    ind_sel <- which(grepl(B, ffdata$Description)) 
    filtrati <-slice(ffdata,ind_sel) %>% select(Node, Interface,Status, Description)
    df <- rbind(df, filtrati)
  }
  return (df)
}

def_db <- data.frame(matrix(ncol = 4, nrow = 0))
for(i in 1:3) { 
  db = filt_append(def_db,files[i],fogli[i],PERL)
}
  



