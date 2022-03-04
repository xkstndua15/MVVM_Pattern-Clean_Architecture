import 'package:flutter_note/domain/use_case/add_note_use_case.dart';
import 'package:flutter_note/domain/use_case/delete_note_use_case.dart';
import 'package:flutter_note/domain/use_case/get_note_use_case.dart';
import 'package:flutter_note/domain/use_case/get_notes_use_case.dart';
import 'package:flutter_note/domain/use_case/update_note_use_case.dart';

class UseCases {
  final AddNoteUseCase addNoteUseCase;
  final GetNoteUseCase getNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final GetNotesUseCase getNotesUseCase;

  UseCases({
    required this.addNoteUseCase,
    required this.getNoteUseCase,
    required this.deleteNoteUseCase,
    required this.updateNoteUseCase,
    required this.getNotesUseCase,
  });
}
