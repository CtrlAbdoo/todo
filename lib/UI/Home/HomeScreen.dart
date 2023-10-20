import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/AuthProvider.dart';
import 'package:todo/UI/Login/LoginScreen.dart';
import 'package:todo/UI/settings/settings_tab.dart';
import 'package:todo/UI/tasks_list/AddTaskSheet.dart';
import 'package:todo/UI/tasks_list/TasksListTab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'To Do List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.primaryContainer),
            onPressed: () {
              authProvider.logout();
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          ),
        ],
      ),

        backgroundColor: Color(0xFFDFECDB),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ClipOval(
        child: FloatingActionButton(
          shape: StadiumBorder(
            side: BorderSide(
              color: Colors.white,
              width: 5
            )
          ),
          onPressed: () {
            showAddTaskBottomSheet();
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 86,
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          color: Colors.transparent,
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index){
              selectedIndex= index;
              setState((){selectedIndex= index;});
            },
            iconSize: 27,
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list_outlined), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: ''),
            ],
          ),
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  int selectedIndex = 0;

  var tabs = [TasksListTab(),SettingsTab()];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(context: context,
        builder: (context) {
          return AddTaskBottomSheet();
        },
    );
  }
}
