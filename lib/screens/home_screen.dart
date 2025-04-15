import 'package:flutter/material.dart';
import 'package:note_app/data/local/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> allNotes = [];
  DbHelper? dbRef;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbRef = DbHelper.getInstance; // Initialize dbRef
    getNotes();
  }

  getNotes() async {
    allNotes = await dbRef!.getAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Note App"), centerTitle: true),
      body:
          allNotes.isNotEmpty
              ? ListView.builder(
                itemCount: allNotes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(allNotes[index][DbHelper.Column_Note_Title]),
                      subtitle: Text(
                        allNotes[index][DbHelper.Column_Note_Description],
                      ),
                      trailing: SizedBox(
                        width: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    // Safely assign values to controllers
                                    titleController.text =
                                        allNotes[index][DbHelper
                                            .Column_Note_Title] 
                                        ;
                                    descriptionController.text =
                                        allNotes[index][DbHelper
                                            .Column_Note_Description] 
                                        ;
                                    return getBottomSheetWidget(
                                      isUpdate: true,
                                      sno:
                                          allNotes[index][DbHelper
                                              .Column_Note_SNO],
                                    );
                                  },
                                );
                              },
                              child: Icon(Icons.edit, color: Colors.blue),
                            ),
                            InkWell(
                              onTap: () async {
                                bool check = await dbRef!.deleteNote(
                                  sno: allNotes[index][DbHelper.Column_Note_SNO],
                                );
                                if (check) {
                                  getNotes();
                                }
                              },
                              child: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
              : const Center(child: Text("No Notes Yet!!!")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
                titleController.clear();
             descriptionController.clear();
              return getBottomSheetWidget();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget getBottomSheetWidget({bool isUpdate = false, int sno = 0}) {
    return Container(
      height:
          MediaQuery.of(context).size.height * 0.5 +
          MediaQuery.of(context).viewInsets.bottom,
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
        bottom: 12 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isUpdate ? "Update Note" : "Add Note",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: titleController,
            keyboardType: TextInputType.text,
            maxLines: 1,
            decoration: const InputDecoration(
              labelText: "Title *",
              hintText: "Enter Title",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            maxLines: 5,
            keyboardType: TextInputType.text,

            decoration: const InputDecoration(
              labelText: "Description *",
              hintText: "Enter Description",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () async {
                    var title = titleController.text;
                    var description = descriptionController.text;
                    if (title.isNotEmpty && description.isNotEmpty) {
                      bool check =
                          isUpdate
                              ? await dbRef!.updateNote(
                                mTitle: title,
                                mDescription: description,
                                sno: sno,
                              ) 
                              : await dbRef!.addNote(
                                mTitle: title,
                                mDescription: description,
                              ) ;
                      if (check) {
                        getNotes();
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("*Please fill all fields"),
                        ),
                      );
                    }
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(isUpdate ? "Update Note" : "Add Note"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () {
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
