import 'package:flutter/material.dart';
import 'package:notapp/model/notes_model.dart';
import 'package:notapp/widget/edit/edit_note_view_body.dart';

class EditNoteView extends StatelessWidget {
  const EditNoteView({super.key, required this.notesModel});
  final NotesModel notesModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: EditNoteViewBody(
          notesModel: notesModel,
        ),
      ),
    );
  }
}
