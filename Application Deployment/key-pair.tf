resource "aws_key_pair" "example" {
  key_name   = "keypair" 
  public_key = file("/root/.ssh/id_ed25519.pub")  # Replace the path for your public key file
}
