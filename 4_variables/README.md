you can provide variable values throught default in variables block
If you want to override 
you can provide the desired values through 

# CLI
```

terraform plan -var="ec2_instance_type=t3.large" -var="ec2_instance_count=1"
terraform apply -var="ec2_instance_type=t3.large" -var="ec2_instance_count=1"
terraform plan -var="ec2_instance_type=t3.large" -var="ec2_instance_count=1" -out v3out.plan
terraform apply v3out.plan
```

# ENV varibles

- Set environment variables and execute `terraform plan` to see if it overrides default values 
```
- Sample
export TF_VAR_variable_name=value

# SET Environment Variables
export TF_VAR_no_of_instance=3
export TF_VAR_instane_type=t2.nano
export TF_VAR_no_of_instance=3, TF_VAR_instane_type=t2.nano
$ echo $TF_VAR_no_of_instance, $TF_VAR_instane_type

terraform plan

# UNSET Environment Variables after testing
unset export TF_VAR_no_of_instance
unset export TF_VAR_instane_type
$ echo $TF_VAR_no_of_instance, $TF_VAR_instane_type

```

# .tfvars 
- If the file name is `terraform.tfvars`, terraform will auto-load the variables present in this file by overriding the `default` values in `variables.tf`

- If we plan to use different names for  `.tfvars` files, then we need to explicitly provide the argument `-var-file` during the `terraform plan or apply`


- If you have multiple environments you can setup multiple .tfvars like dev.tfvars,prod.tfvars
-terraform apply -var-file=dev.tfvars
-terraform plan -var-file=prod.tfvars

# .auto.tfvars
- With this extension, whatever may be the file name, the variables inside these files will be auto loaded during `terraform plan or apply`

- If you dont specify the .tfars in the cli command, then tf choses the .auto.tfvas

- If auto.tfvars and terraform.tfvars tf loads for terraform.auto.tfvars


