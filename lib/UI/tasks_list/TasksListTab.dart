import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/AuthProvider.dart';
import 'package:todo/UI/tasks_list/TaskWidget.dart';
import 'package:todo/database/TasksDao.dart';
import 'package:todo/UI/Login/LoginScreen.dart';

class TasksListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: TasksDao.listenForTasks(authProvider.databaseUser?.id ?? ""),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AlertDialog(
                        title: Text("Error"),
                        content: Text("An error occurred. Please try again!"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                            },
                            child: Text("Try Again"),
                          ),

                        ],
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasData) {
                var tasksList = snapshot.data?.docs.map((doc) => doc.data()).toList();
                return ListView.builder(
                  itemBuilder: (context, index) {
                    // Display your task item here. Example:
                    return TaskWidget(tasksList![index]);
                  },
                  itemCount: tasksList?.length ?? 0,
                );
              }
              // Return a fallback UI while loading data.
              return Center(child: CircularProgressIndicator());
            },
          ),
        )
      ],
    );
  }
}
