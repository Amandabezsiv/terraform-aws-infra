module "vpc" {
  source             = "../../modules/vpc"
  vpc_cidr           = "10.0.0.0/16"
  vpc_name           = "amanda-vpc"
  public_subnet_cidr = "10.0.1.0/24"
  availability_zone  = "sa-east-1a"
}

module "my_bucket" {
  source        = "../../modules/s3_bucket"
  bucket_name   = "amanda-tf-bucket-123"
  force_destroy = true
}

module "ec2_instance" {
  source        = "../../modules/ec2_instance"
  instance_name = "dev-instance-1"
  subnet_id     = module.vpc.public_subnet_id  
  instance_type = "t2.micro"
  ami_id        = "ami-0fd3e85ff2ef60d80"
}
