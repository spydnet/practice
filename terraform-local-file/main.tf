resource "local_file" "pet" {
  filename = var.filename
  content = "We love ${random_pet.my-pet.id}! Time: ${time_static.time-stamp.id}"
  file_permission = "0700"
  depends_on = [
    time_static.time-stamp,
    random_pet.my-pet
  ]
}

resource "random_pet" "my-pet" {
  prefix = var.prefix
  separator = var.separator
  length = var.length
}

resource "time_static" "time-stamp" {
}