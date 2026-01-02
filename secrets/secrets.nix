let
  dell = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII2wKzWxbeENQIIt9McuGvyVmAvwpcaWIcY9NH5hVbL3";
  neversad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGT4wDVwwRefziU8NxEKI1c+7tqMZM7afXsyvN3kJPp neversad@mbair";
in {
  # agenix -e secret1.age
  "secret1.age".publicKeys = [dell neversad];
  "neversad-secrets.age".publicKeys = [dell neversad];
}
