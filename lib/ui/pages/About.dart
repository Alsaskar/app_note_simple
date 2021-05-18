import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ABOUT"),
      ),
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Column(
            children: [
              Image.asset(
                "assets/images/saskarnote.png",
                height: 300,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  "Saskarnote adalah aplikasi pencatatan, aplikasi ini berguna untuk Anda yang akan mencatat sesuatu. Aplikasi ini juga merupakan produk dari Saskartech",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  "Versi : 1.0.0",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
