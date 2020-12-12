import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class RoomeCreate extends StatelessWidget {
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
            Container(
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
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(60.0),
                  child: AppBar(
                    centerTitle: true,
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/header.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Center(
                              child: Text(
                                "Car Pair Links",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            )
                          ]),
                    ),
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/roomHome'); //routesで定義した名称を指定する
                      },
                      icon: Icon(Icons.keyboard_arrow_left,
                          size: 45, color: Colors.white),
                    ),
                  )),
              body: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
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
                                  size: 30, color: Colors.yellow[700]),
                            ))),
                            ToggleSwitch(
                              minWidth: 137.5,
                              initialLabelIndex: 0,
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
                                print('switched to: $index');
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
                                  size: 30, color: Colors.yellow[700]),
                            ))),
                            SizedBox(
                                width: 275,
                                height: 50,
                                child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "ルーム名",
                                        hintText: "ルーム名",
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
                            Container(
                                child: Center(
                                    child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.https,
                                  size: 30, color: Colors.yellow[700]),
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
                                  size: 30, color: Colors.yellow[700]),
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
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.face,
                                  size: 25, color: Colors.yellow[700]),
                            ),
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
                    ])),
              ]),
            ),
          ],
        ));
  }
}
