# Configuración del proveedor de AWS
provider "aws" {
  region = "us-east-1" #región donde se desplegarán los recursos
}

# Creamos el security group
resource "aws_security_group" "mi-sg" {
  name        = "mi-security-group-terraform-windows"
  description = "Security Group para mi instancia de terraform en Windows"
  vpc_id      = "vpc-0b00fca964fd3d8d5"

  #Regla de entrada para SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #Regla de salida para HTTP
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Declaración de los recursos de aws
resource "aws_instance" "mi_instancia_terraform_windows" {
  ami           = "ami-0b5f645abc199e666" # ID de la imagen de Windows Server 2019 Base en la región us-east-1
  instance_type = "t3.medium"             # Tipo de instancia 
  key_name      = "mi-segunda-llaves-fc"  # Nombre del par de claves para acceder a la instancia
  tags = {
    Name = "TareaTerraformWindows" # Etiqueta para identificar a la instancia
  }
  vpc_security_group_ids = [aws_security_group.mi-sg.id] # Asignamos el secturity group a la instancia y listo
}
