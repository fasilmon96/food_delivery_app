class UserModel{
  final String id;
  final String name;
  final  String email;
  final  String password;
  final String profilePic;
  final int wallet;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.wallet

   });

  factory UserModel.fromJson(Map<String,dynamic>json)=>UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      password: json["password"],
      profilePic: json["profilePic"],
      wallet: json["wallet"],
  );
  Map<String,dynamic>toJson()=>{
    "id" : id,
    "name" : name,
    "email" : email,
    "password" : password,
    "profilePic" : profilePic,
    "wallet" : wallet,
  };
  UserModel copyWith({
    String?id,
    String?name,
    String?email,
    String?password,
    String?profilePic,
    int?wallet,




  })
  {
    return UserModel(
        id: id??this.id,
        name: name??this.name,
        email: email??this.email,
        password: password??this.password,
        profilePic: profilePic??this.profilePic,
        wallet: wallet??this.wallet,
       );
  }
}
