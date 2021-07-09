#### Public network
variable "public_net_name" {
  type    = string
}

# ID of Public network
variable "public_net_id" {
  type    = string
}

# Router ID
variable "pfa_router_id" {
  type    = string
}

# Network Name
variable "pfa_network_id" {
  type    = string
}


#DNS
variable "dns_ip_list" {
  type    = list(string)
}


variable "sg_for_all_name" {
  type    = string
}

variable "sg_for_all_id" {
  type    = string
}



variable "docker_subnet_id" {
  type = map(string)
}





# Image name for jenkins VM for Docker team
variable "image_name_jenkins" {
  type    = string
}
# Flavor ID for jenkins VM for Docker team
variable "flavor_jenkins" {
  type    = string
}

# Image name for Manager VM for Docker team
variable "image_name_manager" {
  type    = string
}
# Flavor ID for Manager VM for Docker team
variable "flavor_manager" {
  type    = string
}

# Image name for Worker VM for Docker team
variable "image_name_worker" {
  type    = string
}
# Flavor ID for Worker VM for Docker team
variable "flavor_worker" {
  type    = string
}