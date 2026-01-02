{
  age = {
    secrets = {
      secret1 = {
        file = ../../secrets/secret1.age;
      };
      neversad-secrets = {
        file = ../../secrets/neversad-secrets.age;
        owner = "neversad";
      };
    };
  };
}
