import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

List<String> iconList = [
  "images/icon-01.png",
  "images/icon-02.png",
  "images/icon-03.png",
  "images/icon-04.png",
  "images/icon-05.png",
  "images/icon-06.png",
  "images/icon-07.png",
  "images/icon-08.png",
];

class RoomeCreate extends StatefulWidget {
  // 使用するStateを指定
  @override
  _RoomeCreate createState() => _RoomeCreate();
}

// Stateを継承して使う
class _RoomeCreate extends State<RoomeCreate> {
  // 状態変数定義
  bool roomType = true;
  String userIcon = "";
  Color colorPublic = Colors.yellow[700];
  Color colorPrivate = Colors.green[700];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        home: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: new AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/header.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: const Text(
                  "CAR PAIR LINKS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0,
                  ),
                ),
                backgroundColor: Colors.blue.withOpacity(0.3),
                elevation: 0.0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/roomHome'); //routesで定義した名称を指定する
                  },
                  icon: Icon(Icons.keyboard_arrow_left,
                      size: 45, color: Colors.white),
                ),
              ),
              body: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'ルームを作成',
                    style: TextStyle(
                      color: Colors.indigo[900],
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(children: <Widget>[
                            Container(
                                child: Center(
                                    child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.public,
                                  size: 30,
                                  color: roomType ? colorPublic : colorPrivate),
                            ))),
                            ToggleSwitch(
                              minWidth: 137.5,
                              initialLabelIndex: roomType ? 0 : 1,
                              cornerRadius: 20.0,
                              activeFgColor: Colors.black,
                              inactiveBgColor: Colors.grey,
                              inactiveFgColor: Colors.white,
                              labels: ['公開', '非公開'],
                              activeBgColors: [
                                Colors.yellow[700],
                                Colors.green[700]
                              ],
                              onToggle: (index) {
                                setState(() {
                                  roomType = !roomType;
                                });
                                print('switched to: $index');
                                print(roomType);
                              },
                            ),
                          ])),
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(children: <Widget>[
                            Container(
                                child: Center(
                                    child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.meeting_room,
                                  size: 30,
                                  color: roomType ? colorPublic : colorPrivate),
                            ))),
                            SizedBox(
                                width: 275,
                                height: 50,
                                child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "ルーム名",
                                        hintText: roomType ? "ルーム名" : "ルーム名称",
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(),
                                        )))),
                          ])),
                      if (!roomType)
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(children: <Widget>[
                              Container(
                                  child: Center(
                                      child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.https,
                                    size: 30, color: colorPrivate),
                              ))),
                              SizedBox(
                                  width: 275,
                                  height: 50,
                                  child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "共有パスワード",
                                          hintText: "共有パスワード",
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: BorderSide(),
                                          )))),
                            ])),
                    ])),
                Container(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(children: <Widget>[
                            Container(
                                child: Center(
                                    child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.face,
                                  size: 30,
                                  color: roomType ? colorPublic : colorPrivate),
                            ))),
                            SizedBox(
                                width: 275,
                                height: 50,
                                child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "ニックネーム",
                                        hintText: "ニックネーム",
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(),
                                        )))),
                          ])),
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(children: <Widget>[
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'アイコンを選択 ',
                                  ),
                                ],
                              ),
                            ),
                          ])),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: 100.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              for (var icon in iconList)
                                Container(
                                    width: 70,
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10.0),
                                    child: Column(children: <Widget>[
                                      Container(
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(icon),
                                          backgroundColor:
                                              Colors.transparent, // 背景色
                                        ),
                                      ),
                                      ButtonTheme(
                                        child: RaisedButton(
                                          child: userIcon == icon
                                              ? Text(
                                                  '選択中',
                                                  style: TextStyle(
                                                    fontSize: 12.5,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : Text(
                                                  '選択',
                                                  style: TextStyle(
                                                    fontSize: 12.5,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                          color: (() {
                                            if (userIcon != icon) {
                                              return Colors.white;
                                            } else if (roomType) {
                                              return colorPublic;
                                            } else {
                                              return colorPrivate;
                                            }
                                          })(),
                                          shape: Border(
                                            top: BorderSide(color: Colors.red),
                                            left:
                                                BorderSide(color: Colors.blue),
                                            right: BorderSide(
                                                color: Colors.yellow),
                                            bottom:
                                                BorderSide(color: Colors.green),
                                          ),
                                          onPressed: () {
                                            print(icon);
                                            setState(() {
                                              userIcon = icon;
                                            });
                                          },
                                        ),
                                      ),
                                    ])),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            width: double.infinity,
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: RaisedButton(
                                child: const Text(
                                  "作成",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {},
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
                    ])),
              ]),
            ),
          ],
        ));
  }
}
