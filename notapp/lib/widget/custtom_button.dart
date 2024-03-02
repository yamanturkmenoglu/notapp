import 'package:flutter/material.dart';

class CusttomButton extends StatelessWidget {
  const CusttomButton({
    super.key,
    this.onTap,
    this.isloading = false,
  });
  final void Function()? onTap;
  final bool isloading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
            child: isloading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : const Text(
                    'Add',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
      ),
    );
  }
}
