#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <gcp-project-id>"
    exit 1
fi

PROJECT_ID="$1"
LOCATION="US"

bq query \
    --project_id="$PROJECT_ID" \
    --location="$LOCATION" \
    --use_legacy_sql=false \
    < sql/create_raw_tables.sql

bq load \
    --replace \
    --project_id="$PROJECT_ID" \
    --location="$LOCATION" \
    --source_format=NEWLINE_DELIMITED_JSON \
    "$PROJECT_ID:cove_raw.properties" \
    data/properties.jsonl \
    "_id:STRING,name:STRING,city:STRING,lease_start_date:STRING,lease_end_date:STRING,updatedAt:STRING,deletedAt:STRING"

bq load \
    --replace \
    --project_id="$PROJECT_ID" \
    --location="$LOCATION" \
    --source_format=NEWLINE_DELIMITED_JSON \
    "$PROJECT_ID:cove_raw.rooms" \
    data/rooms.jsonl \
    "_id:STRING,propertyId:STRING,room_number:STRING,type:STRING,updatedAt:STRING,deletedAt:STRING"

bq load \
    --replace \
    --project_id="$PROJECT_ID" \
    --location="$LOCATION" \
    --source_format=NEWLINE_DELIMITED_JSON \
    "$PROJECT_ID:cove_raw.tenancies" \
    data/tenancies.jsonl \
    "_id:STRING,roomId:STRING,tenant_id:STRING,checkInDate:STRING,checkOutDate:STRING,status:STRING,updatedAt:STRING"

echo "Raw data loaded successfully into ${PROJECT_ID}:cove_raw."