#This will be used when deploying EC2 Instances. Authenticating you to access via SSH
resource "aws_key_pair" "strikingimpact" {
  key_name   = var.ec2_keypair_name
  public_key = var.ec2_keypair_public_data
}
