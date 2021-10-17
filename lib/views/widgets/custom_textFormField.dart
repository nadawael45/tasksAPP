import 'package:flutter/material.dart';
class CustomTextFormField extends StatefulWidget {
  String?labeltext;
  var onTap;
  var validator;

  int? maxlines;
  bool readOnly;
  var onSaved;
  TextEditingController? controller;

  CustomTextFormField({this.labeltext, this.onTap,this.maxlines=1,this.readOnly=false,this.onSaved,this.controller,this.validator});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      maxLength: 30,
      readOnly: widget.readOnly,
      maxLines:widget.maxlines ,
      controller: widget.controller,
      onSaved: widget.onSaved,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labeltext!,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: BorderSide(width: 1,color: Colors.grey)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(width: 1,color: Colors.grey)),




    ),
    );
  }
}
