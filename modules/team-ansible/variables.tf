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




variable "ansible_subnet_id" {
  type = map(string)
}



# Image name for jenkins VM for Ansible team
variable "image_name_jenkins" {
  type    = string
}
# Flavor ID for jenkins VM for Ansible team
variable "flavor_jenkins" {
  type    = string
}

# Image name for Ansible VM for Ansible team
variable "image_name_ansible" {
  type    = string
}
# Flavor ID for Ansible VM for Ansible team
variable "flavor_ansible" {
  type    = string
}

# Image name for node1 VM for Ansible team
variable "image_name_node1" {
  type    = string
}
# Flavor ID for node1 VM for Ansible team
variable "flavor_node1" {
  type    = string
}
