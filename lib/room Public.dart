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
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Row(children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
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
                          alignment: Alignment.bottomCenter,
                          height: 100,
                          child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                                color: Colors.indigo[600],
                              ),
                              child: Container(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                            width: 70,
                                            child: Column(children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    color: Colors.blue[100],
                                                  ),
                                                  child: Center(
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(Icons.link,
                                                              size: 35,
                                                              color: Colors
                                                                  .white)))),
                                              Text(
                                                'ナビ連携',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ),
                                            ])),
                                        Container(
                                            width: 70,
                                            child: Column(children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    color: Colors.blue[100],
                                                  ),
                                                  child: Center(
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                              Icons.email,
                                                              size: 35,
                                                              color: Colors
                                                                  .white)))),
                                              Text(
                                                '招待',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ),
                                            ])),
                                        Container(
                                            width: 70,
                                            child: Column(children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    color: Colors.blue[100],
                                                  ),
                                                  child: Center(
                                                      child: IconButton(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/roomHome'); //routesで定義した名称を指定する
                                                          },
                                                          icon: Icon(
                                                              Icons.exit_to_app,
                                                              size: 35,
                                                              color: Colors
                                                                  .white)))),
                                              Text(
                                                'ルーム退出',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ),
                                            ])),
                                        Container(
                                            width: 70,
                                            child: Column(children: <Widget>[
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color: Colors.blue[100],
                                                ),
                                                child: Center(
                                                    child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            menuVisible =
                                                                !menuVisible;
                                                          });
                                                        },
                                                        icon: Icon(
                                                            Icons
                                                                .close_fullscreen,
                                                            size: 35,
                                                            color:
                                                                Colors.white))),
                                              ),
                                              Text(
                                                '閉じる',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ),
                                            ])),
                                      ],
                                    ),
                                  ])))
                          // ),
                          )
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
