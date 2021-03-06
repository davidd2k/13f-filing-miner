## Pulls useful information out of CUSIP field

fund_holdings <- read.csv("./fund_holdings_cleaned.csv")

fund_holdings$Cusip <- as.character(fund_holdings$Cusip)

# Extract useful CUSIP components
cusip_78 <- substr(fund_holdings$Cusip, 7, 8)
fund_holdings$Cusip_Base <- substr(fund_holdings$Cusip, 1, 6)

call_indices <- cusip_78 == "90"
put_indices <- cusip_78 == "95"

# Not sure what "COM NEW" indicates - perhaps a new position?
#com_new_indices <- cusip_78 == "20"

# COM seems to indicate simply holding of common stock
#com_indices <- cusip_78 == "10"

# Consider any of 10,20,30 as "common"
com_indices <- is.element(cusip_78, c("10","20","30"))

# Add "Position_Type" column
fund_holdings$Position_Type <- "other"
fund_holdings$Position_Type[call_indices] <- "call"
fund_holdings$Position_Type[put_indices] <- "put"
fund_holdings$Position_Type[com_indices] <- "common"

write.csv(fund_holdings, "fund_holdings_best.csv",row.names=FALSE)
