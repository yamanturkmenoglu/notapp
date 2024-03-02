import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notapp/cubit/notes/notes_state.dart';
import 'package:notapp/model/notes_model.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());
  List<NotesModel>? note;
  fetchNotes() {
    var notesBox = Hive.box<NotesModel>('note_box');
    note = notesBox.values.toList();
    emit(NotesSuccses());
  }
}
