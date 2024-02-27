data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "server_instances" {
  count                       = var.instance_count
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_ids[count.index]
  key_name                    = var.ami_key_pair_name
  vpc_security_group_ids      = [var.security_group_ids[count.index]]
  associate_public_ip_address = var.associate_public_ip_address[count.index]

  tags = {
    Name = var.instance_names[count.index]
  }
}