variable "bucket_name" {
    description = "Name of the S3 bucket used for storing infrastructure assets"
    type        = string
}

variable "force_destroy" {
  description = "Permite destruir o bucket mesmo que contenha objetos"
  type        = bool
  default     = false
}
