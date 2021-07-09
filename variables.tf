#### Public network
variable "public_network_name" {
  type    = string
}

# ID of Public network
variable "public_network_id" {
  type    = string
}

# DNS
variable "dns_ip" {
  type    = list(string)
}

# Subnet for ansible
variable "ansible_subnet" {
  type = map(string)
}

# Subnet for k8s
variable "k8s_subnet" {
  type = map(string)
}

# Subnet for docker
variable "docker_subnet" {
  type = map(string)
}


### Ansible Team instances
#
# Image name for jenkins VM for Ansible team
variable "image_name_jenkins_for_ansible" {
  type    = string
}
# Flavor ID for jenkins VM for Ansible team
variable "flavor_jenkins_for_ansible" {
  type    = string
}

# Image name for Ansible VM for Ansible team
variable "image_name_ansible_for_ansible" {
  type    = string
}
# Flavor ID for Ansible VM for Ansible team
variable "flavor_ansible_for_ansible" {
  type    = string
}

# Image name for node1 VM for Ansible team
variable "image_name_node1_for_ansible" {
  type    = string
}
# Flavor ID for node1 VM for Ansible team
variable "flavor_node1_for_ansible" {
  type    = string
}



### Kubernetes Team instances
#
# Image name for jenkins VM for Kubernetes team
variable "image_name_jenkins_for_k8s" {
  type    = string
}
# Flavor ID for jenkins VM for Kubernetes team
variable "flavor_jenkins_for_k8s" {
  type    = string
}

# Image name for Ansible VM for Kubernetes team
variable "image_name_k8s_for_k8s" {
  type    = string
}
# Flavor ID for Ansible VM for Kubernetes team
variable "flavor_k8s_for_k8s" {
  type    = string
}



### Docker Team instances
#
# Image name for jenkins VM for Docker team
variable "image_name_jenkins_for_docker" {
  type    = string
}
# Flavor ID for jenkins VM for Docker team
variable "flavor_jenkins_for_docker" {
  type    = string
}

# Image name for Manager VM for Docker team
variable "image_name_manager_for_docker" {
  type    = string
}
# Flavor ID for Manager VM for Docker team
variable "flavor_manager_for_docker" {
  type    = string
}

# Image name for Worker VM for Docker team
variable "image_name_worker_for_docker" {
  type    = string
}
# Flavor ID for Worker VM for Docker team
variable "flavor_worker_for_docker" {
  type    = string
}
