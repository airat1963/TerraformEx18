

resource "yandex_dataproc_cluster" "spark_cluster" {
  name        = "spark-cluster"
  description = "Spark cluster in Yandex.Cloud"
  bucket      = "your_bucket_name"
  service_account_id = "aje75bma51dl9sbr8j67"
  zone_id     = "ru-central1-b"
  security_group_ids = ["enpt4e3c711072iat0so"]  # Укажите группу безопасности
  

  cluster_config {
    version_id = "2.0"

    hadoop {
      services = ["SPARK", "YARN", "HDFS"]
      ssh_public_keys = [file(var.public_key_path)]  #"~/.ssh/id_ed25519.pub"

    #   initialization_actions {
    #     uri = "s3a://your_bucket_name/copy_keys.sh"
    #     args = []
    # }
    }

    subcluster_spec {
      name = "master"
      role = "MASTERNODE"
      resources {
        resource_preset_id = "s3-c2-m8"
        disk_type_id       = "network-hdd"
        disk_size          = 115
      }
      #subnet_id = yandex_vpc_subnet.subnet-1.id
      subnet_id = var.subnet_id
      hosts_count = 1
      assign_public_ip = true
      #security_group_ids = [yandex_vpc_security_group.dataproc_sg.id]  # Укажите группу безопасности
    }

    subcluster_spec {
      name = "data"
      role = "DATANODE"
      resources {
        resource_preset_id = "s3-c4-m16"
        disk_type_id       = "network-hdd"
        disk_size          = 115
      }
      #subnet_id = yandex_vpc_subnet.subnet-1.id
      subnet_id = var.subnet_id
      hosts_count = 3
    }
    
  }
}

