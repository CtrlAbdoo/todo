import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/AuthProvider.dart';
import 'package:todo/UI/DialogUtils.dart';
import 'package:todo/database/TasksDao.dart';
import 'package:todo/database/model/Task.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget(this.task);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        children: [
          SlidableAction(onPressed:(context) {
            deleteTask();
          },icon: Icons.delete,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            topLeft: Radius.circular(12)
          ),
            label: 'Delete',
            backgroundColor: Colors.red,
          )
        ],
        motion: DrawerMotion(),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(18)
              ),
              width: 4,
              height: 64,
            ),
            Expanded(child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.task.title??'',style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.27,
                  ),),
                  Text(widget.task.description??'',style: TextStyle(
                    color: Color(0xFF363636),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.18,
                  ),)
                ],
              ),
            )),
            Container(
              padding:const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12)
              ),
              child: ImageIcon(
                AssetImage('assets/images/ic_check.png'),
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  void deleteTask() {
    DialogUtils.showMessage(context, 'Are U Sure U want to delete this Task',
      posActionTitle: 'Yes',
      posAction: () {
        deleteTaskFromFirestore();
      },
      negActionTitle: 'Cancel'
    );

  }

  void deleteTaskFromFirestore() async{
    var authProvider = Provider.of<AuthProvider>(context,listen: false);
    //DialogUtils.showLoading(context, 'deleting Task......');
    await TasksDao.removeTask(widget.task.id!,authProvider.databaseUser!.id!);
    //DialogUtils.hideDialog(context);

  }
}
