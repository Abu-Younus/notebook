import 'package:flutter/material.dart';
import 'package:notebook/sharedpref/shared_pref.dart';

import '../database/database_management.dart';
import '../models/notebook_model.dart';

class NotebookViewModel extends ChangeNotifier{
  DatabaseManager db = DatabaseManager();
  bool? _isLoading = false;
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController contentTextEditingController = TextEditingController();
  String _selectedDate = '';
  List<Notebook> noteList = [];
  List<Notebook> noteListContainer = [];

  String get selectedDate => _selectedDate;

  set selectedDate(String value) {
    _selectedDate = value;
    notifyListeners();
  }

  bool? get isLoading => _isLoading;

  set isLoading(bool? value) {
    _isLoading = value;
  }

  void resetNotebook() {
    isLoading = true;
    noteList = [];
    noteListContainer = [];
    notifyListeners();
  }

  void notifier() {
    notifyListeners();
  }

  void resetAddPage() {
    _selectedDate = '';
    titleTextEditingController.clear();
    contentTextEditingController.clear();
  }

  void resetUpdatePage(Notebook notebook) {
    _selectedDate = notebook.date ?? '';
    titleTextEditingController.text = notebook.title ?? '';
    contentTextEditingController.text = notebook.content ?? '';
  }

  void fetchNoteListVM() async{
    resetNotebook();
    try {
      noteList = await db.fetchNoteList(PreferenceManagement.getUserId()!);
      noteListContainer = noteList;
    } catch(error) {
      print(error.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void insertNoteVM(BuildContext context) async {
    if (titleTextEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter title'),
        ),
      );
    } else if (contentTextEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter content'),
        ),
      );
    } else if (selectedDate == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select date'),
        ),
      );
    } else {
      Notebook notebook = Notebook(
        userid: PreferenceManagement.getUserId(),
        title: titleTextEditingController.text,
        content: contentTextEditingController.text,
        date: selectedDate,
      );
      int insert = await db.insertNote(notebook);
      if (insert > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note has been successfuly added'),
          ),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note can not be added right now'),
          ),
        );
      }
    }
  }

  void updateNoteVm(int noteId, BuildContext context) async {
    if (titleTextEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter title'),
        ),
      );
    } else if (contentTextEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter content'),
        ),
      );
    } else if (selectedDate == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select date'),
        ),
      );
    } else {
      Notebook notebook = Notebook(
        id: noteId,
        userid: PreferenceManagement.getUserId(),
        title: titleTextEditingController.text,
        content: contentTextEditingController.text,
        date: selectedDate,
      );
      int update = await db.updateNote(notebook);
      if (update > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note has been successfuly updated'),
          ),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note can not be updated right now'),
          ),
        );
      }
    }
  }

  void deleteNoteVM(int id, BuildContext context) async {
    try {
      int isDeleted = await db.deleteNote(id);
      if (isDeleted > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note has been deleted'),
          ),
        );
        fetchNoteListVM();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note can not be deleted'),
          ),
        );
      }
    } catch (error) {
      print(error.toString());
    }
  }

  void filterByQuery(String query) {
    if (query.isEmpty) {
      noteList = noteListContainer;
    } else {
      List<Notebook> mList = [];
      for (Notebook notebook in noteListContainer) {
        if (notebook.title!.toLowerCase().contains(query.toLowerCase()) ||
            notebook.content!.toLowerCase().contains(query.toLowerCase()) || notebook.date!.contains(query)) {
          mList.add(notebook);
        }
      }
      noteList = mList;
    }
    notifyListeners();
  }
}