#Package 
library(tidyverse)
library(data.table)

## Parameters 
names(main_raw)

# Objective (A): Promote intra-regional trade and market integration of agricultural goods and inputs
# Result (A.I): Increased intra-regional trade of agricultural goods and inputs
# Indicator (A.I.1): Value of intra-regional trade of agricultural goods and inputs
# Metric: Growth rate of the value of intra-regional import and export of agricultural goods and inputs, at constant 2010 USD

year1 <- unique(main_raw$Q1.4.1.0_MReferenceYear1)
year1 <- 2022 
year2 <- unique(main_raw$Q1.4.2.0_MReferenceYear1)
year2 <- 2010
## Data Import 
glimpse(S1_IntraImport)
ai1My1 <- paste0("AI1_para1_",year1)
ai1My1 <- S1_IntraImport %>% 
  reframe(Year = year1, 
            HS4_code = substr(Q1.4.1.4_agriProducths4, 1, 4),
            Goods  =  trimws(sub(".+?-\\s*", "", Q1.4.1.4_agriProducths4)),
            CountryOrigin = Q1.4.1.e_CountryOrigin,
          AppliedTax = Q1.4.1.j_AppliedCustomDuty, ## droit de douane
          AppliedRest = Q1.4.1.m_Applied_other_import_restriction,
          ExportRestriction = Q1.4.1.n_Applied_other_import_restrictionS, ## Text
            Value_M = Q1.4.1.h_Import_value,
            UnitValue_M = ifelse(Q1.4.1.i_Value_Unit=="other",Q1.4.1.i_Value_Unit_other,Q1.4.1.i_Value_Unit),
            Quantity_M = Q1.4.1.f_Import_quantity,
            UnitQuatity_M = ifelse(Q1.4.1.g_Quantity_Unit=="other",Q1.4.1.g_Quantity_Unit_other,Q1.4.1.g_Quantity_Unit),
          Quantity_M_KG = ifelse(UnitQuatity_M %in% c(2,4), Quantity_M, 
                                 ifelse(UnitQuatity_M==1, Quantity_M*1000, 
                                        ifelse(UnitQuatity_M==3, Quantity_M*100,NA) ))
          
          )

#ai1My2 <- paste0("AI1_para1_",year2)
ai1My2 <- S1_IntraImport %>% 
  reframe(Year = year2, 
          HS4_code = substr(Q1.4.1.4_agriProducths4, 1, 4),
          Goods  =  trimws(sub(".+?-\\s*", "", Q1.4.1.4_agriProducths4)),
          CountryOrigin = Q1.4.2.e_CountryOrigin,
          Value_M = Q1.4.2.h_Import_value,
          UnitValue_M = ifelse(Q1.4.2.i_Value_Unit=="other",Q1.4.2.i_Value_Unit_other,Q1.4.2.i_Value_Unit),
          Quantity_M = Q1.4.2.f_Import_quantity,
          UnitQuatity_M = ifelse(Q1.4.2.g_Quantity_Unit=="other",Q1.4.2.g_Quantity_Unit_other,Q1.4.2.g_Quantity_Unit),
          Quantity_M_KG = ifelse(UnitQuatity_M %in% c(2,4), Quantity_M, 
                                 ifelse(UnitQuatity_M==1, Quantity_M*1000, 
                                        ifelse(UnitQuatity_M==3, Quantity_M*100,NA) ))

  )

## Data Export 
glimpse(S1_IntraExport)
#ai1Xy1 <- paste0("AI1_para3_",year1)
ai1Xy1 <- S1_IntraExport %>% 
  reframe(Year = year1, 
          HS4_code = substr(Q1.5.1.4_agriProducths4, 1, 4),
          Goods  =  trimws(sub(".+?-\\s*", "", Q1.5.1.4_agriProducths4)),
          CountryDestination = Q1.5.1.e_CountryOrigin,
          AppliedTax = Q1.5.1.j_AppliedCustomDuty, ## droit de douane
          AppliedRest = Q1.5.1.m_Applied_other_Export_restriction,
          ExportRestriction = Q1.5.1.n_Applied_other_Export_restrictionS, ## Text
          Value_X = Q1.5.1.h_Export_value, # Assume currency identique 
          UnitValue_X = ifelse(Q1.5.1.i_Value_Unit=="other",Q1.5.1.i_Value_Unit_other,Q1.5.1.i_Value_Unit),
          Quantity_X = Q1.5.2.f_Export_quantity,
          UnitQuatity_X = ifelse(Q1.5.1.g_Quantity_Unit=="other",Q1.5.1.g_Quantity_Unit_other,Q1.5.1.g_Quantity_Unit),
          Quantity_X_KG = ifelse(UnitQuatity_X %in% c(2,4), Quantity_X, 
                                 ifelse(UnitQuatity_X==1, Quantity_X*1000, 
                                        ifelse(UnitQuatity_X==3, Quantity_X*100,NA) ))
  )
ai1Xy1 <- data.table(ai1Xy1)
#ai1My2 <- paste0("AI1_para1_",year2)
glimpse(ai1Xy2)
ai1Xy2 <- S1_IntraExport %>% 
  reframe(Year = year2, 
          HS4_code = substr(Q1.5.1.4_agriProducths4, 1, 4),
          Goods  =  trimws(sub(".+?-\\s*", "", Q1.5.1.4_agriProducths4)),
          CountryDestination = Q1.5.2.e_CountryOrigin,
          Value_X = Q1.5.2.h_Export_value,
          UnitValue_X = ifelse(Q1.5.2.g_Quantity_Unit=="other",Q1.5.2.g_Quantity_Unit_other,Q1.5.2.g_Quantity_Unit),
          Quantity_X = Q1.5.2.f_Export_quantity,
          UnitQuatity_X = ifelse(Q1.5.2.g_Quantity_Unit=="other",Q1.5.2.g_Quantity_Unit_other,Q1.5.2.g_Quantity_Unit),
          Quantity_X_KG = ifelse(UnitQuatity_X %in% c(2,4), Quantity_X, 
                                 ifelse(UnitQuatity_X==1, Quantity_X*1000, 
                                        ifelse(UnitQuatity_X==3, Quantity_X*100,NA) ))
  )
ai1Xy2 <- data.table(ai1Xy2)

ai1p5 <- mean(main_raw$Q1_2_exchangeRate, na.rm = T)

# IMPORT <- rbind(ai1My1,ai1My2)
# IMPORT$EXCHANGE_RATE <- ai1p5
# 
# EXPORT <- rbind(ai1Xy1,ai1Xy2)
# EXPORT$EXCHANGE_RATE <- ai1p5


# Define the parameters
# Parameter (1): Value of intra-regional imports of agricultural goods and inputs i by origin 0, for the reference period, in current local currency (vM_(i,o)^y)
# Parameter (2): Volume of intra-regional imports of agricultural goods and inputs i by origin 0, for the reference period, in metric ton (qM_(i,o)^y)
# Parameter (3): Value of intra-regional exports of agricultural goods and inputs j by destination d, for the reference period, in current local currency (vX_(j,d)^y)
# Parameter (4): Volume of intra-regional exports of agricultural goods and inputs j by destination d, for the reference period, in metric ton (qX_(j,d)^y)
# Parameter (5): Official exchange rate, local currency per US dollar, average annual value (ER^y)
# Compute the growth rate of the value of intra-regional import and export of agricultural goods and inputs

#' Output samples 
library(readr)
Ag_goods_and_inputs_exports <- read_csv("Output Sample/Ag_goods_and_inputs_exports.csv")
glimpse(Ag_goods_and_inputs_exports)

library(openxlsx)
# Create a new Excel workbook
wb <-NULL
wb <- createWorkbook()

addWorksheet(wb, sheetName = "IMPORT-y1")
writeData(wb, sheet = "IMPORT-y1",ai1My1) 
addWorksheet(wb, sheetName = "IMPORT-y2")
writeData(wb, sheet = "IMPORT-y2",ai1My2) 

addWorksheet(wb, sheetName = "EXPORT-y1")
writeData(wb, sheet = "EXPORT-y1",ai1Xy1) 
addWorksheet(wb, sheetName = "EXPORT-y2")
writeData(wb, sheet = "EXPORT-y2",ai1Xy2) 

saveWorkbook(wb, paste0(output,"/Objective_A_I_1_SEN.xlsx"), overwrite = TRUE)


