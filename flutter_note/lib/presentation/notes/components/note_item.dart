import 'package:flutter/material.dart';
import 'package:flutter_note/domain/model/note/note.dart';
import 'package:flutter_note/ui/colors.dart';

class NoteItem extends StatelessWidget {
  final Function? onDeleteTap;
  final Note note;

  const NoteItem({Key? key, required this.note, this.onDeleteTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(note.color)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                note.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .apply(color: darkGrey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                note.content,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .apply(color: darkGrey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ]),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
                onTap: () {
                  onDeleteTap?.call();
                },
                child: const Icon(Icons.delete)),
          )
        ],
      ),
    );
  }
}
