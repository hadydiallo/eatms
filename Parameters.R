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
            Value_M = Q1.4.1.h_Import_value,
            UnitValue_M = ifelse(Q1.4.1.i_Value_Unit=="other",Q1.4.1.i_Value_Unit_other,Q1.4.1.i_Value_Unit),
            Quantity_M = Q1.4.1.f_Import_quantity,
            UnitQuatity_M = ifelse(Q1.4.1.g_Quantity_Unit=="other",Q1.4.1.g_Quantity_Unit_other,Q1.4.1.g_Quantity_Unit),
          )
ai1My2 <- paste0("AI1_para1_",year2)
ai1My2 <- S1_IntraImport %>% 
  reframe(Year = year2, 
          HS4_code = substr(Q1.4.1.4_agriProducths4, 1, 4),
          Goods  =  trimws(sub(".+?-\\s*", "", Q1.4.1.4_agriProducths4)),
          CountryOrigin = Q1.4.2.e_CountryOrigin,
          Value_M = Q1.4.2.h_Import_value,
          UnitValue_M = ifelse(Q1.4.2.i_Value_Unit=="other",Q1.4.2.i_Value_Unit_other,Q1.4.2.i_Value_Unit),
          Quantity_M = Q1.4.2.f_Import_quantity,
          UnitQuatity_M = ifelse(Q1.4.2.g_Quantity_Unit=="other",Q1.4.2.g_Quantity_Unit_other,Q1.4.2.g_Quantity_Unit)
  )

## Data Export 
glimpse(S1_IntraExport)
ai1Xy1 <- paste0("AI1_para3_",year1)
ai1Xy1 <- S1_IntraExport %>% 
  reframe(Year = year1, 
          HS4_code = substr(Q1.5.1.4_agriProducths4, 1, 4),
          Goods  =  trimws(sub(".+?-\\s*", "", Q1.5.1.4_agriProducths4)),
          CountryDestination = Q1.5.1.e_CountryOrigin,
          Value_X = Q1.5.1.h_Export_value,
          UnitValue_X = ifelse(Q1.5.1.i_Value_Unit=="other",Q1.5.1.i_Value_Unit_other,Q1.5.1.i_Value_Unit),
          Quantity_X = Q1.5.2.f_Export_quantity,
          UnitQuatity_X = ifelse(Q1.5.1.g_Quantity_Unit=="other",Q1.5.1.g_Quantity_Unit_other,Q1.5.1.g_Quantity_Unit),
  )
ai1My2 <- paste0("AI1_para1_",year2)
ai1Xy2 <- S1_IntraExport %>% 
  reframe(Year = year2, 
          HS4_code = substr(Q1.5.1.4_agriProducths4, 1, 4),
          Goods  =  trimws(sub(".+?-\\s*", "", Q1.5.1.4_agriProducths4)),
          CountryDestination = Q1.5.2.e_CountryOrigin,
          Value_X = Q1.5.2.h_Export_value,
          UnitValue_X = ifelse(Q1.5.2.g_Quantity_Unit=="other",Q1.5.2.g_Quantity_Unit_other,Q1.5.2.g_Quantity_Unit),
          Quantity_X = Q1.5.2.f_Export_quantity,
          UnitQuatity_X = ifelse(Q1.5.2.g_Quantity_Unit=="other",Q1.5.2.g_Quantity_Unit_other,Q1.5.2.g_Quantity_Unit),
  )
ai1p5 <- mean(main_raw$Q1_2_exchangeRate, na.rm = T)

# Define the parameters
# Parameter (1): Value of intra-regional imports of agricultural goods and inputs i by origin 0, for the reference period, in current local currency (vM_(i,o)^y)
# Parameter (2): Volume of intra-regional imports of agricultural goods and inputs i by origin 0, for the reference period, in metric ton (qM_(i,o)^y)
# Parameter (3): Value of intra-regional exports of agricultural goods and inputs j by destination d, for the reference period, in current local currency (vX_(j,d)^y)
# Parameter (4): Volume of intra-regional exports of agricultural goods and inputs j by destination d, for the reference period, in metric ton (qX_(j,d)^y)
# Parameter (5): Official exchange rate, local currency per US dollar, average annual value (ER^y)
# Compute the growth rate of the value of intra-regional import and export of agricultural goods and inputs



