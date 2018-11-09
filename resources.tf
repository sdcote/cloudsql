resource "google_sql_database_instance" "default" {
  name                 = "${var.instance_name}"
  project              = "${var.project}"
  region               = "${var.region}"
  database_version     = "${var.database_version}"
  master_instance_name = "${var.master_instance_name}"

  settings {
    tier                        = "${var.tier}"
    activation_policy           = "${var.activation_policy}"
    authorized_gae_applications = ["${var.authorized_gae_applications}"]
    disk_autoresize             = "${var.disk_autoresize}"
    location_preference         = ["${var.location_preference}"]
    maintenance_window          = ["${var.maintenance_window}"]
    disk_size                   = "${var.disk_size}"
    disk_type                   = "${var.disk_type}"
    pricing_plan                = "${var.pricing_plan}"
    replication_type            = "${var.replication_type}"
    database_flags              = ["${var.database_flags}"]
    backup_configuration {
      binary_log_enabled = false
      enabled = true
      start_time = "06:00"
    }
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name = "${var.network_name}"
        value = "${var.network_cidr}"
      }
    }
  }

  replica_configuration = ["${var.replica_configuration}"]
}

resource "google_sql_database" "default" {
  count     = "${var.master_instance_name == "" ? 1 : 0}"
  name      = "${var.db_name}"
  project   = "${var.project}"
  instance  = "${google_sql_database_instance.default.name}"
  charset   = "${var.db_charset}"
  collation = "${var.db_collation}"
}

resource "random_id" "user-password" {
  byte_length = 8
}

resource "google_sql_user" "default" {
  count    = "${var.master_instance_name == "" ? 1 : 0}"
  name     = "${var.user_name}"
  project  = "${var.project}"
  instance = "${google_sql_database_instance.default.name}"
  host     = "${var.user_host}"
  password = "${var.user_password == "" ? random_id.user-password.hex : var.user_password}"
}