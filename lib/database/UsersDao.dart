import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/model/User.dart';

class UsersDao{
  static CollectionReference<User> getUserCollection(){
    var db = FirebaseFirestore.instance;
    var userCollection = db.collection(User.collectionName)
        .withConverter(fromFirestore: (snapshot, options) => User.fromfirestore(snapshot.data()),
      toFirestore: (object, options) => object.toFireStore(),
    );
    return userCollection;
  }

  static Future<void> creatUser(User user){
    var userCollection = getUserCollection();
    var doc = userCollection.doc(user.id);
   return doc.set(user);
  }

  static Future<User?> getUser(String uid) async{
    var doc = getUserCollection()
        .doc(uid);

    var docSnapshot = await doc.get();
    print(await docSnapshot.data());
    print('/////////');
    return docSnapshot.data();
  }
}