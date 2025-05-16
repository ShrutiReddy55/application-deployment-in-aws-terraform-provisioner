resource "aws_key_pair" "example" {
  key_name   = var.key_name 
  public_key = keypair("/c/Users/Mathesh M/.ssh/id_rsa.pub")  # Replace the path for your public key file
}
