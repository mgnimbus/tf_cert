variable "no_of_instance" {
  type    = number
  default = 1
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-0aa7d40eeae50c9a9" # Amazon2 Linux AMI ID
  validation {
    condition     = length(var.ami_id) > 4 && substr(var.ami_id, 0, 4) == "ami-"
    error_message = "The ami_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "instance_type" {
  type    = string
  default = "t2.nano"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "instance_type_list" {
  type = map(list(string))
  default = {
    dev  = ["t2.micro", "t3.micro"]
    prod = ["t2.large"]
  }

}

variable "key_name" {
  type    = string
  default = "win11_key"
}

variable "tags" {
  type = map(string)
  default = {
    Name  = "gowtham-dev-test"
    Owner = "gowtham"
    Env   = "dev"
  }
}

variable "ingress_block" {
  type = map(object({
    cidr_blocks = list(string)
    port        = string
    protocol    = string
  }))
  default = {
    "ssh" = {
      cidr_blocks = ["0.0.0.0/0"]
      port        = "22"
      protocol    = "tcp"
    },
    "http" = {
      cidr_blocks = ["0.0.0.0/0"]
      port        = "80"
      protocol    = "tcp"
    }
  }
}

variable "egress_block" {
  type = map(object({
    cidr_blocks = list(string)
    port        = string
    protocol    = string
  }))
  default = {
    "egresss" = {
      cidr_blocks = ["0.0.0.0/0"]
      port        = "0"
      protocol    = "-1"
    }
  }
}

