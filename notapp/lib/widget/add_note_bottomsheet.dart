import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notapp/cubit/add_notes/add_notes_cubit.dart';
import 'package:notapp/cubit/add_notes/add_notes_state.dart';
import 'package:notapp/cubit/notes/notes_cubit.dart';
import 'package:notapp/model/notes_model.dart';
import 'package:notapp/widget/custtom_button.dart';
import 'package:notapp/widget/custtom_textfild.dart';

class AddNoteButtomSheet extends StatelessWidget {
  const AddNoteButtomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNotesCubit(),
      child: Container(
        height: 500,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF222121),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: BlocConsumer<AddNotesCubit, AddNotesState>(
          listener: (context, state) {
            if (state is AddNotesLoaded) {
              Navigator.of(context).pop();
              BlocProvider.of<NotesCubit>(context).fetchNotes();
            }
            if (state is AddNotesError) {}
          },
          builder: (context, state) {
            return AbsorbPointer(
                absorbing: state is AddNotesLoaded ? true : false,
                child: const AddNoteForm());
          },
        ),
      ),
    );
  }
}

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    super.key,
  });

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  GlobalKey<FormState> formkey = GlobalKey();
  AutovalidateMode autovalidate = AutovalidateMode.disabled;
  String? title, subtitle;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      autovalidateMode: autovalidate,
      child: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'Add Note',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          CusttomTextFild(
            onSaved: (data) {
              title = data;
            },
            hintext: 'Title',
          ),
          const SizedBox(
            height: 20,
          ),
          CusttomTextFild(
            onSaved: (data) {
              subtitle = data;
            },
            hintext: 'Content ',
            maxline: 5,
          ),
          const SizedBox(
            height: 10,
          ),
          const Expanded(child: ColorList()),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<AddNotesCubit, AddNotesState>(
            builder: (context, state) {
              return CusttomButton(
                isloading: state is AddNotesLoading ? true : false,
                onTap: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    var notesModel = NotesModel(
                        title: title!,
                        subtitle: subtitle!,
                        date: DateTime.now().toString(),
                        color: Colors.amber.value);
                    BlocProvider.of<AddNotesCubit>(context).addNote(notesModel);
                  } else {
                    setState(() {
                      autovalidate = AutovalidateMode.always;
                    });
                  }
                },
              );
            },
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

class ColorItem extends StatelessWidget {
  const ColorItem({
    super.key,
    required this.selectedColor,
    required this.colors,
  });
  final bool selectedColor;
  final Color colors;
  @override
  Widget build(BuildContext context) {
    return selectedColor
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: colors,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: colors,
            ),
          );
  }
}

class ColorList extends StatefulWidget {
  const ColorList({
    super.key,
  });

  @override
  State<ColorList> createState() => _ColorListState();
}

int currentIndex = 0;
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

class _ColorListState extends State<ColorList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: colors.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            currentIndex = index;
            BlocProvider.of<AddNotesCubit>(context).color = colors[index];
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
