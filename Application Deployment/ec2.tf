resource "aws_instance" "myserver" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.shrukey.key_name
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.sub1.id

  connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
    private_key = file("/root/.ssh/id_rsa")  # Replace with the path to your private key
    host        = self.public_ip
   }

   # File provisioner to copy a file from local to the remote EC2 instance
   provisioner "file" {
    source      = "../Flaskapplication/app.py"  # Replace with the path to your local file
    destination = "/home/ubuntu/Flaskapplication/app.py"  # Replace with the path on the remote instance
   }

   provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",
      "sudo apt-get install -y python3-pip",
      "mkdir -p /home/ubuntu/Flaskapplication",
      "pip3 install --user flask",
      "cd /home/ubuntu/Flaskapplication",
      "nohup python3 app.py > app.log 2>&1 &"
    ]
   }
}
