

output "instID" {
  value = [aws_instance.inst1.id]
}


output "public_ip" {
  value = aws_instance.inst1.public_ip
}
