import 'package:flutter/material.dart';
import 'package:power_todolist/l10n/localization_intl.dart';

class EditDialogWidget extends StatelessWidget {
  final VoidCallback onPositive;
  final bool positiveWithPop;
  final String title;
  final String hintText;
  final String initialValue;
  final ValueChanged<String> onValueChanged;
  final TextStyle cancelTextStyle;
  final TextStyle sureTextStyle;

  const EditDialogWidget({
    Key key,
    this.onPositive,
    this.title,
    this.hintText,
    this.initialValue,
    this.onValueChanged,
    this.cancelTextStyle,
    this.sureTextStyle,
    this.positiveWithPop = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(title ?? ""),
      content: Form(
        autovalidate: true,
        child: Theme(
          data: ThemeData(platform: TargetPlatform.android),
          child: TextFormField(
            initialValue: initialValue ?? "",
            validator: (text) {
              if (onValueChanged != null) onValueChanged(text);
              return null;
            },
            decoration: InputDecoration(
              hintText: hintText ?? "",
            ),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            MyLocalizations.of(context).cancel,
            style: cancelTextStyle ?? TextStyle(color: Colors.redAccent),
          ),
        ),
        FlatButton(
          onPressed: () {
            if (onPositive != null) onPositive();
            if (positiveWithPop) Navigator.of(context).pop();
          },
          child: Text(
            MyLocalizations.of(context).ok,
            style: sureTextStyle ?? TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
