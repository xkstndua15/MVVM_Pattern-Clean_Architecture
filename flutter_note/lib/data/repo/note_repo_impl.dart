import 'package:flutter_note/data/data_source/note_db_helper.dart';
import 'package:flutter_note/domain/model/note/note.dart';
import 'package:flutter_note/domain/repo/note_repo.dart';

class NoteRepoImpl implements NoteRepo {
  final NoteDbHelper db;

  NoteRepoImpl(this.db);

  @override
  Future<void> deleteNote(Note note) async {
    await db.deleteNote(note);
  }

  @override
  Future<Note?> getNoteById(int id) async {
    return await db.getNoteById(id);
  }

  @override
  Future<List<Note>> getNotes() async {
    return await db.getNotes();
  }

  @override
  Future<void> insertNote(Note note) async {
    await db.insertNote(note);
  }

  @override
  Future<void> updateNote(Note note) async {
    await db.updateNote(note);
  }
}
