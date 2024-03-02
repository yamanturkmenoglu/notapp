import 'package:flutter/material.dart';

class CusttomAppBar extends StatelessWidget {
  const CusttomAppBar({
    super.key,
    required this.icon,
    required this.title,
    this.onPressed,
  });
  final IconData icon;
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(81, 158, 158, 158),
          ),
          child: IconButton(
            icon: Icon(icon),
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
