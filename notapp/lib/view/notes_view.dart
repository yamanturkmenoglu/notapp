import 'package:flutter/material.dart';
import 'package:notapp/widget/add_note_bottomsheet.dart';
import 'package:notapp/widget/notes_view_body.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const AddNoteButtomSheet();
              });
        },
        child: const Icon(Icons.add),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: NotesViewBody(),
      ),
    );
  }
}
