terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}


# Define ssh key for Ansible team to config in instance
resource "openstack_compute_keypair_v2" "ansible_key" {
  name       = "ansible_key"
}

# Subnet Ansible configuration
resource "openstack_networking_subnet_v2" "ansible_subnet" {
  name            = var.ansible_subnet_id["subnet_name"]
  network_id      = var.pfa_network_id
  cidr            = var.ansible_subnet_id["cidr"]
  dns_nameservers = var.dns_ip_list
}

# Router interface configuration
resource "openstack_networking_router_interface_v2" "ansible_interface" {
  router_id = var.pfa_router_id
  subnet_id = openstack_networking_subnet_v2.ansible_subnet.id
}


# Create instance for Jenkins
#
resource "openstack_compute_instance_v2" "jenkins_for_ansible" {
  name        = "jenkins_for_ansible"
  image_name  = var.image_name_jenkins
  flavor_id   = var.flavor_jenkins
  key_pair    = openstack_compute_keypair_v2.ansible_key.name
  security_groups = [var.sg_for_all_name]
  network {
    port = openstack_networking_port_v2.jenkins_ansible_port.id
  }
}

# Create instance for Ansible
#
resource "openstack_compute_instance_v2" "ansible_for_ansible" {
  name        = "ansible_for_ansible"
  image_name  = var.image_name_ansible
  flavor_id   = var.flavor_ansible
  key_pair    = openstack_compute_keypair_v2.ansible_key.name
  security_groups = [var.sg_for_all_name]
  network {
    port = openstack_networking_port_v2.ansible_ansible_port.id
  }
}

# Create instance for node1
#
resource "openstack_compute_instance_v2" "node1_for_ansible" {
  name        = "node1_for_ansible"
  image_name  = var.image_name_node1
  flavor_id   = var.flavor_node1
  key_pair    = openstack_compute_keypair_v2.ansible_key.name
  security_groups = [var.sg_for_all_name]
  network {
    port = openstack_networking_port_v2.node1_ansible_port.id
  }
}





# Create network port for jenkins
resource "openstack_networking_port_v2" "jenkins_ansible_port" {
  name           = "jenkins_ansible_port"
  network_id     = var.pfa_network_id
  admin_state_up = true
  security_group_ids = [
    var.sg_for_all_id,
  ]
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.ansible_subnet.id
  }
}

# Create network port for ansible
resource "openstack_networking_port_v2" "ansible_ansible_port" {
  name           = "ansible_ansible_port"
  network_id     = var.pfa_network_id
  admin_state_up = true
  security_group_ids = [
    var.sg_for_all_id,
  ]
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.ansible_subnet.id
  }
}

# Create network port for node1
resource "openstack_networking_port_v2" "node1_ansible_port" {
  name           = "node1_ansible_port"
  network_id     = var.pfa_network_id
  admin_state_up = true
  security_group_ids = [
    var.sg_for_all_id,
  ]
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.ansible_subnet.id
  }
}



# Create floating ip 1
resource "openstack_networking_floatingip_v2" "ansible_flot_ip1" {
  pool     = var.public_net_name
}

# Create floating ip 2
resource "openstack_networking_floatingip_v2" "ansible_flot_ip2" {
  pool     = var.public_net_name
}

# Create floating ip 3
resource "openstack_networking_floatingip_v2" "ansible_flot_ip3" {
  pool     = var.public_net_name
}




# Attach floating ip to instance jenkins
resource "openstack_compute_floatingip_associate_v2" "ipflot_ansible_association_jenkins" {
  floating_ip = openstack_networking_floatingip_v2.ansible_flot_ip1.address
  instance_id = openstack_compute_instance_v2.jenkins_for_ansible.id
}

# Attach floating ip to instance ansible
resource "openstack_compute_floatingip_associate_v2" "ipflot_ansible_association_ansible" {
  floating_ip = openstack_networking_floatingip_v2.ansible_flot_ip2.address
  instance_id = openstack_compute_instance_v2.ansible_for_ansible.id
}

# Attach floating ip to instance node1
resource "openstack_compute_floatingip_associate_v2" "ipflot_ansible_association_node1" {
  floating_ip = openstack_networking_floatingip_v2.ansible_flot_ip3.address
  instance_id = openstack_compute_instance_v2.node1_for_ansible.id
}


# Create a block storage for Ansible
resource "openstack_blockstorage_volume_v3" "ansible_volume" {
  name = "ansible_volume"
  size = 3
}


# Attach block storage to node1 VM
resource "openstack_compute_volume_attach_v2" "ansible_volume_attach" {
  instance_id = openstack_compute_instance_v2.node1_for_ansible.id
  volume_id   = openstack_blockstorage_volume_v3.ansible_volume.id
}
