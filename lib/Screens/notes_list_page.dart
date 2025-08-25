import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import '../services/notes_service.dart';
import 'note_detail_page.dart';

class NotesListPage extends StatefulWidget {
  static String id = 'NotesListPage';
  const NotesListPage({super.key});

  @override
  State<NotesListPage> createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  final NotesService _notesService = NotesService();

  void _addNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetailPage(
          onSave: (title, content) async {
            await _notesService.addNote(title, content);
          },
        ),
      ),
    );
  }

  void _editNote(DocumentSnapshot doc) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetailPage(
          initialTitle: doc['title'],
          initialContent: doc['content'],
          onSave: (title, content) async {
            await _notesService.updateNote(doc.id, title, content);
          },
        ),
      ),
    );
  }

  void _deleteNote(DocumentSnapshot doc) async {
    await _notesService.deleteNote(doc.id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Note deleted successfully!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: const Text(
          'My Notes',
          style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _notesService.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final notes = snapshot.data?.docs ?? [];
          if (notes.isEmpty) {
            return const Center(
              child: Text('No notes yet', style: TextStyle(fontSize: 18, color: Colors.grey)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final doc = notes[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    doc['title'],
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      doc['content'],
                      style: const TextStyle(fontFamily: 'Roboto', fontSize: 14, color: Colors.grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: kPrimaryColor),
                    onSelected: (value) {
                      if (value == 'edit') _editNote(doc);
                      else if (value == 'delete') _deleteNote(doc);
                    },
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Row(
                          children: [Icon(Icons.edit, color: kPrimaryColor), SizedBox(width: 8), Text('Edit')],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Row(
                          children: [Icon(Icons.delete, color: Colors.red), SizedBox(width: 8), Text('Delete')],
                        ),
                      ),
                    ],
                  ),
                  onTap: () => _editNote(doc),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
