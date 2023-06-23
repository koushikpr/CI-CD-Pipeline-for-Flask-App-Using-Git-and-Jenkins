# CREATE A VPC 
resource "aws_vpc" "myvpc" {
    cidr_block = var.vpccidr
    tags = {
        Name = var.myvpctag
    }
}

# CREATE A PUBLIC SUBNET
resource "aws_subnet" "PublicSubnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.publiccidr
}

# CREATE A PRIVATE SUBNET
resource "aws_subnet" "PrivateSubnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.privatecidr
}

# CREATE IGW
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id  
}

# CREATE A ROUTING TABLE
resource "aws_route_table" "PublicRouteTable" {
    vpc_id = aws_vpc.myvpc.id
    route  {
        cidr_block = var.routetablecidr
        gateway_id = aws_internet_gateway.igw.id
    }
}


# CREATE A ROUTING TABLE ASSOCATION
resource "aws_route_table_association" "PublicRTass" {
    subnet_id = aws_subnet.PublicSubnet.id
    route_table_id = aws_route_table.PublicRouteTable.id

  
}

# CREATE A SECURITY GROUP
resource "aws_security_group" "mysecuritygroup" {

    name = "TerraformSecurityGroup"
    vpc_id = aws_vpc.myvpc.id

    ingress {
        description = "FLASK APP"
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        cidr_blocks = [var.cidr_blocks]
        ipv6_cidr_blocks = [var.ipv6_cidr_blocks]
    }

    ingress {
        
        description = "JENKINS"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = [var.cidr_blocks]
        ipv6_cidr_blocks = [var.ipv6_cidr_blocks]
    }

    egress {
        description = "HTTPS"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.cidr_blocks]
        ipv6_cidr_blocks = [var.ipv6_cidr_blocks]
    } 

    tags = {
        Name = var.mysectag
    }
  
}

# CREATE AN EC2 INSTANCE

resource "aws_instance" "web" {
    ami = var.myimageid
    instance_type = "t2.micro"
    count = "1"
    tags = {
        Name = "EC2 by Terraform"
    }
    security_groups = [ aws_security_group.mysecuritygroup.name ]
    
  
}