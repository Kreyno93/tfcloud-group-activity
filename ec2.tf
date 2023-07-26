###Create EC2
resource "aws_instance" "nf_webserver"{
    #ami                    = data.aws_ami.nf_latest_linux_ami.id
    ami                    = "ami-053482eb0c86d0d7c"
    instance_type          = "t3.micro"
    key_name               = "vockey"
    vpc_security_group_ids = [aws_security_group.nf_sg_http.id]
    subnet_id              = aws_subnet.nf_publicsubnet1.id
    tags = {
        Name = "nf_webserver"
        }
    user_data              = file("userdata.sh")
    
    provisioner "local-exec"{
        command = "echo Instance Type=${self.instance_type},Instance ID=${self.id},Public DNS=${self.public_dns},AMI ID=${self.ami} >> allinstancedetails"
    }
}