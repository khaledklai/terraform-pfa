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


variable "k8s_subnet_id" {
  type = map(string)
}




# Image name for jenkins VM for Kubernetes team
variable "image_name_jenkins" {
  type    = string
}
# Flavor ID for jenkins VM for Kubernetes team
variable "flavor_jenkins" {
  type    = string
}

# Image name for Ansible VM for Kubernetes team
variable "image_name_k8s" {
  type    = string
}
# Flavor ID for Ansible VM for Kubernetes team
variable "flavor_k8s" {
  type    = string
}