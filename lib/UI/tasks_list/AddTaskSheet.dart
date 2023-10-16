import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/AuthProvider.dart';
import 'package:todo/UI/DialogUtils.dart';
import 'package:todo/UI/common/CustomFormField.dart';
import 'package:todo/database/TasksDao.dart';
import 'package:todo/database/model/Task.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Add new Task',
                style: TextStyle(
                  color: Color(0xFF383838),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            CustomFormField(hintText: 'Title',
              validator: (text){
              if(text == null || text.trim().isEmpty){
                return'please enter task title';
              }
              },
              controller: titleController,
            ),
            CustomFormField(hintText: 'Description', lines: 4,
              validator: (text){
                if(text == null || text.trim().isEmpty){
                  return'please enter task Description';
                }
              },
                controller: descriptionController,
            ),
            InkWell(
              onTap: (){
                showTaskDatePiker();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Colors.grey
                    )
                  )
                ),
                  child: Text(
                     selectedDate == null?
                     'Date'
                         :'${selectedDate?.day} / ${selectedDate?.month} / ${selectedDate?.year}'
                  )),
            ),
            Visibility(
              visible: showDateError,
              child: Text('please select Task Date ' ,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed:(){
              addTask();

              }, child: Text('Add Task'))
          ],
        ),
      ),
    );
  }
  bool showDateError = false;
  bool isValidForm(){
    bool isValid = true;
    if(formKey.currentState?.validate() == false){
      isValid = false;
    }
    if(selectedDate==null){
      setState(() {
        showDateError=true;
      });
      isValid = false;
    }
    return isValid;
  }
  void addTask() async {
    // Added a null check on selectedDate before accessing it.
    if (selectedDate != null) {
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      Task task = Task(
          title: titleController.text,
          description: descriptionController.text,
          dateTime: Timestamp.fromMillisecondsSinceEpoch(selectedDate!.millisecondsSinceEpoch)
      );
      DialogUtils.showLoading(context, 'creating task....');
      await TasksDao.creatTask(task, authProvider.databaseUser!.id!);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, 'Task Created Successfully',
          isCancelable: false,
          posActionTitle: 'ok',
          posAction: (){
            Navigator.pop(context);
          }
      );
    }
  }



  DateTime? selectedDate;
  void showTaskDatePiker() async{
    var date = await showDatePicker(context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));


    setState(() {
      selectedDate = date;
      if(selectedDate!=null){
        showDateError = false;
      }
    });
  }
}
