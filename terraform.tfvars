public_network_name = "public"

public_network_id = "3a3f0431-cad4-443c-b9a8-279f26016049"

dns_ip = ["8.8.8.8", "8.8.8.4"]

ansible_subnet = {
  subnet_name = "ansible_subnet"
  cidr        = "192.168.1.0/24"
}

k8s_subnet = {
  subnet_name = "k8s_subnet"
  cidr        = "192.168.2.0/24"
}

docker_subnet = {
  subnet_name = "docker_subnet"
  cidr        = "192.168.3.0/24"
}


image_name_jenkins_for_ansible = "cirros-0.5.2-x86_64-disk"
flavor_jenkins_for_ansible = "c1"

image_name_ansible_for_ansible = "cirros-0.5.2-x86_64-disk"
flavor_ansible_for_ansible = "c1"

image_name_node1_for_ansible = "cirros-0.5.2-x86_64-disk"
flavor_node1_for_ansible = "c1"




image_name_jenkins_for_k8s = "cirros-0.5.2-x86_64-disk"
flavor_jenkins_for_k8s = "c1"

image_name_k8s_for_k8s = "cirros-0.5.2-x86_64-disk"
flavor_k8s_for_k8s = "c1"



image_name_jenkins_for_docker = "cirros-0.5.2-x86_64-disk"
flavor_jenkins_for_docker = "c1"

image_name_manager_for_docker = "cirros-0.5.2-x86_64-disk"
flavor_manager_for_docker = "c1"

image_name_worker_for_docker = "cirros-0.5.2-x86_64-disk"
flavor_worker_for_docker = "c1"
