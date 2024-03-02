import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notapp/cubit/notes/notes_cubit.dart';
import 'package:notapp/model/notes_model.dart';
import 'package:notapp/view/edit_note_view.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.notesModel,
  });
  final NotesModel notesModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EditNoteView(notesModel: notesModel);
        }));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(top: 20, left: 10),
        decoration: BoxDecoration(
            color: Color(notesModel.color),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            ListTile(
              title: Text(
                notesModel.title,
                style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  notesModel.subtitle,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.3),
                      fontWeight: FontWeight.w600),
                ),
              ),
              trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteConfirmationDialog(
                          onDeleteConfirmed: () {
                            notesModel.delete();
                            BlocProvider.of<NotesCubit>(context).fetchNotes();
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 28,
                    color: Colors.black,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, bottom: 35, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    notesModel.date.substring(0, 11),
                    style: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.4)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteConfirmationDialog extends StatelessWidget {
  final VoidCallback onDeleteConfirmed;

  const DeleteConfirmationDialog({
    Key? key,
    required this.onDeleteConfirmed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Delete Note",
        style: TextStyle(color: Colors.cyan),
      ),
      content: const Text("Are you sure you want to delete this note?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.cyan),
          ),
        ),
        TextButton(
          onPressed: onDeleteConfirmed,
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.cyan),
          ),
        ),
      ],
    );
  }
}
