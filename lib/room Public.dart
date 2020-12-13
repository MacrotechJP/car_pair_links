import 'package:flutter/material.dart';

class RoomePublic extends StatefulWidget {
  // 使用するStateを指定
  @override
  _RoomePublic createState() => _RoomePublic();
}

// Stateを継承して使う
class _RoomePublic extends State<RoomePublic> {
  // 状態変数定義
  bool menuVisible = false;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        home: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("images/sample.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(children: <Widget>[
                Container(
                    margin: EdgeInsets.all(30),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Row(children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          child: Icon(Icons.meeting_room,
                              size: 35, color: Colors.blue)),
                      Text(
                        '紀伊半島へ行こう',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ])),
                Expanded(
                  child: menuVisible
                      ? Container(
                          width: double.infinity,
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: RaisedButton(
                              child: Icon(Icons.keyboard_arrow_up,
                                  size: 40, color: Colors.white),
                              onPressed: () {
                                print(11);
                                setState(() {
                                  menuVisible = !menuVisible;
                                });
                              },
                              elevation: 16,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                              ),
                              color: Colors.indigo[600],
                              textColor: Colors.white,
                            ),
                          ))
                      : Container(
                          width: double.infinity,
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: double.infinity,
                            height: 35,
                            child: RaisedButton(
                              child: Icon(Icons.keyboard_arrow_up,
                                  size: 40, color: Colors.white),
                              onPressed: () {
                                print(11);
                                setState(() {
                                  menuVisible = !menuVisible;
                                });
                              },
                              elevation: 16,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                              ),
                              color: Colors.indigo[600],
                              textColor: Colors.white,
                            ),
                          )),
                )
              ]),
            ),
          ],
        ));
  }
}
