import 'package:flutter/material.dart';
import 'package:saskarnote/ui/widget/WidgetFunction.dart';
import 'package:saskarnote/ui/pages/Homepage.dart';
import 'package:intl/intl.dart';
import 'package:saskarnote/database/db_helper.dart';
import 'package:saskarnote/database/queries/note_query.dart';

class AddNote extends StatefulWidget {
  AddNote({Key key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController _judul = TextEditingController();
  TextEditingController _catatan = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime now = new DateTime.now();
  final DbHelper _helper = new DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SASKARNOTE"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: _judul,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Judul",
                  ),
                  validator: (value) {
                    return value.length < 10
                        ? 'Judul harus diatas 10 karakter'
                        : null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: _catatan,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 25,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Catatan",
                    hintStyle: TextStyle(fontSize: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Catatan tidak boleh kosong';
                    } else {
                      return value.length < 15
                          ? 'Catatan harus diatas 15 karakter'
                          : null;
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Row(
                  children: [
                    ButtonTheme(
                      minWidth: 120.0,
                      height: 40.0,
                      child: RaisedButton(
                        child: Text(
                          "Simpan",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            // inisialisasi tanggal
                            var formatter = new DateFormat('dd-MM-yyyy');
                            String formattedDate = formatter.format(now);

                            // simpan data ke database
                            _helper.insert(NoteQuery.TABLE_NAME, {
                              "judul": _judul.text,
                              "catatan": _catatan.text,
                              "pin": "no",
                              "tanggal": formattedDate
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Homepage(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Spacer(), // memberikan jarak
                    ButtonTheme(
                      minWidth: 120.0,
                      height: 40.0,
                      child: RaisedButton(
                        color: Colors.red,
                        child: Text(
                          "Kembali",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          // berikan konfirmasi untuk kembali
                          WidgetFunction().showDialogs(
                            context,
                            'Konfirmasi',
                            'Yakin ingin kembali ? Pastikan Anda belum menulis catatan',
                            () => Homepage(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
