output "asg_id" {
  description = "ID de l'Autoscaling Group"
  value       = aws_autoscaling_group.this.id
}

output "asg_arn" {
  description = "ARN de l'Autoscaling Group"
  value       = aws_autoscaling_group.this.arn
}

output "launch_template_id" {
  description = "ID du Launch Template créé"
  value       = aws_launch_template.this.id
}