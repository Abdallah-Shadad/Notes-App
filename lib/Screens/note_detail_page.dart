import 'package:flutter/material.dart';
import 'package:notes/constants.dart';

class NoteDetailPage extends StatefulWidget {
  final String? initialTitle;
  final String? initialContent;
  final Function(String title, String content) onSave;

  const NoteDetailPage({
    super.key,
    this.initialTitle,
    this.initialContent,
    required this.onSave,
  });

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _contentController = TextEditingController(text: widget.initialContent ?? '');
    _titleController.addListener(_onTextChanged);
    _contentController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() => _hasChanges = true);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title'), backgroundColor: Colors.red),
      );
      return;
    }

    await widget.onSave(_titleController.text.trim(), _contentController.text.trim());
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note saved successfully!'), backgroundColor: Colors.green),
    );
  }

  Future<bool> _onWillPop() async {
    if (!_hasChanges) return true;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unsaved Changes'),
        content: const Text('You have unsaved changes. Discard them?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Discard', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () async { if (await _onWillPop()) Navigator.pop(context); }),
          title: Text(widget.initialTitle != null ? 'Edit Note' : 'New Note', style: const TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 20, fontWeight: FontWeight.bold)),
          actions: [IconButton(icon: const Icon(Icons.save, color: Colors.white), onPressed: _saveNote)],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Roboto', color: kPrimaryColor),
                decoration: const InputDecoration(hintText: 'Note title...', hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: 'Roboto'), border: InputBorder.none),
                textCapitalization: TextCapitalization.words,
              ),
              const Divider(color: Colors.grey, thickness: 1),
              const SizedBox(height: 16),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  style: const TextStyle(fontSize: 16, fontFamily: 'Roboto', height: 1.5),
                  decoration: const InputDecoration(hintText: 'Start writing your note...', hintStyle: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'Roboto'), border: InputBorder.none),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _saveNote,
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.save, color: Colors.white),
        ),
      ),
    );
  }
}
