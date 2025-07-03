class User {
  final String email;
  final String password;
  final String name;
  final String address;

  User(this.email, this.password, this.name, this.address);
}

final List<User> users = [
    User("juan@gmail.com", "1234", "Juan Pérez", "Aranguren 61"),
    User("ana@gmail.com", "abcd", "Ana Gómez", "Yatay 127"),
    User("carlos@gmail.com", "car123", "Carlos Gonzalez", "Jose cubas 119"),
    User("luis@gmail.com", "pass", "Luis Martínez", "Rivadavia 0481"),
    User("maria@gmail.com", "0000", "María López", "Belgrano 1308"),
  ];
