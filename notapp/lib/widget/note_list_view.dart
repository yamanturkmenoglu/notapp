import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notapp/cubit/notes/notes_cubit.dart';
import 'package:notapp/cubit/notes/notes_state.dart';
import 'package:notapp/model/notes_model.dart';
import 'package:notapp/widget/note_card.dart';

class NoteListView extends StatelessWidget {
  const NoteListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        List<NotesModel> note = BlocProvider.of<NotesCubit>(context).note ?? [];
        return ListView.builder(
            itemCount: note.length,
            itemBuilder: (context, index) {
              return NoteCard(notesModel: note[index]);
            });
      },
    );
  }
}
