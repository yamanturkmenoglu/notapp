import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notapp/cubit/notes/notes_cubit.dart';
import 'package:notapp/model/notes_model.dart';
import 'package:notapp/widget/add_note_bottomsheet.dart';
import 'package:notapp/widget/custtom_appbar.dart';
import 'package:notapp/widget/custtom_textfild.dart';

class EditNoteViewBody extends StatefulWidget {
  const EditNoteViewBody({
    super.key,
    required this.notesModel,
  });
  final NotesModel notesModel;

  @override
  State<EditNoteViewBody> createState() => _EditNoteViewBodyState();
}

String? newTitle, newDescription;

class _EditNoteViewBodyState extends State<EditNoteViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        CusttomAppBar(
          onPressed: () {
            widget.notesModel.title = newTitle ?? widget.notesModel.title;
            widget.notesModel.subtitle =
                newDescription ?? widget.notesModel.subtitle;
            widget.notesModel.save();
            BlocProvider.of<NotesCubit>(context).fetchNotes();
            Navigator.pop(context);
          },
          icon: Icons.done,
          title: 'Edit Note',
        ),
        const SizedBox(
          height: 60,
        ),
        CusttomTextFild(
            onChanged: (data) {
              newTitle = data;
            },
            hintext: widget.notesModel.title),
        const SizedBox(
          height: 20,
        ),
        CusttomTextFild(
          onChanged: (data) {
            newDescription = data;
          },
          hintext: widget.notesModel.subtitle,
          maxline: 5,
        ),
        Expanded(
            child: EditColorList(
          notesModel: widget.notesModel,
        ))
      ],
    );
  }
}

class EditColorList extends StatefulWidget {
  const EditColorList({
    super.key,
    required this.notesModel,
  });
  final NotesModel notesModel;
  @override
  State<EditColorList> createState() => _EditColorListState();
}

late int currentIndex;

List<Color> colors = [
  const Color(0xFFFFEB3B), // Sarı
  const Color(0xFFEF5350), // Kırmızı
  const Color(0xFF42A5F5), // Mavi
  const Color(0xFF66BB6A), // Yeşil
  const Color(0xFFAB47BC), // Mor
  const Color(0xFFFF7043), // Turuncu
  const Color(0xFF26A69A), // Turkuaz
  const Color(0xFF9E9E9E), // Gri
];

class _EditColorListState extends State<EditColorList> {
  @override
  void initState() {
    currentIndex = colors.indexOf(Color(widget.notesModel.color));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: colors.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            currentIndex = index;
            widget.notesModel.color = colors[index].value;
            setState(() {});
          },
          child: ColorItem(
            selectedColor: currentIndex == index,
            colors: colors[index],
          ),
        );
      },
    );
  }
}
