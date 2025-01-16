variable "central_logging_bucket" {
  description = "arn of the cerntralized logging s3"
  type        = string
}

variable "location" {
  description = "Region of deployment"
  type        = string
}

variable "spoke_account_id" {
  description = "spoke account id for s3 deployment"
  type        = string
}

variable "force_destroy" {
  description = "Delete all objects from the bucket without error"
  type        = bool
  default     = false #SET TO FALSE IN PROD!!
}

variable "bucket_external" {
  description = "Result of mresource checker module"
  type        = string
  default     = "true"
}

variable "tags" {
  description = "The tags to associate with resources when enable_nist_features is set to true."
  type        = map(string)
  default     = {}
}

variable "hub_environment" {
  description = "name of the hub_environment"
  type        = string
}

variable "prefixes" {
  type = list(string)
  default = ["vpc-flow", "alb-nlb", "dns-query"]
}

variable "logging_account" {
  description = "Central logging accoutn ID"
  type        = string
}

variable "prefix" {
  description = "A prefix used in the name for all cloud resources created by this script. The prefix string must start with a lowercase letter and contain only alphanumeric characters and hyphens or dashes (-), but cannot start or end with '-'."
  type        = string

  validation {
    condition     = can(regex("^[a-z][-0-9a-z]*[0-9a-z]$", var.prefix))
    error_message = "ERROR: Value of 'prefix'\n * must start with lowercase letter\n * can only contain lowercase letters, numbers, hyphens, or dashes (-), but cannot start or end with '-'."
  }
}

