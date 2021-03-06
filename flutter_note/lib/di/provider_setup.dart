import 'package:flutter_note/data/data_source/note_db_helper.dart';
import 'package:flutter_note/data/repo/note_repo_impl.dart';
import 'package:flutter_note/domain/repo/note_repo.dart';
import 'package:flutter_note/domain/use_case/add_note_use_case.dart';
import 'package:flutter_note/domain/use_case/delete_note_use_case.dart';
import 'package:flutter_note/domain/use_case/get_note_use_case.dart';
import 'package:flutter_note/domain/use_case/get_notes_use_case.dart';
import 'package:flutter_note/domain/use_case/update_note_use_case.dart';
import 'package:flutter_note/domain/use_case/use_cases.dart';
import 'package:flutter_note/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:flutter_note/presentation/notes/notes_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sqflite/sqflite.dart';

Future<List<SingleChildWidget>> getProviders() async {
  Database database =
      await openDatabase('notes_db', version: 1, onCreate: (db, version) async {
    await db.execute(
        'CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER, timestamp INTEGER)');
  });

  NoteDbHelper noteDbhelper = NoteDbHelper(database);
  NoteRepo noteRepo = NoteRepoImpl(noteDbhelper);
  UseCases useCases = UseCases(
    addNoteUseCase: AddNoteUseCase(noteRepo),
    deleteNoteUseCase: DeleteNoteUseCase(noteRepo),
    getNoteUseCase: GetNoteUseCase(noteRepo),
    getNotesUseCase: GetNotesUseCase(noteRepo),
    updateNoteUseCase: UpdateNoteUseCase(noteRepo),
  );
  NotesViewModel notesViewModel = NotesViewModel(useCases);
  AddEditNoteViewModel addEditNoteViewModel = AddEditNoteViewModel(noteRepo);

  return [
    ChangeNotifierProvider(create: (_) => notesViewModel),
    ChangeNotifierProvider(create: (_) => addEditNoteViewModel)
  ];
}
