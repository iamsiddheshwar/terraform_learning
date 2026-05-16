
resource "aws_instance" "import" {
    ami = "ami-09ed39e30153c3bf9"
    availability_zone = "ap-south-1a"
    instance_type = "t2.micro"
  
  tags = {
    name="ec2-import"
  }
}