terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}


# Define ssh key for Docker team to config in instance
resource "openstack_compute_keypair_v2" "docker_key" {
  name       = "docker_key"
}

# Subnet Docker configuration
resource "openstack_networking_subnet_v2" "docker_subnet" {
  name            = var.docker_subnet_id["subnet_name"]
  network_id      = var.pfa_network_id
  cidr            = var.docker_subnet_id["cidr"]
  dns_nameservers = var.dns_ip_list
}

# Router interface configuration
resource "openstack_networking_router_interface_v2" "docker_interface" {
  router_id = var.pfa_router_id
  subnet_id = openstack_networking_subnet_v2.docker_subnet.id
}


# Create instance for Jenkins
#
resource "openstack_compute_instance_v2" "jenkins_for_docker" {
  name        = "jenkins_for_docker"
  image_name  = var.image_name_jenkins
  flavor_id   = var.flavor_jenkins
  key_pair    = openstack_compute_keypair_v2.docker_key.name
  security_groups = [var.sg_for_all_name]
  network {
    port = openstack_networking_port_v2.jenkins_docker_port.id
  }
}

# Create instance for Manager Node
#
resource "openstack_compute_instance_v2" "manager_for_docker" {
  name        = "manager_for_docker"
  image_name  = var.image_name_manager
  flavor_id   = var.flavor_manager
  key_pair    = openstack_compute_keypair_v2.docker_key.name
  security_groups = [var.sg_for_all_name]
  network {
    port = openstack_networking_port_v2.manager_docker_port.id
  }
}

# Create instance for Worker Node
#
resource "openstack_compute_instance_v2" "worker_for_docker" {
  name        = "worker_for_docker"
  image_name  = var.image_name_worker
  flavor_id   = var.flavor_worker
  key_pair    = openstack_compute_keypair_v2.docker_key.name
  security_groups = [var.sg_for_all_name]
  network {
    port = openstack_networking_port_v2.worker_docker_port.id
  }
}




# Create network port for jenkins
resource "openstack_networking_port_v2" "jenkins_docker_port" {
  name           = "jenkins_docker_port"
  network_id     = var.pfa_network_id
  admin_state_up = true
  security_group_ids = [
    var.sg_for_all_id,
  ]
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.docker_subnet.id
  }
}

# Create network port for Manager Node
resource "openstack_networking_port_v2" "manager_docker_port" {
  name           = "manager_docker_port"
  network_id     = var.pfa_network_id
  admin_state_up = true
  security_group_ids = [
    var.sg_for_all_id,
  ]
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.docker_subnet.id
  }
}

# Create network port for Worker Node
resource "openstack_networking_port_v2" "worker_docker_port" {
  name           = "worker_docker_port"
  network_id     = var.pfa_network_id
  admin_state_up = true
  security_group_ids = [
    var.sg_for_all_id,
  ]
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.docker_subnet.id
  }
}


# Create floating ip 1
resource "openstack_networking_floatingip_v2" "docker_flot_ip1" {
  pool     = var.public_net_name
}

# Create floating ip 2
resource "openstack_networking_floatingip_v2" "docker_flot_ip2" {
  pool     = var.public_net_name
}

# Create floating ip 2
resource "openstack_networking_floatingip_v2" "docker_flot_ip3" {
  pool     = var.public_net_name
}


# Attach floating ip to instance jenkins
resource "openstack_compute_floatingip_associate_v2" "ipflot_docker_association_jenkins" {
  floating_ip = openstack_networking_floatingip_v2.docker_flot_ip1.address
  instance_id = openstack_compute_instance_v2.jenkins_for_docker.id
}

# Attach floating ip to instance Manager Node
resource "openstack_compute_floatingip_associate_v2" "ipflot_docker_association_manager" {
  floating_ip = openstack_networking_floatingip_v2.docker_flot_ip2.address
  instance_id = openstack_compute_instance_v2.manager_for_docker.id
}

# Attach floating ip to instance Worker Node
resource "openstack_compute_floatingip_associate_v2" "ipflot_docker_association_worker" {
  floating_ip = openstack_networking_floatingip_v2.docker_flot_ip3.address
  instance_id = openstack_compute_instance_v2.worker_for_docker.id
}




# Create a block storage for Docker
resource "openstack_blockstorage_volume_v3" "docker_volume" {
  name = "docker_volume"
  size = 3
}

# Attach block storage to k8s VM
resource "openstack_compute_volume_attach_v2" "docker_volume_attach" {
  instance_id = openstack_compute_instance_v2.worker_for_docker.id
  volume_id   = openstack_blockstorage_volume_v3.docker_volume.id
}
