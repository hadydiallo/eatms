#' Output samples 
library(readr)

## Imports 
library(readr)
Ag_goods_and_inputs_imports <- read_csv("Output Sample/Ag_goods_and_inputs_imports.csv")
glimpse(Ag_goods_and_inputs_imports)

# Mise à jour des colonnes avec les types de données spécifiés
Ag_goods_and_inputs_imports_v1 <- data.table(
  chapter = substr(ai1My1$HS4_code, 1, 2), ## HS2
  heading = ai1My1$HS4_code , ## HS4
  ag_prod_desc = paste0(ai1My1$HS4_code,"-", ai1My1$Goods),
  ecowas_trading_partner_country = ai1My1$CountryOrigin,
  subject_to_tarif_other_charges=ai1My1$AppliedOtherRest,
  tarif_or_other_charges = ai1My1$AppliedTax,
  affected_by_export_restrict = ai1My1$AppliedRest,
  import_restrict_or_prohibitions = ai1My1$ExportRestriction,
  value_base_year_2010 = ai1My2$Value_M,
  quantity_base_year_2010 = ai1My2$Quantity_M_KG,
  value_ref_year_2022 = ai1My1$Value_M,
  quantity_ref_year_2022 = ai1My1$Quantity_M_KG
)
glimpse(Ag_goods_and_inputs_imports_v1)

## Exports 
Ag_goods_and_inputs_exports <- read_csv("Output Sample/Ag_goods_and_inputs_exports.csv")
glimpse(Ag_goods_and_inputs_exports)

library(data.table)

# Mise à jour des colonnes avec les types de données spécifiés
Ag_goods_and_inputs_exports_v1 <- data.table(
  chapter = substr(ai1Xy1$HS4_code, 1, 2), ## HS2
  heading = ai1Xy1$HS4_code , ## HS4
  ag_prod_desc = paste0(ai1Xy1$HS4_code,"-", ai1Xy1$Goods),
  ecowas_trading_partner_country = ai1Xy1$CountryDestination,
  export_tax_applied_if_any = ai1Xy1$AppliedTax,
  affected_by_export_restrict = ai1Xy1$AppliedRest,
  export_restrict_or_prohibitions = ai1Xy1$ExportRestriction,
  value_base_year_2010 = ai1Xy2$Value_X,
  quantity_base_year_2010 = ai1Xy2$Quantity_X_KG,
  value_ref_year_2022 = ai1Xy1$Value_X,
  quantity_ref_year_2022 = ai1Xy1$Quantity_X_KG
)

glimpse(Ag_goods_and_inputs_exports_v1) ##   

write_csv(Ag_goods_and_inputs_exports_v1, paste0(output,"/Ag_goods_and_inputs_exports.csv"))
write_csv(Ag_goods_and_inputs_imports_v1, paste0(output,"/Ag_goods_and_inputs_imports.csv"))



