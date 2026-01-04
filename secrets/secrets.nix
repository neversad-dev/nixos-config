let
  dell = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII2wKzWxbeENQIIt9McuGvyVmAvwpcaWIcY9NH5hVbL3";

  systems = [
    dell
  ];

  neversad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGT4wDVwwRefziU8NxEKI1c+7tqMZM7afXsyvN3kJPp neversad@mbair";

  users = [
    neversad
  ];
in {
  # create/edit secrets with: agenix -e secret1.age
  # after editing publicKeys run: agenix --rekey -i [path to private key]
  "secret1.age".publicKeys = systems ++ users;
  "neversad-secrets.age".publicKeys = systems ++ users;
}
