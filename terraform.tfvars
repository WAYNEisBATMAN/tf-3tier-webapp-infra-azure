#-------------------------------------------------------------------------------
# Root Module
#-------------------------------------------------------------------------------
location       = "South India"  # Equivalent to ap-south-1

#-------------------------------------------------------------------------------
# Compute Module
#-------------------------------------------------------------------------------
resource_group_name  = "My-3Tier-RG"
instance_count       = 2
vm_size              = "Standard_B1s"
admin_username       = "azureadmin"
admin_password       = "SuperSecretPassword123!"  # Make sure this meets Azure password requirements
subnet_ids           = ["<subnet_id_1>", "<subnet_id_2>"]  # Replace with actual subnet IDs
nsg_id               = "<nsg_id>"                       # Replace with actual NSG ID

#-------------------------------------------------------------------------------
# Network Module
#-------------------------------------------------------------------------------
vnet_cidr            = "10.0.0.0/16"
subnet_count         = 2

#-------------------------------------------------------------------------------
# Storage Module
#-------------------------------------------------------------------------------
# storage_account_name  = "mystorageacc${random_string.suffix.result}"   # Must be globally unique
storage_container_name = "app-container"

#-------------------------------------------------------------------------------
# Database Module
#-------------------------------------------------------------------------------
sql_server_name       = "terraform-sql-server-12345"
sql_db_name           = "terraform-sql-db"
sql_admin_username    = "sqladmin"
sql_admin_password    = "SQLSuperSecret123!"      # Make sure it meets Azure SQL password rules

db_server_name        = "terraform-mysql-server"
db_type               = "mysql"
db_name               = "appdb"
db_admin_username     = "dbadmin"
db_admin_password     = "DbSuperSecret123!"       # Ensure strong password

cosmosdb_account_name  = "terraform-cosmosdb-12345"  # Must be globally unique
cosmosdb_kind          = "GlobalDocumentDB"
cosmosdb_database_name = "cosmos-app-db"

#-------------------------------------------------------------------------------
# Monitoring Module
#-------------------------------------------------------------------------------
vm_ids                = []   # Can be filled with VM IDs after creation or dynamically from compute module
alert_email           = "ops@example.com"
