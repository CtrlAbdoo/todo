import 'package:flutter/material.dart';
import 'package:todo/UI/settings/settings_tab.dart';
import 'package:todo/UI/tasks_list/todos_list_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          onPressed: () {},
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
}
