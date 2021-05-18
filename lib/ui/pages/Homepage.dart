import 'package:flutter/material.dart';
import 'package:saskarnote/ui/widget/BuildDrawer.dart';
import 'package:saskarnote/ui/pages/note/Add.dart';
import 'package:saskarnote/database/db_helper.dart';
import 'package:saskarnote/database/queries/note_query.dart';
import 'package:saskarnote/ui/pages/note/Edit.dart';
import 'package:saskarnote/ui/widget/WidgetFunction.dart';
import 'package:saskarnote/ui/pages/note/Detail.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final DbHelper _helper = new DbHelper();
  final String _tableName = NoteQuery.TABLE_NAME;

  @override
  void initState() {
    super.initState();
  }

  // fungsi untuk menghapus
  void deleteNote(int id) {
    _helper.delete(_tableName, id);

    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Homepage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BuildDrawer(),
      appBar: AppBar(
        title: Text("SASKARNOTE"),
      ),
      body: Container(
        child: FutureBuilder(
          future: _helper.getAll(_tableName),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.length > 0
                  ? GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 2,
                      ),
                      itemBuilder: (context, index) {
                        void choiceAction(String choice) {
                          // choice action dropdown button icon
                          if (choice == Constants.EditItem) {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditNote(
                                  idNote: snapshot.data[index]['id'],
                                  judul: snapshot.data[index]['judul'],
                                  catatan: snapshot.data[index]['catatan'],
                                ),
                              ),
                            );
                          } else if (choice == Constants.DeleteItem) {
                            WidgetFunction().showDialogsFunction(
                              context,
                              'Konfirmasi',
                              'Yakin ingin hapus catatan ini ?',
                              () => deleteNote(snapshot.data[index]['id']),
                            );
                          }
                        }

                        return GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 2, left: 10),
                                      child: snapshot.data[index]['judul'] == ''
                                          ? Text(
                                              "Tanpa Judul",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            )
                                          : Text(
                                              snapshot.data[index]['judul']
                                                      .substring(0, 10) +
                                                  "...",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                    Spacer(),
                                    Material(
                                      color: Colors.white,
                                      child: PopupMenuButton<String>(
                                        icon: Icon(Icons.more_vert),
                                        onSelected: choiceAction,
                                        itemBuilder: (BuildContext context) {
                                          return Constants.choices
                                              .map((String choice) {
                                            return PopupMenuItem<String>(
                                              value: choice,
                                              child: Text(choice),
                                            );
                                          }).toList();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: RichText(
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      text: snapshot.data[index]['catatan']
                                              .substring(0, 15) +
                                          "...",
                                    ),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return DetailPage(
                                    judul: snapshot.data[index]['judul'],
                                    catatan: snapshot.data[index]['catatan'],
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "Anda belum punya catatan",
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    );
            } else if (snapshot.hasError) {
              return Text("Error");
            }

            return Container(
              child: Text("Loading..."),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class Constants {
  static const String EditItem = 'Edit';
  static const String DeleteItem = 'Delete';

  static const List<String> choices = <String>[
    EditItem,
    DeleteItem,
  ];
}
