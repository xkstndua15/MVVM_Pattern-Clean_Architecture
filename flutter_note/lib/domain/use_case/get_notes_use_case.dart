import 'package:flutter_note/domain/model/note/note.dart';
import 'package:flutter_note/domain/repo/note_repo.dart';
import 'package:flutter_note/domain/util/note_order.dart';

class GetNotesUseCase {
  final NoteRepo noteRepo;

  GetNotesUseCase(this.noteRepo);

  Future<List<Note>> call(NoteOrder noteOrder) async {
    List<Note> notes = await noteRepo.getNotes();
    noteOrder.when(
      title: (orderType) {
        orderType.when(
          ascending: () {
            notes.sort((a, b) => a.title.compareTo(b.title));
          },
          descending: () {
            notes.sort((a, b) => -a.title.compareTo(b.title));
          },
        );
      },
      date: (orderType) {
        orderType.when(
          ascending: () {
            notes.sort((a, b) => a.color.compareTo(b.color));
          },
          descending: () {
            notes.sort((a, b) => -a.color.compareTo(b.color));
          },
        );
      },
      color: (orderType) {
        orderType.when(
          ascending: () {
            notes.sort((a, b) => a.timestamp.compareTo(b.timestamp));
          },
          descending: () {
            notes.sort((a, b) => -a.timestamp.compareTo(b.timestamp));
          },
        );
      },
    );

    return notes;
  }
}
