import 'package:flutter/material.dart';
import 'package:hello/services/auth/auth_service.dart';
import 'package:hello/services/crud/notes_service.dart';

class NewNotesView extends StatefulWidget {
  const NewNotesView({super.key});

  @override
  State<NewNotesView> createState() => _NewNotesViewState();
}

class _NewNotesViewState extends State<NewNotesView> {
  DatabaseNote? _note;
  late final NotesService _notesService;
  late final TextEditingController __textController;

  @override
  void initState() {
    _notesService = NotesService();
    __textController = TextEditingController();
    super.initState();
  }

  Future<DatabaseNote> currentNote() async {
    final existingNote = _note;
    if (existingNote != null) return existingNote;
    final currentUser = Authservice.firebase().currentUser!;
    final email = currentUser.email!;
    final owner = await _notesService.getUser(email: email);
    return await _notesService.createNote(owner: owner);
  }

  void _deleteNoteIfEmpty() {
    final note = _note;
    if (_note != null && __textController.text.isEmpty) {
      _notesService.deleteNote(id: note!.id);
    }
  }

  void _saveNoteIfNotEmpty() async {
    final note = _note;
    final text = __textController.text;
    if (note != null && text.isNotEmpty) {
      await _notesService.updateNote(note: note, text: text);
    }
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final text = __textController.text;
    await _notesService.updateNote(note: note, text: text);
  }

  void _setupTextControllerListener() {
    __textController.removeListener(_textControllerListener);
    __textController.addListener(_textControllerListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _deleteNoteIfEmpty();
    _saveNoteIfNotEmpty();
    __textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Colors.greenAccent,
      ),
      body: FutureBuilder(
        future: currentNote(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _note = snapshot.data as DatabaseNote?;
              _setupTextControllerListener();
              return TextField(
                controller: __textController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: 'Start typing Your text Here'),
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
