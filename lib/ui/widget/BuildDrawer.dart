import 'package:flutter/material.dart';
import 'package:saskarnote/ui/pages/Homepage.dart';
import 'package:saskarnote/ui/pages/About.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Colors.blue,
              child: Image.asset(
                "assets/images/saskarnote.png",
                height: 200,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.note,
                color: Colors.blue,
              ),
              title: Text("Catatan"),
              onTap: () {
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
            Divider(
              height: 2.0,
            ),
            ListTile(
              leading: Icon(
                Icons.announcement,
                color: Colors.blue,
              ),
              title: Text("About"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return AboutPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
