resource "aws_api_gateway_rest_api" "rest" {
  name = var.api_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "rest" {
  rest_api_id = aws_api_gateway_rest_api.rest.id
  parent_id   = aws_api_gateway_rest_api.rest.root_resource_id
  path_part   = var.path_part
}

resource "aws_api_gateway_method" "post" {
  authorization = "NONE"
  http_method   = "POST"
  resource_id   = aws_api_gateway_resource.rest.id
  rest_api_id   = aws_api_gateway_rest_api.rest.id
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.rest.id

}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.rest.id
  resource_id             = aws_api_gateway_resource.rest.id
  http_method             = aws_api_gateway_method.post.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = var.lambda_arn
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id      = aws_api_gateway_deployment.deployment.id
  rest_api_id        = aws_api_gateway_rest_api.rest.id
  stage_name         = var.api_name
  cache_cluster_size = "0.5"
}

resource "aws_lambda_permission" "permission" {
  statement_id  = "APIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.api_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.rest.execution_arn}/*/POST/${var.path_part}"
}