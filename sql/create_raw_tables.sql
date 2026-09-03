-- Replace the project ID when running in another Google Cloud project.

CREATE SCHEMA IF NOT EXISTS `cove_raw`
OPTIONS (
    location = 'US'
);

CREATE SCHEMA IF NOT EXISTS `cove_analytics`
OPTIONS (
    location = 'US'
);

CREATE TABLE IF NOT EXISTS `cove_raw.properties` (
    _id STRING,
    name STRING,
    city STRING,
    lease_start_date STRING,
    lease_end_date STRING,
    updatedAt STRING,
    deletedAt STRING
);

CREATE TABLE IF NOT EXISTS `cove_raw.rooms` (
    _id STRING,
    propertyId STRING,
    room_number STRING,
    type STRING,
    updatedAt STRING,
    deletedAt STRING
);

CREATE TABLE IF NOT EXISTS `cove_raw.tenancies` (
    _id STRING,
    roomId STRING,
    tenant_id STRING,
    checkInDate STRING,
    checkOutDate STRING,
    status STRING,
    updatedAt STRING
);