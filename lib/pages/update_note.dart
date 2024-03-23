import 'package:flutter/material.dart';
import 'package:notebook/viewmodel/notebook_viewmodel.dart';
import 'package:provider/provider.dart';

import '../models/notebook_model.dart';

class UpdateNote extends StatefulWidget {
  final Notebook? notebook;
  const UpdateNote({super.key,this.notebook});

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  @override
  void initState() {
    super.initState();
    NotebookViewModel notebookViewModel = Provider.of<NotebookViewModel>(context, listen: false);
    notebookViewModel.resetUpdatePage(widget.notebook!);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotebookViewModel>(
        builder: (_,provider,___) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Update Note'),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                    child: Row(
                      children: [
                        Text(
                          'Title',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    child: TextField(
                      controller: provider.titleTextEditingController,
                      decoration: InputDecoration(
                        hintText: '',
                        fillColor: Colors.grey.shade400,
                        filled: true,
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                    child: Row(
                      children: [
                        Text(
                          'Content',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    child: TextField(
                      controller: provider.contentTextEditingController,
                      decoration: InputDecoration(
                        hintText: '',
                        fillColor: Colors.grey.shade400,
                        filled: true,
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                    child: Row(
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade400,
                    margin: const EdgeInsets.only(left: 32, right: 32),
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(provider.selectedDate == '' ? 'Select date' : provider.selectedDate),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050),
                        ).then((value) {
                          provider.selectedDate = value.toString().substring(0, 10);
                        });
                      },
                      trailing: const Icon(Icons.calendar_month_outlined),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      provider.updateNoteVm(widget.notebook!.id!, context);
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: 40,
                      margin: const EdgeInsets.only(bottom: 25, top: 25, right: 50, left: 50),
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}