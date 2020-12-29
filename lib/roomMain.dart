import 'package:car_pair_links/src/ViewRoomCreateEnterToRoomMain.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_pair_links/common/FirebaseWrapper.dart';
import 'package:car_pair_links/src/boom_menu.dart';
import 'package:car_pair_links/src/boom_menu_item.dart';
import 'package:commons/commons.dart';

class RoomeMain extends StatefulWidget {
  @override
  _RoomeMain createState() => _RoomeMain();
}

// Stateを継承して使う
class _RoomeMain extends State<RoomeMain> {
  // 状態変数定義
  bool menuVisible = false;
  String roomType;
  String roomName;
  String roomPassword;
  String roomUserNickname;
  String roomUserIcon;
  // インスタンス変数初期化
  var firebaseWrapper = new FirebaseWrapper();

  @override
  Widget build(BuildContext context) {
    // 画面遷移時パラメーター引き継ぎ
    final ViewRoomCreateEnterToRoomMain viewRoomCreateEnterToRoomMain =
        ModalRoute.of(context).settings.arguments;
    bool scrollVisible = true;

    return new MaterialApp(
        title: 'ルームメイン画面',
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
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: Firestore.instance
                          .collection('rooms')
                          .document(
                              viewRoomCreateEnterToRoomMain.roomDocumentId)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        var roomData = snapshot.data;
                        return Container(
                            child: StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('rooms')
                              .document(
                                  viewRoomCreateEnterToRoomMain.roomDocumentId)
                              .collection('users')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            // var roomUserData = snapshot.data;
                            return Row(children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(right: 10, left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white,
                                  ),
                                  child: Icon(Icons.meeting_room,
                                      size: 35, color: Colors.blue)),
                              if (roomData["ルームタイプ"] == "非公開")
                                Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Icon(Icons.lock,
                                        size: 25,
                                        color: Colors.lightGreen[100])),
                              Text(roomData.documentID,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ]);
                          },
                        ));
                      },
                    )),
                // ここから下は削除予定
                Container(
                    margin: EdgeInsets.all(30),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: Firestore.instance
                          .collection('rooms')
                          .document(
                              viewRoomCreateEnterToRoomMain.roomDocumentId)
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
                        print(viewRoomCreateEnterToRoomMain.roomDocumentId);
                        // print("ルームタイプ" + roomType);
                        roomType = userDocument["ルームタイプ"];
                        return Container(
                            // padding: EdgeInsets.only(top: 100),
                            child: StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('rooms')
                              .document(
                                  viewRoomCreateEnterToRoomMain.roomDocumentId)
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
                            return Row(children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(right: 10, left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white,
                                  ),
                                  child: Icon(Icons.meeting_room,
                                      size: 35, color: Colors.blue)),
                              if (userDocument["ルームタイプ"] == "非公開")
                                Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Icon(Icons.lock,
                                        size: 25,
                                        color: Colors.lightGreen[100])),
                              Column(
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
                              ),
                            ]);
                          },
                        ));
                      },
                    )),
              ]),
              floatingActionButton: BoomMenu(
                  animatedIcon: AnimatedIcons.menu_close,
                  animatedIconTheme: IconThemeData(size: 22.0),
                  onOpen: () => print('メニュー オープン'),
                  onClose: () => print('メニュー クローズ'),
                  scrollVisible: scrollVisible,
                  overlayColor: Colors.black,
                  overlayOpacity: 0.7,
                  children: [
                    MenuItem(
                      child: Icon(Icons.electric_car, color: Colors.white),
                      title: "SDLアプリ連携",
                      titleColor: Colors.white,
                      subtitle: "Smart Device Linkと連携します。",
                      subTitleColor: Colors.white,
                      backgroundColor: Colors.pinkAccent,
                      onTap: () => print('SDLアプリ連携を押下'),
                    ),
                    MenuItem(
                      child: Icon(Icons.send, color: Colors.white),
                      title: "ユーザー招待",
                      titleColor: Colors.white,
                      subtitle: "ルームへの招待リンクを送信します。",
                      subTitleColor: Colors.white,
                      backgroundColor: Colors.blue[300],
                      onTap: () => print('ユーザー招待を押下'),
                    ),
                    MenuItem(
                      child: Icon(Icons.info, color: Colors.white),
                      title: "ルーム情報",
                      titleColor: Colors.white,
                      subtitle: "ルーム内の情報を表示します。",
                      subTitleColor: Colors.white,
                      backgroundColor: Colors.pinkAccent[100],
                      onTap: () => print('ルーム情報を押下'),
                    ),
                    MenuItem(
                      child: Icon(Icons.exit_to_app, color: Colors.white),
                      title: "ルーム退出",
                      titleColor: Colors.white,
                      subtitle: "ユーザ情報を削除して退出します。",
                      subTitleColor: Colors.white,
                      backgroundColor: Colors.blue,
                      onTap: () async {
                        // ルーム内ユーザ数取得処理
                        Map processRoomGetCount =
                            await firebaseWrapper.roomUserGetCount(
                          viewRoomCreateEnterToRoomMain.roomDocumentId,
                        );
                        if (processRoomGetCount['process'] == 'Success' &&
                            processRoomGetCount["data"] == 1) {
                          bool confirmContinue = false;
                          await confirmationDialog(
                              context, "ルーム内にユーザが存在しなくなる為、ルームが削除されますがよろしいですか？",
                              positiveText: "ルーム退出",
                              confirmationText: "確認", positiveAction: () {
                            confirmContinue = true;
                          });
                          if (confirmContinue == false) return false;
                        }
                        // ルーム内ユーザ削除処理
                        Map processRoomUserDelete =
                            await firebaseWrapper.roomUserDelete(
                                viewRoomCreateEnterToRoomMain.roomDocumentId,
                                viewRoomCreateEnterToRoomMain
                                    .roomUserDocumentId);
                        if (processRoomUserDelete['process'] == 'Success') {
                          if (processRoomGetCount["data"] == 1) {
                            // ルーム情報更新処理
                            Map processRoomUpdate =
                                await firebaseWrapper.roomUpdate(
                                    viewRoomCreateEnterToRoomMain
                                        .roomDocumentId,
                                    Map<String, dynamic>.from(
                                        {"ルームタイプ": "削除予定"}));
                            if (processRoomUpdate['process'] == 'Success')
                              Navigator.pushNamed(context, '/roomHome');
                          }
                          Navigator.pushNamed(context, '/roomHome');
                        } else {
                          print("ルーム削除 or ユーザ削除エラー");
                        }
                      },
                    )
                  ]),
            ),
          ],
        ));
  }
}
