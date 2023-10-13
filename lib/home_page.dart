import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notes = <Note>[
    const Note(
      title: 'Note',
      subtitle: 'Edit this note',
    ),
  ];

  Future<void> _handleNavigation(Note? noteToEdit) async {
    final note = await Navigator.pushNamed(
      context,
      '/handle-note',
      arguments: {
        'note': noteToEdit,
      },
    );

    if (note is bool && note && noteToEdit != null) {
      setState(() {
        notes.removeAt(
          notes.indexOf(noteToEdit),
        );
      });

      return;
    }

    if (note is! Note) return;

    setState(() {
      if (noteToEdit == null) {
        notes.add(note);
      } else {
        final index = notes.indexOf(noteToEdit);
        notes[index] = note;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                for (var note in notes)
                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.article,
                        size: 32,
                      ),
                      title: Text(note.title),
                      subtitle: Text(
                        note.subtitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () => _handleNavigation(note),
                    ),
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _handleNavigation(null),
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ));
  }
}

// create a type for the note, it has to include a title and subtitle
class Note {
  final String title;
  final String subtitle;

  const Note({
    required this.title,
    required this.subtitle,
  });
}
