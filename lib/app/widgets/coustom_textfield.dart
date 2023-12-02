import 'package:flutter/material.dart';

class CoustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController? textcontroller;
  final Widget icon;
  final Color? textcolor;
  const CoustomTextField({
    super.key,
    required this.hint,
    this.textcontroller,
    required this.icon,
    this.textcolor,
  });

  @override
  State<CoustomTextField> createState() => _CoustomTextFieldState();
}

class _CoustomTextFieldState extends State<CoustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textcontroller,
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        hintText: widget.hint,
        hintStyle: TextStyle(color: widget.textcolor),
        border: const OutlineInputBorder(borderSide: BorderSide()),
      ),
    );
  }
}
