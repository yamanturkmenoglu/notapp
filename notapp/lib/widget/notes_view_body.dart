import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notapp/cubit/notes/notes_cubit.dart';
import 'package:notapp/widget/custtom_appbar.dart';
import 'package:notapp/widget/note_list_view.dart';

class NotesViewBody extends StatefulWidget {
  const NotesViewBody({
    super.key,
  });

  @override
  State<NotesViewBody> createState() => _NotesViewBodyState();
}

class _NotesViewBodyState extends State<NotesViewBody> {
  @override
  void initState() {
    BlocProvider.of<NotesCubit>(context).fetchNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 50,
        ),
        CusttomAppBar(
          icon: Icons.search,
          title: 'Notes',
        ),
        Expanded(
          child: NoteListView(),
        )
      ],
    );
  }
}
