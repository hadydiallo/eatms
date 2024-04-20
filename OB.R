#
glimpse(S2_AppliedTariffImport)

p1 <- S2_AppliedTariffImport %>%
  filter(!is.na(Q2.1.1.b_importProducths4)) %>%
  mutate(
    chapter = substr(Q2.1.1.b_importProducths4, 1, 2),
    heading = substr(Q2.1.1.b_importProducths4, 1, 4),
    ag_prod_desc = Q2.1.1.b_importProducths4, 
    SPS_MandDocument_count = lengths(strsplit(Q2.1.1.p_importNameMandatoryDoc, " "))
  ) %>%
  select(chapter, heading, ag_prod_desc, SPS_MandDocument_count)

glimpse(p1)

SPS_Docs <- data.frame(concatenated_options = c(
  "CertificateofOrigin",
  "PhytosanitaryCertificate",
  "SanitaryCertificate",
  "ExportDeclaration",
  "ImportPermit",
  "BillofLading/AirwayBill",
  "CommercialInvoice",
  "PackingList",
  "HealthCertificate",
  "InsuranceCertificate",
  "CustomsDocumentation",
  "SpecializedProductDocumentation",
  "Other"
))

doc <- S2_AppliedTariffImport %>%
  mutate(concatenated_options = Q2.1.1.p_importNameMandatoryDoc) %>%
  separate_rows(concatenated_options, sep = " ") %>%  # Separate options by ";"
  group_by(concatenated_options) %>%
  summarise(count = n())  # Count occurrences of each option

,
selected_options = strsplit(Q2.1.1.p_importNameMandatoryDoc, ";") ) %>% 
  unnest(selected_options)



odk_data <- odk_data %>%
  mutate(
    selected_options = strsplit(select_multiple_column, ";") # Split selected options
  ) %>%
  tidyr::unnest(selected_options) # Create new rows for each option


# Function to create new variables
create_variables <- function(data, column_name) {
  # Split the selected elements by '/'
  selected_elements <- strsplit(data[[column_name]], "/")
  
  # Count the number of selected elements
  data$num_selected <- map_int(selected_elements, length)
  
  # For each selected element, create a new variable automatically
  map2(selected_elements, seq_along(selected_elements), ~{
    for(i in seq_along(.x)) {
      data[paste(column_name, .y, sep = "_"), .x[i]] <<- TRUE
    }
  })
  
  return(data)
}


glimpse(S2_AppliedTariffExport)


# 1. Number of SPS Certificates delivered (nSPS)
##count Q2.1.1.p_importNameMandatoryDoc 

# 2. Number of agricultural trade related Certificates of Origin delivered (nCOO)
# 
# 3. Number of other mutually recognized documents related to agricultural trade delivered (nMRD)
# 
# 4. Number of rejected (non-recognition of) SPS Certificate (nSPSNR)
# 
# 5. Number of rejected (non-recognition of) agricultural trade related Certificates of Origin (nCOONR)
# 
# 6. Number of rejected (non-recognition of) other mutually recognized documents related to agricultural trade (nMRDNR)

