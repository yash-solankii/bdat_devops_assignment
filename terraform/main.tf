terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

# Pull Hadoop Docker image
resource "docker_image" "hadoop" {
  name = "bde2020/hadoop-namenode:2.0.0-hadoop2.7.4-java8"
}

# NameNode Container
resource "docker_container" "hadoop_namenode" {
  name  = "hadoop-namenode"
  image = docker_image.hadoop.name

  ports {
    internal = 50070
    external = 50070
  }

  ports {
    internal = 8020
    external = 8020
  }

  env = [
    "CLUSTER_NAME=test",
    "CORE_CONF_fs_defaultFS=hdfs://namenode:8020",
    "HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name"
  ]
}

# DataNode Container
resource "docker_container" "hadoop_datanode" {
  name  = "hadoop-datanode"
  image = docker_image.hadoop.name

  ports {
    internal = 50075
    external = 50075
  }

  env = [
    "CLUSTER_NAME=test",
    "CORE_CONF_fs_defaultFS=hdfs://hadoop-namenode:8020",
    "HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data"
  ]

  depends_on = [docker_container.hadoop_namenode]
}
