variable "ami" {
  default = "ami-00874d747dde814fa"
}

variable "inbound_ports" {
  type = number
  default = 22
}
variable "inbound_ports_alb" {
  type = list(number)
  default = [80, 443]
}

# variable "inbound_ports_alb_https" {
#   type = number
#   default = 443
# }

variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "subnet" {
  type = map
  default = {
    subnet-a = {
      az = "us-east-1a"
      cidr = "10.0.2.0/24"
    }
    subnet-b = {
      az = "us-east-1b"
      cidr = "10.0.3.0/24"
    }
  }
}

variable "domain_name" {
  type = string
  default = "mbadady.me"
}