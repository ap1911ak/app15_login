import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

void alert(BuildContext context, {
  required String title,
  required String content,
  Function()? okAction,
  bool showCancel = false,
}) {
  // ignore: prefer_function_declarations_over_variables
  Function okPressed = () {
    Navigator.of(context).pop();
    okAction!.call();
  };

  // ignore: prefer_function_declarations_over_variables
  Function? cancelPressed= (){
    Navigator.of(context).pop();
  };
var textTitle = Text(title, textScaler:TextScaler.linear(1.5),);
var textContent = Text(content, textScaler:TextScaler.linear(1.3));
var textOK = Text('OK', textScaler:TextScaler.linear(1.3));
var textCancel = Text('Cancel', textScaler:TextScaler.linear(1.3));

if (Platform.isAndroid){
  var btnOK = TextButton(
    onPressed: () => okPressed.call(),
    child: textOK);
    
  var btnCancel = TextButton(
    onPressed: cancelPressed.call(),
    child: textCancel);
  var btns = <TextButton>[
    btnOK,
  ];
  (showCancel) ? btns.add(btnCancel) : null;

  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: textTitle,
      content: textContent,
      actions: btns,
    ),
  );
  
} else if (Platform.isIOS || Platform.isMacOS) {
  var btnOK = CupertinoDialogAction(
    child: textOK,
    onPressed: () => okPressed.call());
  var btnCancel = CupertinoDialogAction(
    onPressed: cancelPressed.call(),
    child: textCancel); 
  var btns = [btnOK];
  (showCancel) ? btns.add(btnCancel) : null;

  showCupertinoDialog(
    context: context, 
    builder: (context) => CupertinoAlertDialog(
      title: textTitle,
      content: textContent,
      actions: btns,
    ),
  );
}
  
}