#output.tf

output "petclinicname" {
       value = aws_vpc.petclinic.id
}