import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';

class NotesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getNotes() {
    final user = FirebaseAuth.instance.currentUser;
    print('Current user: ${user?.uid}');
    if (user == null) return const Stream.empty();

    return _firestore
        .collection(kNotesCollection)
        .where('userId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> addNote(String title, String content) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await _firestore.collection(kNotesCollection).add({
      'title': title,
      'content': content,
      'userId': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateNote(String id, String title, String content) async {
    await _firestore.collection(kNotesCollection).doc(id).update({
      'title': title,
      'content': content,
    });
  }

  Future<void> deleteNote(String id) async {
    await _firestore.collection(kNotesCollection).doc(id).delete();
  }
}
