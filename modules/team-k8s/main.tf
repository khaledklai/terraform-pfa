terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}


# Define ssh key for Kubernetes team to config in instance
resource "openstack_compute_keypair_v2" "k8s_key" {
  name       = "k8s_key"
}

# Subnet Kubernetes configuration
resource "openstack_networking_subnet_v2" "k8s_subnet" {
  name            = var.k8s_subnet_id["subnet_name"]
  network_id      = var.pfa_network_id
  cidr            = var.k8s_subnet_id["cidr"]
  dns_nameservers = var.dns_ip_list
}

# Router interface configuration
resource "openstack_networking_router_interface_v2" "k8s_interface" {
  router_id = var.pfa_router_id
  subnet_id = openstack_networking_subnet_v2.k8s_subnet.id
}


# Create instance for Jenkins
#
resource "openstack_compute_instance_v2" "jenkins_for_k8s" {
  name        = "jenkins_for_k8s"
  image_name  = var.image_name_jenkins
  flavor_id   = var.flavor_jenkins
  key_pair    = openstack_compute_keypair_v2.k8s_key.name
  security_groups = [var.sg_for_all_name]
  network {
    port = openstack_networking_port_v2.jenkins_k8s_port.id
  }
}

# Create instance for Kubernetes
#
resource "openstack_compute_instance_v2" "k8s_for_k8s" {
  name        = "k8s_for_k8s"
  image_name  = var.image_name_k8s
  flavor_id   = var.flavor_k8s
  key_pair    = openstack_compute_keypair_v2.k8s_key.name
  security_groups = [var.sg_for_all_name]
  network {
    port = openstack_networking_port_v2.k8s_k8s_port.id
  }
}



# Create network port for jenkins
resource "openstack_networking_port_v2" "jenkins_k8s_port" {
  name           = "jenkins_k8s_port"
  network_id     = var.pfa_network_id
  admin_state_up = true
  security_group_ids = [
    var.sg_for_all_id,
  ]
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.k8s_subnet.id
  }
}

# Create network port for Kubernetes
resource "openstack_networking_port_v2" "k8s_k8s_port" {
  name           = "k8s_k8s_port"
  network_id     = var.pfa_network_id
  admin_state_up = true
  security_group_ids = [
    var.sg_for_all_id,
  ]
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.k8s_subnet.id
  }
}


# Create floating ip 1
resource "openstack_networking_floatingip_v2" "k8s_flot_ip1" {
  pool     = var.public_net_name
}

# Create floating ip 2
resource "openstack_networking_floatingip_v2" "k8s_flot_ip2" {
  pool     = var.public_net_name
}




# Attach floating ip to instance jenkins
resource "openstack_compute_floatingip_associate_v2" "ipflot_k8s_association_jenkins" {
  floating_ip = openstack_networking_floatingip_v2.k8s_flot_ip1.address
  instance_id = openstack_compute_instance_v2.jenkins_for_k8s.id
}

# Attach floating ip to instance Kubernetes
resource "openstack_compute_floatingip_associate_v2" "ipflot_k8s_association_k8s" {
  floating_ip = openstack_networking_floatingip_v2.k8s_flot_ip2.address
  instance_id = openstack_compute_instance_v2.k8s_for_k8s.id
}





# Create a block storage for Kubernetes
resource "openstack_blockstorage_volume_v3" "k8s_volume" {
  name = "k8s_volume"
  size = 3
}

# Attach block storage to k8s VM
resource "openstack_compute_volume_attach_v2" "k8s_volume_attach" {
  instance_id = openstack_compute_instance_v2.k8s_for_k8s.id
  volume_id   = openstack_blockstorage_volume_v3.k8s_volume.id
}

