# Overview

This is a Terraform project to setup a CloudSQL database in the Google Cloud Platform.

Like most Terraform scripts it is driven by variables. Change your variables (defined in `variables.tf`) in `terraform.tfvars` to control the type and configuration of your database instance.

# Goals

This project is intended to be called to stand up a database rather quickly. It is expected to be called once to setup the database instance while other Terraform scripts are expected to add their own databases to it.


# Features

It will assign a random password to the user if you don't assign one. It can be accessed in `random_id.user-password.hex`. If you define one in your variables, then your password will be used.

The script will allow you to enter an external network name and CIDR allowed to access the database. Populate the `network_name` and `network_cidr` variables.

# Terraform Variables

Here is a sample `*.tfvars` file for setting up a simple database:

    instance_name = "webdb"
    region = "us-central1"
    network_name = "Office Network"
    network_cidr = "236.25.0.0/16"

The above creates a MySQL 5.7 (default) instance with the name of "webdb" in the US Central region. The "Office Network" with the given CIDR will be able to access the database instance with the user name of "default" and a randomly generated password output when the script completes.

