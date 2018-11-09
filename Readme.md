# gcpmsql

This is a terraform project to setup a CloudSQL database in the Google Cloud Platform.

Like most Terraform scripts it is driven by variables. Change your variables (defined in `variables.tf`) in `terraform.tfvars` to control the type and configuration of your database instance.

# Goals

This project is intended to be called to stand up a database rather quickly. It is expected to be called once to setup the database instance whil other terraform scripts are expected to add their own databases to it.


# Features

It will assign a random password to the user if you don't assign one. It can be accessed in `random_id.user-password.hex`. If you define one in your variables, then that password will be used.

The script will allow you to enter an external network name and CIDR allowed to access the database. Populate the `network_name` and `network_cidr` variables.


