import 'package:flutter/material.dart';
import 'package:saskarnote/database/db_helper.dart';
import 'package:saskarnote/database/queries/note_query.dart';
import 'package:saskarnote/ui/pages/Homepage.dart';
import 'package:saskarnote/ui/widget/WidgetFunction.dart';

class EditNote extends StatefulWidget {
  final int idNote;
  final String judul;
  final String catatan;

  EditNote({Key key, this.idNote, this.judul, this.catatan}) : super(key: key);

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController _judul = TextEditingController();
  TextEditingController _catatan = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final DbHelper _helper = new DbHelper();
  final String _tableName = NoteQuery.TABLE_NAME;

  void initState() {
    super.initState();

    if (widget.idNote != null) {
      _judul.value = TextEditingValue(
        text: widget.judul,
        selection: TextSelection.collapsed(offset: widget.judul.length),
      );
      _catatan.value = TextEditingValue(
        text: widget.catatan,
        selection: TextSelection.collapsed(offset: widget.catatan.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Catatan"),
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
                            // simpan data ke database
                            _helper.update(_tableName, widget.idNote, {
                              "judul": _judul.text,
                              "catatan": _catatan.text,
                              "pin": "no",
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
                            'Yakin ingin kembali ? Pastikan Anda melakukan perubahan pada catatan',
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
