import 'package:flutter/material.dart';
import 'package:notes/home_page.dart';

class HandleNotePage extends StatefulWidget {
  const HandleNotePage({super.key, this.note});

  final Note? note;

  @override
  HandleNotePageState createState() => HandleNotePageState();
}

class HandleNotePageState extends State<HandleNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();

  bool _isEdit = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final arguments = ModalRoute.of(context)!.settings.arguments;

        if (arguments is Map && arguments['note'] is Note) {
          _titleController.text = arguments['note'].title;
          _subtitleController.text = arguments['note'].subtitle;

          setState(() {
            _isEdit = true;
          });
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(
        Note(
          title: _titleController.text,
          subtitle: _subtitleController.text,
        ),
      );
    }
  }

  void _delete() {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit note' : 'Add note'),
        actions: [
          if (_isEdit)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _delete(),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
            key: _formKey,
            child: SafeArea(
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _subtitleController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a subtitle';
                      }
                      return null;
                    },
                    maxLines: null,
                    maxLength: 512,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _save,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save),
                        SizedBox(width: 8),
                        Text('Save'),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
