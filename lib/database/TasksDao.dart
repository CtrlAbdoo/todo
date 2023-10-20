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
  static Future<List<Task>> getAllTasks(String uid)async{
    var taskSnapShot = await getTasksCollection(uid).get();
    var taskList = taskSnapShot.docs
    .map((snapshot) => snapshot.data()).toList();

    return taskList;
  }
  static Stream<QuerySnapshot<Task>> listenForTasks(String uid)async*{
    yield* getTasksCollection(uid).snapshots();
  }
  static Future<void> removeTask(String taskId,String uid) {
    return getTasksCollection(uid)
        .doc(taskId)
        .delete();
  }
}