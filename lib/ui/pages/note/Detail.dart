import 'package:flutter/material.dart';
import 'package:saskarnote/ui/pages/Homepage.dart';

class DetailPage extends StatefulWidget {
  final String judul, catatan;
  DetailPage({Key key, this.judul, this.catatan}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Catatan"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Homepage();
                },
              ),
            );
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  widget.judul,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: 20),
                child: Text(widget.catatan),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
