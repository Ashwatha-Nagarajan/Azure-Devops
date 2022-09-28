resource "aws_instance" "an_ec2" {
  ami = "${lookup(var.ami,var.region)}"
  instance_type = "${var.instance-type}"
  subnet_id = var.public_subnet_ids[0]
  count = 2
  key_name = "AS-key"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.an_sg.id]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./AS-key.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    destination = "/home/ubuntu/index.php"
    source      = "../php/index.php"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt -y upgrade",
      "sudo apt install -y mysql-server",
      "sudo apt install -y php",
      "sudo apt install -y php-mysql",
      "sudo apachectl stop",
      "sudo apt install -y apache2",
      "sudo apachectl start",
      "sudo apt install git -y ",
      "sudo cp /home/ubuntu/index.php /var/www/html/index.php",
    ]
  }
}

