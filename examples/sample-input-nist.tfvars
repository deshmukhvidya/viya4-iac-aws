# !NOTE! - These are only a subset of the variables in CONFIG-VARS.md provided
# as examples. Customize this file to add any variables from CONFIG-VARS.md whose
# default values you want to change.

# ****************  REQUIRED VARIABLES  ****************
# These required variables' values MUST be provided by the User
prefix   = "test"
location = "us-east-1" # e.g., "us-east-1"
# ****************  REQUIRED VARIABLES  ****************

# !NOTE! - Without specifying your CIDR block access rules, ingress traffic
#          to your cluster will be blocked by default.

#***************** CIDR Range for Spoke VPC **************

vpc_cidr     = "10.80.16.0/22"
core_network_id    = "core-network-0febf425a0504df84"
hub          = "CustomerSpokeUS"
hub_environment = "dev"
core_network_arn   = "arn:aws:networkmanager::654654181786:core-network/core-network-0febf425a0504df84"

# ********* Set to true to enable NIST complaint code ***********
enable_nist_features = true
backup_account_id = "992382826079"

#***************** Additional CIDR ranges for Spoke VPC *************

additional_cidr_ranges = ["10.88.4.0/24", "10.89.1.0/26", "10.90.0.128/27", "10.91.0.128/27"]

subnets = {
  "private" : ["10.80.16.0/23"],
  "control_plane" : ["10.90.0.128/28", "10.90.0.144/28"], # AWS recommends at least 16 IP addresses per subnet
  "public" : ["10.89.1.0/27", "10.89.1.32/27"],
  "database" : ["10.88.4.0/25", "10.88.4.128/25"],
  "eni" : ["10.91.0.128/28", "10.91.0.144/28"]
}

# **************  RECOMMENDED  VARIABLES  ***************
default_public_access_cidrs = [] # e.g., ["123.45.6.89/32"]
ssh_public_key              = "~/.ssh/id_rsa.pub"
# **************  RECOMMENDED  VARIABLES  ***************

# Tags for all tagable items in your cluster.
tags = {} # e.g., { "key1" = "value1", "key2" = "value2" }

# Postgres config - By having this entry a database server is created. If you do not
#                   need an external database server remove the 'postgres_servers'
#                   block below.
postgres_servers = {
  default = {},
}

## Cluster config
kubernetes_version           = "1.29"
default_nodepool_node_count  = 2
default_nodepool_vm_type     = "m5.2xlarge"
default_nodepool_custom_data = ""

## General
efs_performance_mode = "maxIO"
storage_type          = "ha"
storage_type_backend  = "efs"
enable_efs_encryption = true

## Cluster Node Pools config
node_pools = {
  cas = {
    "vm_type"      = "i3.8xlarge"
    "cpu_type"     = "AL2_x86_64"
    "os_disk_type" = "gp2"
    "os_disk_size" = 200
    "os_disk_iops" = 0
    "min_nodes"    = 1
    "max_nodes"    = 5
    "node_taints"  = ["workload.sas.com/class=cas:NoSchedule"]
    "node_labels" = {
      "workload.sas.com/class" = "cas"
    }
    "custom_data"                          = "./files/custom-data/additional_userdata.sh"
    "metadata_http_endpoint"               = "enabled"
    "metadata_http_tokens"                 = "required"
    "metadata_http_put_response_hop_limit" = 1
  },
  compute = {
    "vm_type"      = "m5.8xlarge"
    "cpu_type"     = "AL2_x86_64"
    "os_disk_type" = "gp2"
    "os_disk_size" = 200
    "os_disk_iops" = 0
    "min_nodes"    = 1
    "max_nodes"    = 5
    "node_taints"  = ["workload.sas.com/class=compute:NoSchedule"]
    "node_labels" = {
      "workload.sas.com/class"        = "compute"
      "launcher.sas.com/prepullImage" = "sas-programming-environment"
    }
    "custom_data"                          = ""
    "metadata_http_endpoint"               = "enabled"
    "metadata_http_tokens"                 = "required"
    "metadata_http_put_response_hop_limit" = 1
  },
  stateless = {
    "vm_type"      = "m5.4xlarge"
    "cpu_type"     = "AL2_x86_64"
    "os_disk_type" = "gp2"
    "os_disk_size" = 200
    "os_disk_iops" = 0
    "min_nodes"    = 1
    "max_nodes"    = 5
    "node_taints"  = ["workload.sas.com/class=stateless:NoSchedule"]
    "node_labels" = {
      "workload.sas.com/class" = "stateless"
    }
    "custom_data"                          = ""
    "metadata_http_endpoint"               = "enabled"
    "metadata_http_tokens"                 = "required"
    "metadata_http_put_response_hop_limit" = 1
  },
  stateful = {
    "vm_type"      = "m5.4xlarge"
    "cpu_type"     = "AL2_x86_64"
    "os_disk_type" = "gp2"
    "os_disk_size" = 200
    "os_disk_iops" = 0
    "min_nodes"    = 1
    "max_nodes"    = 3
    "node_taints"  = ["workload.sas.com/class=stateful:NoSchedule"]
    "node_labels" = {
      "workload.sas.com/class" = "stateful"
    }
    "custom_data"                          = ""
    "metadata_http_endpoint"               = "enabled"
    "metadata_http_tokens"                 = "required"
    "metadata_http_put_response_hop_limit" = 1
  }
}

# Jump Server
create_jump_vm = true
