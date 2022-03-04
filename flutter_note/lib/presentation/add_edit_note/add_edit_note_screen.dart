import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_note/domain/model/note/note.dart';
import 'package:flutter_note/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:flutter_note/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:flutter_note/ui/colors.dart';
import 'package:provider/provider.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  StreamSubscription? _streamSubscription;

  final List<Color> noteColors = [
    roseBud,
    primRose,
    wisteria,
    skyBlue,
    illusion
  ];

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }

    Future.microtask(() {
      final viewModel = context.read<AddEditNoteViewModel>();

      _streamSubscription = viewModel.eventStream.listen((event) {
        event.when(saveNote: () {
          Navigator.pop(context, true);
        }, showSnackBar: (String message) {
          const snackBar = SnackBar(
            content: Text('제목이나 내용이 비어있습니다'),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _streamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddEditNoteViewModel>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.onEvent(AddEditNoteEvent.saveNote(
              widget.note == null ? null : widget.note!.id,
              _titleController.text,
              _contentController.text));
        },
        child: const Icon(Icons.save),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
        color: Color(viewModel.color),
        child: ListView(
          children: [
            Row(
              children: noteColors
                  .map((color) => InkWell(
                      onTap: () {
                        viewModel
                            .onEvent(AddEditNoteEvent.changeColor(color.value));
                      },
                      child: _buildBackgroundColor(
                          color, viewModel.color == color.value)))
                  .toList(),
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            TextField(
              controller: _titleController,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: darkGrey),
              decoration: const InputDecoration(
                  hintText: '제목을 입력하세요', border: InputBorder.none),
              maxLines: 1,
            ),
            TextField(
              controller: _contentController,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: darkGrey),
              decoration: const InputDecoration(
                  hintText: '내용을 입력하세요', border: InputBorder.none),
              maxLines: null,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundColor(Color color, bool selected) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5.0,
                spreadRadius: 1.0)
          ],
          border:
              selected ? Border.all(color: Colors.black, width: 2.0) : null),
    );
  }
}
