provider "aws"
{
access_key= ""
secret_key= "",
region ="us-east-2" 
}
resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "terraform_ec2_key"
  public_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCmSldvm1i5VUjcoJsE/OIPGV1T577zwj6jP8+I+9n91Vy3+5ZJnBskLBSSh6NKtSOr1SPYQdKyND/hgrEd2mZThB7cPK+8EX7bUEC1h+BAGeQK/ZTkVjWnG1MkpJdPNaOaR8lnj/dVVPUhrJtKplCswSGX8CNdozbTfDJVHV7agJphdSLT968OAa+NvrOyivClvOoCFcbM/hZn8qiqNg4dKo95Ikg3E2CUnNgW8GfHfJ/UtW+dkniWPLmpCsKntkqEEFBXwQ6MYebWLbyLuhE31dWpokvppPixnIahYWVWB0S3Q7z7fcxhtVzTFmrfvtBDmnaZvpxmwy9O/VJbykux root@verinon-desktop"
}
    resource "aws_instance" "terraformmachine"
{

    ami="ami-7d132e18",
    instance_type="t2.micro",
    key_name="${aws_key_pair.terraform_ec2_key.key_name}"
}
