class User {
  String? idUser;
  final String nameUser;
  final String email;
  final String address;
  final int phoneNumber;
  List<String>? searchIndex;

  User({
    this.idUser = '',
    required this.nameUser,
    required this.email,
    required this.address,
    required this.phoneNumber,
    this.searchIndex,
  });

  Map<String, dynamic> toJson() => {
    'idUser': idUser,
    'nameUser': nameUser,
    'email': email,
    'address': address,
    'phoneNumber': phoneNumber,
    'searchIndex' : searchIndex,
  };
  User fromJson(Map<String, dynamic> json) => User(
    idUser: json['idUser'],
    nameUser: json['nameUser'],
    email: json['email'],
    address: json['address'],
    phoneNumber: json['phoneNumber'],
    searchIndex: [],
  );


}
