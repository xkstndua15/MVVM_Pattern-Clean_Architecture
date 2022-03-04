import 'package:flutter_note/domain/model/note/note.dart';
import 'package:flutter_note/domain/repo/note_repo.dart';

class DeleteNoteUseCase {
  final NoteRepo noteRepo;

  DeleteNoteUseCase(this.noteRepo);

  Future<void> call(Note note) async {
    await noteRepo.deleteNote(note);
  }
}
