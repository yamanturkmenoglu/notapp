import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notapp/cubit/add_notes/add_notes_state.dart';
import 'package:notapp/model/notes_model.dart';

class AddNotesCubit extends Cubit<AddNotesState> {
  AddNotesCubit() : super(AddNotesInitial());

  Color color = const Color(0xFFFFEB3B);
  addNote(NotesModel note) async {
    emit(AddNotesLoading());
    try {
      var notesBox = Hive.box<NotesModel>('note_box');
      await notesBox.add(note);
      note.color = color.value;
      emit(AddNotesLoaded());
    } catch (e) {
      emit(AddNotesError(e.toString()));
    }
  }
}
