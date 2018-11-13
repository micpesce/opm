library(gdata)
library(dplyr)
library(stringr)
file1 <- "C:\\newFiles\\descr OPM_310818\\RGA1.csv"
file2 <- "C:\\newFiles\\descr OPM_310818\\RGA2.csv"
file3 <- "C:\\newFiles\\descr OPM_310818\\RGA3.csv"
file4 <- "C:\\newFiles\\descr OPM_310818\\RGA4.csv"
file5 <- "C:\\newFiles\\descr OPM_310818\\RGA5.csv"
file6 <- "C:\\newFiles\\descr OPM_310818\\RGA6.csv"
file7 <- "C:\\newFiles\\descr OPM_310818\\RGA7.csv"
file8 <- "C:\\newFiles\\descr OPM_310818\\RGA8.csv"
file9 <- "C:\\newFiles\\descr OPM_310818\\RGA8.csv"
file10 <- "C:\\newFiles\\descr OPM_310818\\RF-RG.csv"
file11 <- "C:\\newFiles\\descr OPM_310818\\RGJ.csv"
file12 <- "C:\\newFiles\\descr OPM_310818\\KE.csv"
file13 <- "C:\\newFiles\\descr OPM_310818\\KBJ-KEJ.csv"
file14 <- "C:\\newFiles\\descr OPM_310818\\KV.csv"
file15 <- "C:\\newFiles\\descr OPM_310818\\KA-KB.csv"
files <-c(file1,file2,file3,file4,file5,file6,file7,file8,file9,file10,file11,file12,file13,file14,file15)



# Per ogni fie seleziona solo i record con le desc che contengono le stringhe in B,
# seleziona i campi richesti e li accoda in un unico df

filt_append <- function(df, filecsv) {
 
    ffdata = read.csv(filecsv, header=TRUE, sep=";")
    names(ffdata)
    B <- c("TRUNK", "TRK", "trunk","trk")
    ind_sel <- which(grepl(paste(B, collapse = "|"), ffdata$Description)) 
    filtrati <-slice(ffdata,ind_sel) %>% select(Node, Interface,Status, Description)
    df <- rbind(df, filtrati)
    return (df)
}


for(i in 1:length(files)) {
  ifelse(i==1,def_db <- data.frame(matrix(ncol = 4, nrow = 0)),def_db<-db)
  db = filt_append(def_db,files[i])
}

####

# modifica db inserendo una colonna TD che contiene la regexp data
db<-mutate(db,str_extract(db$Description, '[:alnum:]{6}/[:alnum:]{2}'))
names(db)[names(db) == 'str_extract(db$Description, "[:alnum:]{6}/[:alnum:]{2}")'] <- "TD"


lido = read.csv("C:\\newFiles\\descr OPM_310818\\estrazioneLTR.csv", header=TRUE, sep=";")
names(lido)[names(lido) == 'C_COD_FATT_TD'] <- "TD"

#scarta i record con td di formato non idoneo
scarti <- db %>% filter(db$TD == "000000/00" | db$TD == "XXXXXX/XX" | db$TD == "XXXXXX/YY")
write.csv(scarti, file = "C:\\newFiles\\descr OPM_310818\\scarti.csv")
#names(total)

#join lido e db opm su chiave td e scarto td inconsistenti
total <- merge(lido,db,by="TD") %>% filter(TD != "000000/00" & TD != "XXXXXX/XX" & TD != "XXXXXX/YY" )

#seleziona campi di interesse e scarica su file .csv
tabella <-total %>% select(TD,Node,Interface,Status,Description,C_TIPO,C_STATO,C_DUE_DATE,C_NUM_CANALI,C_COD_CAC,C_NOTE,C_DATA_ATTIV,C_TIPO_UTILIZZO,C_DIVERSIFICAZIONE,C_TIPO_INSTR,C_LIVELLO_PROT,C_PATH_CLASS,C_TOTAL_BPS_AVAIL,C_BPS_ASSIGNED,C_TIPO_SERVIZIO,C_CLASSE_SERVIZIO,C_CODICE_GRUPPO,C_VLANID,C_VLANID2)

write.csv(tabella, file = "C:\\newFiles\\descr OPM_310818\\td_opm.csv")
