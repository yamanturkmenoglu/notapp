import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notapp/cubit/notes/notes_cubit.dart';
import 'package:notapp/model/notes_model.dart';
import 'package:notapp/simple_bloc_observer.dart';
import 'package:notapp/view/notes_view.dart';

void main() async {
  await Hive.initFlutter();

  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('note_box');

  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
            create: (context) => NotesCubit(),
      child: MaterialApp(
        title: 'Notes App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Poppins'),
        home: const NotesView(),
      ),
    );
  }
}
