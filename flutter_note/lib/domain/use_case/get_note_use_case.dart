import 'package:flutter_note/domain/model/note/note.dart';
import 'package:flutter_note/domain/repo/note_repo.dart';

class GetNoteUseCase {
  final NoteRepo noteRepo;

  GetNoteUseCase(this.noteRepo);

  Future<Note?> call(int id) async {
    return await noteRepo.getNoteById(id);
  }
}
