import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_note/domain/model/note/note.dart';
import 'package:flutter_note/domain/repo/note_repo.dart';
import 'package:flutter_note/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:flutter_note/presentation/add_edit_note/add_edit_note_ui_event.dart';
import 'package:flutter_note/ui/colors.dart';

class AddEditNoteViewModel with ChangeNotifier {
  final NoteRepo noteRepo;

  int _color = roseBud.value;
  int get color => _color;

  final _eventController = StreamController<AddEditNoteUiEvent>.broadcast();
  Stream<AddEditNoteUiEvent> get eventStream => _eventController.stream;

  AddEditNoteViewModel(this.noteRepo);

  void onEvent(AddEditNoteEvent event) {
    event.when(changeColor: _changeColor, saveNote: _saveNote);
  }

  Future<void> _changeColor(int color) async {
    _color = color;
    notifyListeners();
  }

  Future<void> _saveNote(int? id, String title, String content) async {
    if (title.isEmpty || content.isEmpty) {
      _eventController
          .add(const AddEditNoteUiEvent.showSnackBar('제목이나 내용이 비어 있습니다'));

      return;
    }

    if (id == null) {
      await noteRepo.insertNote(Note(
          title: title,
          content: content,
          color: _color,
          timestamp: DateTime.now().millisecondsSinceEpoch));
    } else {
      await noteRepo.updateNote(Note(
          id: id,
          title: title,
          content: content,
          color: _color,
          timestamp: DateTime.now().millisecondsSinceEpoch));
    }

    _eventController.add(const AddEditNoteUiEvent.saveNote());
  }
}
