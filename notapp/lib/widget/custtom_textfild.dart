import 'package:flutter/material.dart';

class CusttomTextFild extends StatelessWidget {
  const CusttomTextFild(
      {super.key, required this.hintext, this.maxline, this.onSaved, this.onChanged});
  final String hintext;
  final int? maxline;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        onChanged:onChanged ,
        onSaved: onSaved,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Filde is required';
          } else {
            return null;
          }
        },
        maxLines: maxline,
        cursorColor: Colors.cyan,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          border: BuildBorder(),
          enabledBorder: BuildBorder(),
          focusedBorder: BuildBorder(),
          hintText: hintext,
          hintStyle: const TextStyle(
            color: Colors.cyan,
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  OutlineInputBorder BuildBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    );
  }
}
