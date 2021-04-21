resource "aws_alb" "alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnet_ids

  tags = {
    Environment = var.environment
  }
}

resource "aws_security_group" "alb_sg" {
  name   = "alb_sg"
  vpc_id = var.vpc_id

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.ssl_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.encrypt.arn
  }
}

resource "aws_lb_listener_rule" "encrypt" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.encrypt.arn
  }

  condition {
    path_pattern {
      values = ["/encrypt*"]
    }
  }
}

resource "aws_lb_listener_rule" "decrypt" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 90

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.decrypt.arn
  }

  condition {
    path_pattern {
      values = ["/decrypt*"]
    }
  }
}

resource "aws_lb_target_group" "encrypt" {
  name        = "encrypt-lambda-tg"
  target_type = "lambda"
}

resource "aws_lb_target_group_attachment" "encrypt" {
  target_group_arn = aws_lb_target_group.encrypt.arn
  target_id        = aws_lambda_function.encrypt.arn
  depends_on       = [aws_lambda_permission.encrypt]
}

resource "aws_lambda_permission" "encrypt" {
  statement_id  = "AllowExecutionFromlb"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.encrypt.arn
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_lb_target_group.encrypt.arn
}

resource "aws_lb_target_group" "decrypt" {
  name        = "decrypt-lambda-tg"
  target_type = "lambda"
}

resource "aws_lb_target_group_attachment" "decrypt" {
  target_group_arn = aws_lb_target_group.decrypt.arn
  target_id        = aws_lambda_function.decrypt.arn
  depends_on       = [aws_lambda_permission.decrypt]
}

resource "aws_lambda_permission" "decrypt" {
  statement_id  = "AllowExecutionFromlb"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.decrypt.arn
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_lb_target_group.decrypt.arn
}