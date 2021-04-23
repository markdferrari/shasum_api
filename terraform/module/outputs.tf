output "decrypt_lambda_arn" {
  value = aws_lambda_function.decrypt.invoke_arn
}

output "encrypt_lambda_arn" {
  value = aws_lambda_function.encrypt.invoke_arn
}