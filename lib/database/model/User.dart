class User{
  static const  String collectionName = 'Users';
  String? id;
  String? fullName;
  String? userName;
  String? email;

  User({
    this.id,
    this.fullName,
    this.userName,
    this.email
});

  User.fromfirestore(Map<String, dynamic>? data) {
    if (data != null) {
      id = data['id'];
      fullName = data['fullName'];
      userName = data['userName'];
      email = data['email'];
    }
  }
  // User.fromFireStore(Map<String,dynamic>? data){
  //   id = data?['id'];
  //   fullName = data?['fullName'];
  //   userName = data?['userName'];
  //   email = data?['email'];
  // }
  Map<String , dynamic>toFireStore(){
    return{
      'id':id,
      'email':userName,
      'userName':userName,
      'fullName':fullName
    };
  }
}