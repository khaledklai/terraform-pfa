output "docker_subnet_name" {
  description = "The name of the subnet for the Docker team."
  value = openstack_networking_subnet_v2.docker_subnet.name
}

output "docker_subnet_cidr" {
  description = "The subnet for the Docker team."
  value = openstack_networking_subnet_v2.docker_subnet.cidr
}

output "docker_team_keypair_name" {
  description = "The name of the KEY PAIR for the Docker team."
  value = openstack_compute_keypair_v2.docker_key.name
}

output "docker_team_keypair_key" {
  description = "The public KEY  for the Docker team."
  value = openstack_compute_keypair_v2.docker_key.public_key
}


output "jenkins_id_for_docker_team" {
  description = "The of the Jenkins VM."
  value = openstack_compute_instance_v2.jenkins_for_docker.id
}

output "jenkins_name_for_docker_team" {
  description = "The name of the Jenkins VM."
  value = openstack_compute_instance_v2.jenkins_for_docker.name
}

output "jenkins_ipv4_for_docker_team" {
  description = "The private IP address for the Jenkins VM."
  value = openstack_compute_instance_v2.jenkins_for_docker.access_ip_v4
}

output "jenkins_float_ip_for_docker_team" {
  description = "The Flot IP address for the Jenkins VM."
  value = openstack_compute_floatingip_associate_v2.ipflot_docker_association_jenkins.floating_ip
}




output "manager_id" {
  description = "The of the Manager VM."
  value = openstack_compute_instance_v2.manager_for_docker.id
}

output "manager_name" {
  description = "The name of the Manager VM."
  value = openstack_compute_instance_v2.manager_for_docker.name
}

output "manager_ipv4" {
  description = "The private IP address for the Manager VM."
  value = openstack_compute_instance_v2.manager_for_docker.access_ip_v4
}

output "manager_float_ip" {
  description = "The Flot IP address for the Manager VM."
  value = openstack_compute_floatingip_associate_v2.ipflot_docker_association_manager.floating_ip
}




output "worker_id" {
  description = "The of the Worker VM."
  value = openstack_compute_instance_v2.worker_for_docker.id
}

output "worker_name" {
  description = "The name of the Worker VM."
  value = openstack_compute_instance_v2.worker_for_docker.name
}

output "worker_ipv4" {
  description = "The private IP address for the Worker VM."
  value = openstack_compute_instance_v2.worker_for_docker.access_ip_v4
}

output "worker_float_ip" {
  description = "The Flot IP address for the Worker VM."
  value = openstack_compute_floatingip_associate_v2.ipflot_docker_association_worker.floating_ip
}








output "storage_for_docker_team_name" {
  description = "The storage name for Docker team."
  value = openstack_blockstorage_volume_v3.docker_volume.name
}

output "storage_for_docker_team" {
  description = "The size of the storage for Docker team."
  value = openstack_blockstorage_volume_v3.docker_volume.size
}

output "storage_attach_instance_for_docker_team" {
  description = "The attachement of the storage for Docker team."
  value = openstack_compute_volume_attach_v2.docker_volume_attach.instance_id
}

output "storage_attach_device_for_docker_team" {
  description = "The attachement of the storage for Docker team."
  value = openstack_compute_volume_attach_v2.docker_volume_attach.device
}