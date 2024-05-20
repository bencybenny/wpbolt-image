packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}
source "amazon-ebs" "image" {

  ami_name = local.image-name
  source_ami = var.ami
  instance_type = "t2.micro"
  ssh_username = var.user
  tags = {
    Name = local.image-name
    project = var.proj_name
    env = var.proj_env
 }
}

build {
  
  sources = [ "source.amazon-ebs.image"]

  provisioner "shell" {
    script = "./setup.sh"
    execute_command = "sudo {{.Path}}"
}

  provisioner "file" {
  source = "../website"
  destination = "/tmp/"
}
  provisioner "shell" {
  inline = ["sudo cp -r /tmp/website/* /var/www/html","sudo chown -R apache:apache /var/www/html/","sudo rm -rf /tmp/website "]
}
}
