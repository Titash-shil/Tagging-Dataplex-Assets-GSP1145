#!/bin/bash

# Bright Foreground Colors
BLACK_TEXT=$'\033[0;90m'
RED_TEXT=$'\033[0;91m'
GREEN_TEXT=$'\033[0;92m'
YELLOW_TEXT=$'\033[0;93m'
BLUE_TEXT=$'\033[0;94m'
MAGENTA_TEXT=$'\033[0;95m'
CYAN_TEXT=$'\033[0;96m'
WHITE_TEXT=$'\033[0;97m'

NO_COLOR=$'\033[0m'
RESET_FORMAT=$'\033[0m'
BOLD_TEXT=$'\033[1m'
UNDERLINE_TEXT=$'\033[4m'

# Displaying start message

echo
echo "${GREEN_TEXT}${BOLD_TEXT} Enter REGION: ${RESET_FORMAT}"
read -r REGION

export REGION=$REGION


gcloud services enable dataplex.googleapis.com

gcloud services enable datacatalog.googleapis.com


gcloud dataplex lakes create orders-lake \
  --location=$REGION \
  --display-name="Orders Lake"


gcloud dataplex zones create customer-curated-zone \
    --location=$REGION \
    --lake=orders-lake \
    --display-name="Customer Curated Zone" \
    --resource-location-type=SINGLE_REGION \
    --type=CURATED \
    --discovery-enabled \
    --discovery-schedule="0 * * * *"


gcloud dataplex assets create customer-details-dataset \
--location=$REGION \
--lake=orders-lake \
--zone=customer-curated-zone \
--display-name="Customer Details Dataset" \
--resource-type=BIGQUERY_DATASET \
--resource-name=projects/$DEVSHELL_PROJECT_ID/datasets/customers \
--discovery-enabled


gcloud data-catalog tag-templates create protected_data_template --location=$REGION --field=id=protected_data_flag,display-name="Protected Data Flag",type='enum(YES|NO)' --display-name="Protected Data Template"

echo "${GREEN_TEXT}${BOLD_TEXT}Click here: ${RESET_FORMAT}""${WHITE_TEXT}${BOLD_TEXT}https://console.cloud.google.com/dataplex/search?project=$DEVSHELL_PROJECT_ID&qSystems=DATAPLEX${RESET_FORMAT}"

echo -e "${GREEN_TEXT}${BOLD_TEXT}Subscribe to my Channel:${RESET_FORMAT} ${BLUE_TEXT}${BOLD_TEXT}https://www.youtube.com/@qwiklabexplorers${RESET_FORMAT}"
echo
