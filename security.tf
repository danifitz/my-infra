resource "aws_key_pair" "my_key_pair" {
    key_name   = "dan-home-key-pair"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLy5i60ZGMcSj90hqbKjR1d2nYFmnqAxVtyHaFlEvUCZQaVKL4hBiRaAxaALlHysyAove43m/wmMBNfqNrNLRHXyDIcUfpcjdUWDdO9BpM99PKWcQKpMcoZSlTVXFEzY4RSdHHspp/damod+AOnGJVVkUcatNkRbV+swv6JjhUTFR9ZY97AhKTYWRje9hbI6Tcc0EfpSp9FMtaaMGIumONiy13OnvKRW7KE9RZFe18PZH4djELJ81DQxGAE1I4FfQRtt/yVNtzxaNFAzcNF+6V2UY5N3Il1ZtRYdTkTFCIrqGAmiNEVSrUTyACwtAk22aR9LyT8/g4bCUA/fNedLBz danfitzgerald@SoftMachine.lan"
}

resource "aws_security_group" "allow_ssh_and_egress" {
    name = "allow-all-sg"
    vpc_id = aws_vpc.my_personal_vpc.id
    ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  // Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      Name = "allow_all_egress_allow_ssh_ingress"
  }
 }