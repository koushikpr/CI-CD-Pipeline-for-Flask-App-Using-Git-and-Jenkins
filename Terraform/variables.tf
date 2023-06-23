variable "myregion" {
    type = string
    default = "us-east-1"
  
}


variable "myimageid" {
    type = string
    default = "ami-022e1a32d3f742bd8"
}


variable myvpcid {
    type = string
    default = "vpc-06c6400634ac855ba"
  
}

variable mysectag {
    type = string
    default = "TerraformSecuritygroup"

}



variable cidr_blocks {
    type = string
    default = "0.0.0.0/0"
  
}

variable ipv6_cidr_blocks {
    type = string
    default = "::/0"
  
}

variable vpccidr {
    type = string
    default = "10.0.0.0/16"
}

variable routetablecidr {
    type = string
    default = "0.0.0.0/0"
}

variable publiccidr {
    type = string
    default = "10.0.1.0/24"
  
}

variable privatecidr {
    type = string
    default = "10.0.2.0/24"
  
}


variable myvpctag {
    type = string
    default = "itsjustaname"
  
}

