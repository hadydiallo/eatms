## Import data 
library(readxl)

## Main-BeginGroups
main_raw <- read_excel("EATMS_dataRaw.xlsx", 
                            sheet = "The ECOWAS Agriculture Trade...")
## Section 0 Contributor ~ Begin Repeat 
contributeur2 <- read_excel("EATMS_dataRaw.xlsx", sheet = "Contributor2_data")

#Section 1
  ##  Tarrif line - Begin Repeat 
  S1_tarifline <- read_excel("EATMS_dataRaw.xlsx", sheet = "table_1_3_1")
  ##  1.4 Intra-Regional Imports of Agricultural Products - Begin Repeat 
  S1_IntraImport <- read_excel("EATMS_dataRaw.xlsx", sheet = "table_1_4_1")
  ##  1.4 Intra-Regional Exports of Agricultural Products - Begin Repeat 
  S1_IntraExport <- read_excel("EATMS_dataRaw.xlsx", sheet = "table_1_5_1")
#Section 2 
  ##  2.1 Applied Tariff, and Import Restriction Measures and Documentation - Begin Repeat 
  S2_AppliedTariffImport <- read_excel("EATMS_dataRaw.xlsx", sheet = "table_2_1_1")
  ##  2.1 Applied Tariff, and Import Restriction Measures and Documentation - Begin Repeat 
  S2_AppliedTariffExport <- read_excel("EATMS_dataRaw.xlsx", sheet = "table_2_2_1")
  
#Section 3 
  ## 3. Customs Administration and Cross-Border Infrastructures 
  S3_CustomAdmin <- read_excel("EATMS_dataRaw.xlsx", sheet = "table_3")
  
# Section 4 , no begin repeat 
#Section 5 
  ## 5.1 Agricultural Related Trade Facilitation, SPS and TBT Committees
  S5_ARTFCommittees <- read_excel("EATMS_dataRaw.xlsx", sheet = "table_5_1")  
  ## 5.2 Agricultural Trade Related SPS and TBT Legislations
  S5_ATRSPS_legislations <- read_excel("EATMS_dataRaw.xlsx", sheet = "table_5_2")  
  ## 5.3 Agricultural Trade Related NTMs Implementation Agencies 
  S5_ATRNTMsAgencies <- read_excel("EATMS_dataRaw.xlsx", sheet = "Q5.3.b_listKeyAgencyMonitor")  
  ## 5.4 Agricultural Trade Related Dispute Resolution Bodies 
  S5_ATRDRBodies <- read_excel("EATMS_dataRaw.xlsx", sheet = "table_6_4")  
  ## 5.5 Consultation mechanism on agricultural trade related NTMs
  S5_ConsultationRNTMs <- read_excel("EATMS_dataRaw.xlsx", sheet = "table_6_5")  
  ## 5.6 Training of public and private actors on agricultural trade related NTMs
  S5_TrainingRNTMs <- read_excel("EATMS_dataRaw.xlsx", sheet = "table_6_6")  
  
#Section 6, no begin repeat 

