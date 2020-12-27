import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:car_pair_links/ViewRoomCreateEnterToRoomPrivate.dart';
import 'package:car_pair_links/common/FirebaseWrapper.dart';

class RoomePrivate extends StatefulWidget {
  @override
  _RoomePrivate createState() => _RoomePrivate();
}

// Stateを継承して使う
class _RoomePrivate extends State<RoomePrivate> {
  // 状態変数定義
  bool menuVisible = false;

  @override
  Widget build(BuildContext context) {
    final ViewRoomCreateEnterToRoomPrivate viewRoomCreateEnterToRoomPrivate =
        ModalRoute.of(context).settings.arguments;

    var firebaseWrapper = new FirebaseWrapper();

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
                      Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(Icons.lock,
                              size: 25, color: Colors.lightGreen[100])),
                      Text(viewRoomCreateEnterToRoomPrivate.roomName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          )),
                    ])),
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
                      Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(Icons.lock,
                              size: 25, color: Colors.lightGreen[100])),
                      // Text(viewRoomCreateToRoomPrivate.roomName,
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 25.0,
                      //       fontWeight: FontWeight.bold,
                      //       fontStyle: FontStyle.normal,
                      //     )),
                      StreamBuilder<DocumentSnapshot>(
                        stream: Firestore.instance
                            .collection('rooms')
                            .document(viewRoomCreateEnterToRoomPrivate.roomName)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading");
                          }
                          var userDocument = snapshot.data;
                          print(userDocument["ルームタイプ"]);
                          return Container(
                              // padding: EdgeInsets.only(top: 100),
                              child: StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection('rooms')
                                .document(
                                    viewRoomCreateEnterToRoomPrivate.roomName)
                                .collection('users')
                                // .where("type", isEqualTo: "公開中")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }
                              var user = snapshot.data;
                              print('ユーザデータ');
                              print(user.documents.length);
                              print(user.documents);
                              return Column(
                                children: [
                                  Text(
                                    'ルーム種別::' + userDocument["ルームタイプ"],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  Text(
                                    'ルーム名:' + userDocument.documentID,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  Text(
                                    'パス:' + userDocument["ルームパスワード"],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  Text(
                                    'ユーザ数:' + user.documents.length.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                              // Text(
                              //   userDocument["type"],
                              //   style: TextStyle(
                              //     color: Colors.black,
                              //     fontWeight: FontWeight.bold,
                              //     fontStyle: FontStyle.normal,
                              //   ),
                              // ),
                              );
                        },
                      )
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
                                                          onPressed: () async {
                                                            print(viewRoomCreateEnterToRoomPrivate
                                                                .userDocumentId);
                                                            print("画面遷移データ：" +
                                                                viewRoomCreateEnterToRoomPrivate
                                                                    .roomName);
                                                            print("画面遷移データ：" +
                                                                viewRoomCreateEnterToRoomPrivate
                                                                    .roomPassword);
                                                            print("画面遷移データ：" +
                                                                viewRoomCreateEnterToRoomPrivate
                                                                    .userNickName);
                                                            print("画面遷移データ：" +
                                                                viewRoomCreateEnterToRoomPrivate
                                                                    .userIcon);

                                                            final snapshot =
                                                                await Firestore
                                                                    .instance
                                                                    .collection(
                                                                        'rooms')
                                                                    .document(
                                                                        'uuuuu')
                                                                    .collection(
                                                                        'users')
                                                                    .getDocuments();
                                                            // final snapshot =
                                                            //     await Firestore
                                                            //         .instance
                                                            //         .collection(
                                                            //             'rooms')
                                                            //         .getDocuments();
                                                            print(snapshot
                                                                .documents
                                                                .length);
                                                          },
                                                          icon: Icon(Icons.info,
                                                              size: 35,
                                                              color: Colors
                                                                  .white)))),
                                              Text(
                                                '情報',
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
                                                          onPressed: () async {
                                                            Map processRoomDelete =
                                                                await firebaseWrapper.roomUserDelete(
                                                                    viewRoomCreateEnterToRoomPrivate
                                                                        .roomDocumentId,
                                                                    viewRoomCreateEnterToRoomPrivate
                                                                        .userDocumentId);
                                                            if (processRoomDelete[
                                                                    'process'] ==
                                                                'Success')
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  '/roomHome');
                                                            else
                                                              print("ユーザ削除エラー");
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

    // final Stream<QuerySnapshot> stream = Firestore.instance.collection('posts');
    // CollectionReference users = Firestore.instance.collection('rooms');
    // return Scaffold(
    //     body: StreamBuilder<DocumentSnapshot>(
    //   stream: Firestore.instance
    //       .collection('rooms')
    //       .document("test")
    //       // .where("type", isEqualTo: "公開中")
    //       .snapshots(),
    //   builder:
    //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text('Something went wrong');
    //     }

    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Text("Loading");
    //     }
    //     var userDocument = snapshot.data;
    //     print(userDocument["type"]);
    //     return Container(
    //       padding: EdgeInsets.only(top: 100),
    //       child: Text(
    //         userDocument["type"],
    //         style: TextStyle(
    //           color: Colors.black,
    //           fontWeight: FontWeight.bold,
    //           fontStyle: FontStyle.normal,
    //         ),
    //       ),
    //     );
    //   },
    // ));
  }
}
