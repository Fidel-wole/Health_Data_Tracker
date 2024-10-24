-- Creating the "patients" table
CREATE TABLE "patients" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "full_name" VARCHAR NOT NULL,
  "age" INT,  -- Making age nullable
  "gender" VARCHAR,  -- Making gender nullable
  "contact_info" VARCHAR UNIQUE NOT NULL,  -- Keeping contact_info as NOT NULL
  "assigned_device_id" INT NULL,  -- Making assigned_device_id nullable
  "created_at" TIMESTAMP DEFAULT (now()),
  "updated_at" TIMESTAMP DEFAULT (now())
);

COMMENT ON COLUMN "patients"."age" IS 'Age in years';
COMMENT ON COLUMN "patients"."gender" IS 'Values: Male, Female, Non-binary, etc.';
COMMENT ON COLUMN "patients"."contact_info" IS 'Email or phone number for communication';
COMMENT ON COLUMN "patients"."assigned_device_id" IS 'Reference to assigned device';
COMMENT ON COLUMN "patients"."created_at" IS 'Record creation timestamp';
COMMENT ON COLUMN "patients"."updated_at" IS 'Record last updated timestamp';

-- Creating the "wearable_devices" table
CREATE TABLE "wearable_devices" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "device_name" VARCHAR NOT NULL,
  "device_type" VARCHAR NOT NULL,  -- Keeping device_type as NOT NULL
  "assigned_patient_id" INT NULL,  -- Making assigned_patient_id nullable
  "serial_number" VARCHAR UNIQUE NOT NULL,  -- Keeping serial_number as NOT NULL
  "country_code" INT NULL,  -- Making country_code nullable
  "created_at" TIMESTAMP DEFAULT (now()),
  "updated_at" TIMESTAMP DEFAULT (now())
);

COMMENT ON COLUMN "wearable_devices"."device_type" IS 'E.g., Heart Rate Monitor, Pulse Oximeter';
COMMENT ON COLUMN "wearable_devices"."assigned_patient_id" IS 'Reference to the assigned patient';
COMMENT ON COLUMN "wearable_devices"."serial_number" IS 'Unique serial number of the device';
COMMENT ON COLUMN "wearable_devices"."country_code" IS 'Country code where the device is registered';
COMMENT ON COLUMN "wearable_devices"."created_at" IS 'Record creation timestamp';
COMMENT ON COLUMN "wearable_devices"."updated_at" IS 'Record last updated timestamp';

-- Adding foreign key constraints
ALTER TABLE "patients" 
ADD FOREIGN KEY ("assigned_device_id") 
REFERENCES "wearable_devices" ("id");

ALTER TABLE "wearable_devices" 
ADD FOREIGN KEY ("assigned_patient_id") 
REFERENCES "patients" ("id");
