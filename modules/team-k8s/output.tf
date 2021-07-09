output "k8s_subnet_name" {
  description = "The name of the subnet for the Kubernetes team."
  value = openstack_networking_subnet_v2.k8s_subnet.name
}

output "k8s_subnet_cidr" {
  description = "The subnet for the Kubernetes team."
  value = openstack_networking_subnet_v2.k8s_subnet.cidr
}

output "k8s_team_keypair_name" {
  description = "The name of the KEY PAIR for the Kubernetes team."
  value = openstack_compute_keypair_v2.k8s_key.name
}

output "k8s_team_keypair_key" {
  description = "The public KEY  for the Kubernetes team."
  value = openstack_compute_keypair_v2.k8s_key.public_key
}


output "jenkins_id_for_k8s_team" {
  description = "The of the Jenkins VM."
  value = openstack_compute_instance_v2.jenkins_for_k8s.id
}

output "jenkins_name_for_k8s_team" {
  description = "The name of the Jenkins VM."
  value = openstack_compute_instance_v2.jenkins_for_k8s.name
}

output "jenkins_ipv4_for_k8s_team" {
  description = "The private IP address for the Jenkins VM."
  value = openstack_compute_instance_v2.jenkins_for_k8s.access_ip_v4
}

output "jenkins_float_ip_for_k8s_team" {
  description = "The Flot IP address for the Jenkins VM."
  value = openstack_compute_floatingip_associate_v2.ipflot_k8s_association_jenkins.floating_ip
}





output "k8s_id" {
  description = "The of the Kubernetes VM."
  value = openstack_compute_instance_v2.k8s_for_k8s.id
}

output "k8s_name" {
  description = "The name of the Kubernetes VM."
  value = openstack_compute_instance_v2.k8s_for_k8s.name
}

output "k8s_ipv4" {
  description = "The private IP address for the Kubernetes VM."
  value = openstack_compute_instance_v2.k8s_for_k8s.access_ip_v4
}

output "k8s_float_ip" {
  description = "The Flot IP address for the Kubernetes VM."
  value = openstack_compute_floatingip_associate_v2.ipflot_k8s_association_k8s.floating_ip
}

