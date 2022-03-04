import 'package:flutter/material.dart';
import 'package:flutter_note/domain/model/note/note.dart';
import 'package:flutter_note/domain/use_case/use_cases.dart';
import 'package:flutter_note/domain/util/note_order.dart';
import 'package:flutter_note/domain/util/order_type.dart';
import 'package:flutter_note/presentation/notes/notes_event.dart';
import 'package:flutter_note/presentation/notes/notes_state.dart';

class NotesViewModel with ChangeNotifier {
  final UseCases useCases;

  NotesState _state = NotesState(
    notes: [],
    noteOrder: const NoteOrder.date(OrderType.descending()),
    isOrderSectionVisible: false,
  );
  NotesState get state => _state;

  NotesViewModel(
    this.useCases,
  ) {
    _loadNotes();
  }

  Note? _recentlyDeletedNote;

  void onEvent(NotesEvent event) {
    event.when(
      loadNotes: _loadNotes,
      deleteNote: _deleteNote,
      restoreNote: _restoreNote,
      changeOrder: (NoteOrder noteOrder) {
        _state = state.copyWith(noteOrder: noteOrder);
        _loadNotes();
      },
      toggleOrderSection: () {
        _state =
            state.copyWith(isOrderSectionVisible: !state.isOrderSectionVisible);
        notifyListeners();
      },
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await useCases.getNotesUseCase(state.noteOrder);
    _state = state.copyWith(notes: notes);
    notifyListeners();
  }

  Future<void> _deleteNote(Note note) async {
    await useCases.deleteNoteUseCase(note);

    _recentlyDeletedNote = note;

    await _loadNotes();
  }

  Future<void> _restoreNote() async {
    if (_recentlyDeletedNote != null) {
      await useCases.addNoteUseCase(_recentlyDeletedNote!);
      _recentlyDeletedNote = null;

      await _loadNotes();
    }
  }
}
