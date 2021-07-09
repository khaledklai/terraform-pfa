# Router creation
resource "openstack_networking_router_v2" "pfa_router" {
  name                = "pfa_router"
  external_network_id = var.public_network_id
}

# Network creation
resource "openstack_networking_network_v2" "pfa_network" {
  name = "pfa_network"
}

# Security group for ALL
resource "openstack_compute_secgroup_v2" "sg_for_all" {
  name        = "sg_for_all"
  description = "Open input ssh + ICMP"
  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }
}

### Calling modules
#
module "team-k8s" {
  source = "./modules/team-k8s"
  public_net_name = var.public_network_name
  public_net_id = var.public_network_id
  pfa_router_id = openstack_networking_router_v2.pfa_router.id
  pfa_network_id = openstack_networking_network_v2.pfa_network.id
  sg_for_all_name = openstack_compute_secgroup_v2.sg_for_all.name
  sg_for_all_id = openstack_compute_secgroup_v2.sg_for_all.id
  dns_ip_list = var.dns_ip

  k8s_subnet_id = var.k8s_subnet

  image_name_jenkins = var.image_name_jenkins_for_k8s
  flavor_jenkins = var.flavor_jenkins_for_k8s

  image_name_k8s = var.image_name_k8s_for_k8s
  flavor_k8s = var.flavor_k8s_for_k8s
}

module "team-ansible" {
  source = "./modules/team-ansible"
  public_net_name = var.public_network_name
  public_net_id = var.public_network_id
  pfa_router_id = openstack_networking_router_v2.pfa_router.id
  pfa_network_id = openstack_networking_network_v2.pfa_network.id
  sg_for_all_name = openstack_compute_secgroup_v2.sg_for_all.name
  sg_for_all_id = openstack_compute_secgroup_v2.sg_for_all.id
  dns_ip_list = var.dns_ip
  
  ansible_subnet_id = var.ansible_subnet

  image_name_jenkins = var.image_name_jenkins_for_ansible
  flavor_jenkins = var.flavor_jenkins_for_ansible

  image_name_ansible = var.image_name_ansible_for_ansible
  flavor_ansible = var.flavor_ansible_for_ansible

  image_name_node1 = var.image_name_node1_for_ansible
  flavor_node1 = var.flavor_node1_for_ansible
}

module "team-docker" {
  source = "./modules/team-docker"
  public_net_name = var.public_network_name
  public_net_id = var.public_network_id
  pfa_router_id = openstack_networking_router_v2.pfa_router.id
  pfa_network_id = openstack_networking_network_v2.pfa_network.id
  sg_for_all_name = openstack_compute_secgroup_v2.sg_for_all.name
  sg_for_all_id = openstack_compute_secgroup_v2.sg_for_all.id
  dns_ip_list = var.dns_ip

  docker_subnet_id = var.docker_subnet

  image_name_jenkins = var.image_name_jenkins_for_docker
  flavor_jenkins = var.flavor_jenkins_for_docker

  image_name_manager = var.image_name_manager_for_docker
  flavor_manager = var.flavor_manager_for_docker

  image_name_worker = var.image_name_worker_for_docker
  flavor_worker = var.flavor_worker_for_docker
}

