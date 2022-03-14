variable "cloud_id" {
  description = "Cloud"
  default     = "b1g35okphf23m1l8pb6k"
}
variable "folder_id" {
  description = "Folder"
  default     = "b1gsn46bhh43i65o0lio"
}
variable "zone" {
  description = "Zone"
  default     = "ru-central1-a"
}
variable "public_key_path" {
  description = "Path to the public key used for ssh access"
  default     = "/home/home/.ssh/appuser.pub"
}
variable "image_id" {
  description = "Disk image"
  default     = "fd8j8o5bguvqglmqls7q"
}
variable "subnet_id" {
  description = "Subnet"
  default     = "e9bgtqs5gjstf98pbeli"
}
variable "service_account_key_file" {
  description = "key .json"
  default     = "/home/home/Documents/DevOPS/HomeWork/key.json"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
  default     = "/home/home/.ssh/appuser"
}
variable "app_instance_count" {
  description = "Count of instance"
  default     = 2
}
variable "app_port" {
  description = "Application port"
  default     = 9292
}
