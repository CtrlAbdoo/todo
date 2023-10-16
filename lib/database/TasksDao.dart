import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/UsersDao.dart';
import 'package:todo/database/model/Task.dart';

class TasksDao{
   static CollectionReference<Task> getTasksCollection(String uid){
    return UsersDao.getUserCollection()
        .doc(uid)
        .collection(Task.CollectionName)
        .withConverter(
        fromFirestore: (snapshot, options) => Task.fromFirestore(snapshot.data()),
        toFirestore: (task, options) => task.toFireStore(),
    );
  }
  static Future<void> creatTask(Task task , String uid){
    var docRef = getTasksCollection(uid)
        .doc();

    task.id = docRef.id;
    return docRef.set(task);
  }
}