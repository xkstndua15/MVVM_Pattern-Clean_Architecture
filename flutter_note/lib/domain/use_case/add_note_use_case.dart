import 'package:flutter_note/domain/model/note/note.dart';
import 'package:flutter_note/domain/repo/note_repo.dart';

class AddNoteUseCase {
  final NoteRepo noteRepo;

  AddNoteUseCase(this.noteRepo);

  Future<void> call(Note note) async {
    await noteRepo.insertNote(note);
  }
}
