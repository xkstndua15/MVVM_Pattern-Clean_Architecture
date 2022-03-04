import 'package:flutter_note/domain/model/note/note.dart';
import 'package:flutter_note/domain/repo/note_repo.dart';

class UpdateNoteUseCase {
  final NoteRepo noteRepo;

  UpdateNoteUseCase(this.noteRepo);

  Future<void> call(Note note) async {
    noteRepo.updateNote(note);
  }
}
