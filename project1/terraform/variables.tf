variable "aws_access_key" {
  description = "AWS Access Key ID"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key"
  type        = string
}

variable "ingress_rules" {
  description = "List of inbound rules"
  type        = list(number)
  default     = [22, 8080, 80, 443]
}

variable "egress_rules" {
  description = "List of outbound rules"
  type        = list(number)
  default     = [22, 8080, 80, 443, 25]  # 25 for email
}
