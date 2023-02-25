resource "aws_lambda_function" "get_count_lambda" {

  filename      = "lambda_function.zip"
  function_name = "visitor_update"
  role          = "arn:aws:iam::443266872301:role/service-role/get_count-role-6dzvhoyg"

  handler = "lambda_function.lambda_handler"
  runtime = "python3.9"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.getVisit.id
  parent_id   = aws_api_gateway_rest_api.getVisit.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.getVisit.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_count_lambda.function_name
  principal     = "apigateway.amazonaws.com"


  source_arn = "${aws_api_gateway_rest_api.getVisit.execution_arn}/*/*"
}