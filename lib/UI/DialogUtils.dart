import 'package:flutter/material.dart';

class DialogUtils{
  static void showLoading(BuildContext context , String message,
  {bool isCancelable = true}
      ){
    showDialog(context: context,
        builder: (buildContext){
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 6,),
                Text(message),
              ],
            ),
          );
        },
        barrierDismissible: isCancelable
    );
  }

  static void hideDialog(BuildContext context){
    Navigator.pop(context);
  }
}