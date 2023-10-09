variable "user_uuid" {
  description = "The UUID of the user"
  type        = string
  validation {
    condition        = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message    = "The user_uuid value is not a valid UUID."
  }
}

# variable "bucket_name" {
#   description = "The name of the S3 bucket"
#   type        = string

#   validation {
#     condition     = (
#       length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63 && 
#       can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.bucket_name))
#     )
#     error_message = "The bucket name must be between 3 and 63 characters, start and end with a lowercase letter or number, and can contain only lowercase letters, numbers, hyphens, and dots."
#   }
# }

variable "index_html_filepath" {
  type = string
  description = "The file path to the index.html file."
  validation {
    condition = fileexists(var.index_html_filepath)
    error_message = "The index.html file must be a valid file path."
  }
}

variable "error_html_filepath" {
  type = string
  description = "The file path to the error.html file."
  validation {
    condition = fileexists(var.error_html_filepath)
    error_message = "The error.html file must be a valid file path."
  }
}

variable "content_version" {
  type = number
  description = "The version of the content."
  validation {
    condition = var.content_version >= 1
    error_message = "The content version must be a positive integer starting at 1."
  }
}

variable "assets_path" {
  description = "Path to assets folder"
  type = string
}