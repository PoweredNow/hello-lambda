variable "name" {
  description = "The name of the lambda to create, which also defines (i) the archive name (.zip), (ii) the file name, and (iii) the function name"
}

variable "runtime" {
  description = "The runtime of the lambda to create"
  default     = "nodejs"
}

variable "handler" {
  description = "The handler name of the lambda (a function defined in your lambda)"
  default     = "handler"
}

variable "role" {
  description = "IAM role attached to the Lambda Function (ARN)"
}

variable "memory_size" {
  default = 128
}

variable "vpc_config" {
  description = "VPC config of the Lambda Function"
  type = "map"
}

resource "aws_lambda_function" "lambda" {
  filename      = "${var.name}.zip"
  function_name = "${var.name}_${var.handler}"
  role          = "${var.role}"
  handler       = "${var.name}.${var.handler}"
  runtime       = "${var.runtime}"
  memory_size   = "${var.memory_size}"
  vpc_config    = "${var.vpc_config}"
}

output "name" {
  value = "${aws_lambda_function.lambda.function_name}"
}
