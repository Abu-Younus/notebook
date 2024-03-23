import 'package:flutter/material.dart';
import 'package:notebook/pages/add_note.dart';
import 'package:notebook/pages/drawer_page.dart';
import 'package:notebook/pages/update_note.dart';
import 'package:notebook/utill/utill.dart';
import 'package:notebook/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

import '../database/database_management.dart';
import '../viewmodel/notebook_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseManager db = DatabaseManager();

  @override
  void initState() {
    super.initState();
    NotebookViewModel notebookViewModel =
    Provider.of<NotebookViewModel>(context, listen: false);
    notebookViewModel.fetchNoteListVM();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotebookViewModel>(builder: (_, provider, ___) {
      return Consumer<UserViewModel>(builder: (_, userViewModel, ___) {
        return RefreshIndicator(
          onRefresh: () async {},
          child: provider.isLoading == true
              ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
              : Scaffold(
            appBar: AppBar(
              title: Text('Notebook'),
              centerTitle: true,
            ),
            drawer: DrawerPage(),
            floatingActionButton: Container(
              margin: const EdgeInsets.only(right: 20, bottom: 20),
              child: FloatingActionButton(
                onPressed: () async {
                  bool? isAdded = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddNote()));
                  if (isAdded != null && isAdded == true) {
                    provider.fetchNoteListVM();
                  }
                },
                child: const Icon(Icons.add),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 16, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.menu_book),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Hello, ${userViewModel.userData.name}',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '${Util.greeting()}',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Search by title',
                        prefixIcon: Icon(Icons.search_sharp),
                        filled: true,
                        fillColor: Colors.grey.shade400,
                        border: InputBorder.none),
                    onChanged: (query) {
                      provider.filterByQuery(query);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                      itemCount: provider.noteList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueGrey,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.noteList[index].title ?? '',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      provider.noteList[index].content ?? '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      provider.noteList[index].date ?? '',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuButton(
                                icon: Icon(Icons.more_vert),
                                itemBuilder: (context) {
                                  return [
                                    const PopupMenuItem(
                                      value: 0,
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text('Edit'),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 1,
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text('Delete'),
                                        ],
                                      ),
                                    ),
                                  ];
                                },
                                onSelected: (value) async {
                                  if (value == 0) {
                                    bool? isUpadted = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateNote(notebook: provider
                                                  .noteList[index]),
                                      ),
                                    );
                                    if (isUpadted != null &&
                                        isUpadted == true) {
                                      provider.fetchNoteListVM();
                                    }
                                  } else if (value == 1) {
                                    provider.deleteNoteVM(
                                        provider.noteList[index].id!, context);
                                  }
                                },
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
