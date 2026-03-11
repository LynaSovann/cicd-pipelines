#### Terraform commands

These commands are used to set up, check, and deploy infrastructure using `Terraform`.

```bash
terraform init
```

- Intializes the Terraform project.
- It downloads the required provider and prepares the working directory so Terraform can run.

```bash
terraform fmt
```

- Formats Terraform configuration files to follow the standard Terraform style.
- This helps keep the code clean and consistent.

```bash
terraform validate
```

- Checks the Terraform configuration files for syntax errors and verifies that the configuration is valid before deployment.

```bash
terraform plan
```

- Shows a preview of the changes Terraform will make to the infrastructure.
- It lets you review what will be created, modified, or deleted before applying the changes.

```bash
terraform apply
```

- Applies the changes defined in the Terraform configuration and creates or updates the infrastructure.
