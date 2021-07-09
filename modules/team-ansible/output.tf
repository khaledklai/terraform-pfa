output "ansible_subnet_name" {
  description = "The name of the subnet for the ansible team."
  value = openstack_networking_subnet_v2.ansible_subnet.name
}

output "ansible_subnet_cidr" {
  description = "The subnet for the ansible team."
  value = openstack_networking_subnet_v2.ansible_subnet.cidr
}

output "ansible_team_keypair_name" {
  description = "The name of the KEY PAIR for the ansible team."
  value = openstack_compute_keypair_v2.ansible_key.name
}

output "ansible_team_keypair_key" {
  description = "The public KEY  for the ansible team."
  value = openstack_compute_keypair_v2.ansible_key.public_key
}


output "jenkins_id_for_ansible_team" {
  description = "The of the Jenkins VM."
  value = openstack_compute_instance_v2.jenkins_for_ansible.id
}

output "jenkins_name_for_ansible_team" {
  description = "The name of the Jenkins VM."
  value = openstack_compute_instance_v2.jenkins_for_ansible.name
}

output "jenkins_ipv4_for_ansible_team" {
  description = "The private IP address for the Jenkins VM."
  value = openstack_compute_instance_v2.jenkins_for_ansible.access_ip_v4
}

output "jenkins_float_ip_for_ansible_team" {
  description = "The Flot IP address for the Jenkins VM."
  value = openstack_compute_floatingip_associate_v2.ipflot_ansible_association_jenkins.floating_ip
}




output "ansible_id" {
  description = "The of the Ansible VM."
  value = openstack_compute_instance_v2.ansible_for_ansible.id
}

output "ansible_name" {
  description = "The name of the Ansible VM."
  value = openstack_compute_instance_v2.ansible_for_ansible.name
}

output "ansible_ipv4" {
  description = "The private IP address for the Ansible VM."
  value = openstack_compute_instance_v2.ansible_for_ansible.access_ip_v4
}

output "ansible_float_ip" {
  description = "The Flot IP address for the Ansible VM."
  value = openstack_compute_floatingip_associate_v2.ipflot_ansible_association_ansible.floating_ip
}




output "node1_id" {
  description = "The of the node1 VM."
  value = openstack_compute_instance_v2.node1_for_ansible.id
}

output "node1_name" {
  description = "The name of the node1 VM."
  value = openstack_compute_instance_v2.node1_for_ansible.name
}

output "node1_ipv4" {
  description = "The private IP address for the node1 VM."
  value = openstack_compute_instance_v2.node1_for_ansible.access_ip_v4
}

output "node1_float_ip" {
  description = "The Flot IP address for the node1 VM."
  value = openstack_compute_floatingip_associate_v2.ipflot_ansible_association_node1.floating_ip
}





output "storage_for_ansible_team_name" {
  description = "The storage name for Ansible team."
  value = openstack_blockstorage_volume_v3.ansible_volume.name
}

output "storage_for_ansible_team" {
  description = "The size of the storage for Ansible team."
  value = openstack_blockstorage_volume_v3.ansible_volume.size
}

output "storage_attach_instance_for_ansible_team" {
  description = "The attachement of the storage for Ansible team."
  value = openstack_compute_volume_attach_v2.ansible_volume_attach.instance_id
}

output "storage_attach_device_for_ansible_team" {
  description = "The attachement of the storage for Ansible team."
  value = openstack_compute_volume_attach_v2.ansible_volume_attach.device
}