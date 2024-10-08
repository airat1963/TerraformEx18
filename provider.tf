# Объявление провайдера
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 1.0.0"
}

provider "yandex" {
  zone      = var.zone
  cloud_id  ="b1gjkqhfee2fvrk4s12a"#var.cloud_id
  folder_id = var.folder_id

  token     = var.token
}