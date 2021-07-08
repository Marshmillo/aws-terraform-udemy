/*
Se crea la nube privada de nombre milo_vpc
con el bloque de direcciones 10.0.0.0/16 que es el que se manejará dentro de la nube
se tiene la opción enable dns hostnames activada para asignarles un hostnames a las instancias
dentro de la nube privada
*/
resource "aws_vpc" "milo_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    
    tags = {
        Name = "Milo VPC Terraform"
    }
}

/*
Se crea la subnet subnet_milo dentro de la nube privada milo_vpc
El bloque de direcciones que tendrá asignado es el 10.0.0.0/24 que debe ser derivado del bloque de direcciones definido para la nube privada
Se tiene la opción map public ip on launch activada para una autoasignación de ip pública
La ubicación de está subnet será en la zona de disponibilidad us-east-1a
*/
resource "aws_subnet" "subnet_milo" {
    vpc_id = aws_vpc.milo_vpc.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"

    tags = {
        Name = "Milo Subnet Terraform"
    }
}

resource "aws_subnet" "subnet_milo_pv" {
    vpc_id = aws_vpc.milo_vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1b"

    tags= {
        Name = "Milo Private Subnet Terraform"
    }
}

/*
Se crea un internet gateway llamdo ig_milo dentro de la nube privada milo_vpc
*/
resource "aws_internet_gateway" "ig_milo" {
    vpc_id = aws_vpc.milo_vpc.id

    tags = {
        Name = "Milo Internet Gateway Terraform"
    }
}
/*
Se crea un tabla de enrutamiento de nombre rt_milo dentro de la nube privada milo_vpc
La tabla tiene una ruta que indica que toda petición que provenga del segmento 0.0.0.0/0 (osea todo) será direccionado al internet gateway llamado ig_milo
*/
resource "aws_route_table" "rt_milo" {
    vpc_id = aws_vpc.milo_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig_milo.id
    }

    tags = {
        Name = "Milo Route Table Terraform"
    }
}

/*
Se crea una asociación entre la tabla de enrutamiento rt_milo y la subred subnet_milo
Es necesaria la asociación para que la subred reconozca y aplique el enrutamiento definido en la tabla de enrutamiento
*/ 
resource "aws_route_table_association" "rt_subnet_milo" {
    subnet_id = aws_subnet.subnet_milo.id
    route_table_id = aws_route_table.rt_milo.id
}

resource "aws_route_table_association" "rt_subnet_milo_pv" {
    subnet_id = aws_subnet.subnet_milo_pv.id
    route_table_id = aws_route_table.rt_milo.id
}