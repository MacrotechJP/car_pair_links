import 'package:car_pair_links/src/ViewRoomCreateEnterToRoomMain.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_pair_links/common/FirebaseWrapper.dart';
import 'package:car_pair_links/src/boom_menu.dart';
import 'package:car_pair_links/src/boom_menu_item.dart';
import 'package:commons/commons.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:geolocator/geolocator.dart';

class RoomeMain extends StatefulWidget {
  @override
  _RoomeMain createState() => _RoomeMain();
}

// Stateを継承して使う
class _RoomeMain extends State<RoomeMain> {
  // 状態変数定義
  bool menuVisible = false;
  bool autoTracking = true;
  String roomType;
  String roomName;
  String roomPassword;
  String roomUserNickname;
  String roomUserIcon;
  double roomUserPlaceLat;
  double roomUserPlaceLng;
  List<Symbol> roomUserplaceSymbols = [];
  // インスタンス変数初期化
  var firebaseWrapper = new FirebaseWrapper();
  // Mapbox初期化
  MapboxMapController controller;
  void _onMapCreated(MapboxMapController controller) {
    this.controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    // 画面遷移時パラメーター引き継ぎ
    final ViewRoomCreateEnterToRoomMain viewRoomCreateEnterToRoomMain =
        ModalRoute.of(context).settings.arguments;
    // 位置情報取得時処理
    Geolocator.getPositionStream().listen((event) async {
      if (controller != null) {
        if (roomUserPlaceLat != event.latitude ||
            roomUserPlaceLng != event.longitude) {
          print("位置情報変更有り");
          // 位置情報更新処理
          Map processRoomUserUpdate = await firebaseWrapper.roomUserUpdate(
              viewRoomCreateEnterToRoomMain.roomDocumentId,
              viewRoomCreateEnterToRoomMain.roomUserDocumentId,
              Map<String, dynamic>.from(
                  {"位置情報（緯度）": event.latitude, "位置情報（経度）": event.longitude}));
          if (processRoomUserUpdate['process'] == 'Error') print("位置情報更新エラー");
          // 状態変数更新
          setState(() {
            roomUserPlaceLat = event.latitude;
            roomUserPlaceLng = event.longitude;
          });
        }
        // 自動追跡処理
        if (autoTracking) {
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(event.latitude, event.longitude),
                tilt: 30.0,
                zoom: 19.0,
              ),
            ),
          );
        }
      }
    });

    return new MaterialApp(
        title: 'ルームメイン画面',
        home: Stack(
          children: <Widget>[
            Scaffold(
              body: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: MapboxMap(
                      accessToken:
                          "pk.eyJ1IjoidGFuYWtha295byIsImEiOiJja2dyemduNWkwNmdnMnFwYnVrcHAzN25xIn0.XFJvnmTjjxhZBmDgRtnOSQ",
                      styleString:
                          "mapbox://styles/tanakakoyo/ckjbe3m4u7ey41al7f4rdf1ld",
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(34.6901217, 135.5156424),
                        zoom: 15.0,
                      ),
                      compassEnabled: true,
                      zoomGesturesEnabled: true,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(30),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: (roomUserPlaceLat == null ||
                              roomUserPlaceLng == null)
                          ? Container(
                              child: Text("読み込み中"),
                            )
                          : StreamBuilder<DocumentSnapshot>(
                              stream: Firestore.instance
                                  .collection('rooms')
                                  .document(viewRoomCreateEnterToRoomMain
                                      .roomDocumentId)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                var roomData = snapshot.data;
                                return Container(
                                    child: StreamBuilder<QuerySnapshot>(
                                  stream: Firestore.instance
                                      .collection('rooms')
                                      .document(viewRoomCreateEnterToRoomMain
                                          .roomDocumentId)
                                      .collection('users')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    var roomUserData = snapshot.data;
                                    if (controller != null &&
                                        roomData != null &&
                                        roomUserData != null) {
                                      // 既存Symbolの全削除
                                      print("全削除");
                                      if (roomUserplaceSymbols.length != 0) {
                                        controller.removeSymbols(
                                            roomUserplaceSymbols);
                                        roomUserplaceSymbols = [];
                                      }
                                      // 新規Symbolの作成
                                      print("全作成");
                                      for (int i = 0;
                                          i < roomUserData.documents.length;
                                          i++) {
                                        controller
                                            .addSymbol(SymbolOptions(
                                          geometry: LatLng(
                                              roomUserData.documents[i]
                                                  ["位置情報（緯度）"],
                                              roomUserData.documents[i]
                                                  ["位置情報（経度）"]),
                                          iconSize: 1,
                                          iconImage: roomUserData.documents[i]
                                              ["ユーザアイコン"],
                                          textField: roomUserData.documents[i]
                                              ["ユーザニックネーム"],
                                          textOffset: Offset(0, 2),
                                        ))
                                            .then((value) {
                                          roomUserplaceSymbols.add(value);
                                        });
                                      }
                                    }
                                    return (roomData == null ||
                                            roomUserData == null)
                                        ? Container()
                                        : Row(children: <Widget>[
                                            Container(
                                                padding: EdgeInsets.all(5),
                                                margin: EdgeInsets.only(
                                                    right: 10, left: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color: Colors.white,
                                                ),
                                                child: Icon(Icons.meeting_room,
                                                    size: 35,
                                                    color: Colors.blue)),
                                            if (roomData["ルームタイプ"] == "非公開")
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(right: 5),
                                                  child: Icon(Icons.lock,
                                                      size: 25,
                                                      color: Colors
                                                          .lightGreen[100])),
                                            Text(roomData.documentID,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                )),
                                          ]);
                                  },
                                ));
                              },
                            )),
                  Container(
                    padding: EdgeInsets.only(bottom: 25),
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // RaisedButton(
                        //   padding: EdgeInsets.all(10),
                        //   child: Icon(
                        //     Icons.plus_one,
                        //     size: 30,
                        //     color: Colors.white,
                        //   ),
                        //   color: Colors.lightBlue[300],
                        //   shape: CircleBorder(
                        //     side: BorderSide(
                        //       color: Colors.white,
                        //       width: 1,
                        //       style: BorderStyle.solid,
                        //     ),
                        //   ),
                        //   onPressed: () async {
                        //     var nowTime = DateTime.now();
                        //     Map processRoomUserCreate =
                        //         await firebaseWrapper.roomUserCreate(
                        //             viewRoomCreateEnterToRoomMain
                        //                 .roomDocumentId,
                        //             "モックさん",
                        //             "images/icon-03.png",
                        //             nowTime);
                        //     if (processRoomUserCreate['process'] == 'Success')
                        //       print("作成完了");
                        //     else
                        //       print('作成エラー');
                        //   },
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        RaisedButton(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.location_on,
                            size: 30,
                            color: Colors.white,
                          ),
                          color: Colors.lightBlue[300],
                          shape: CircleBorder(
                            side: BorderSide(
                              color: Colors.white,
                              width: (autoTracking) ? 3 : 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              autoTracking = !autoTracking;
                            });
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.zoom_in,
                            size: 30,
                            color: Colors.white,
                          ),
                          color: Colors.lightBlue[300],
                          shape: const CircleBorder(
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          onPressed: () {
                            controller.animateCamera(CameraUpdate.zoomIn());
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.zoom_out,
                            size: 30,
                            color: Colors.white,
                          ),
                          color: Colors.lightBlue[300],
                          shape: const CircleBorder(
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          onPressed: () {
                            controller.animateCamera(CameraUpdate.zoomOut());
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              floatingActionButton: BoomMenu(
                  animatedIcon: AnimatedIcons.menu_close,
                  animatedIconTheme: IconThemeData(size: 22.0),
                  onOpen: () => print('メニュー オープン'),
                  onClose: () => print('メニュー クローズ'),
                  scrollVisible: true,
                  overlayColor: Colors.black,
                  overlayOpacity: 0.7,
                  children: [
                    MenuItem(
                      child: Icon(Icons.electric_car, color: Colors.white),
                      title: "SDLアプリ連携",
                      titleColor: Colors.white,
                      subtitle: "Smart Device Linkと連携します。",
                      subTitleColor: Colors.white,
                      backgroundColor: Colors.pink[400],
                      onTap: () {
                        infoDialog(context, "Coming soon...");
                      },
                    ),
                    MenuItem(
                      child: Icon(Icons.send, color: Colors.white),
                      title: "ユーザー招待",
                      titleColor: Colors.white,
                      subtitle: "ルームへの招待リンクを送信します。",
                      subTitleColor: Colors.white,
                      backgroundColor: Colors.blue[200],
                      onTap: () {
                        infoDialog(context, "Coming soon...");
                      },
                    ),
                    MenuItem(
                      child: Icon(Icons.info, color: Colors.white),
                      title: "ルーム情報",
                      titleColor: Colors.white,
                      subtitle: "ルーム内の情報を表示します。",
                      subTitleColor: Colors.white,
                      backgroundColor: Colors.pink[300],
                      onTap: () {
                        infoDialog(context, "Coming soon...");
                        // showDialog(
                        //   context: context,
                        //   builder: (context) {
                        //     return SimpleDialog(
                        //       title: Text('ルーム情報'),
                        //       children: <Widget>[
                        //         SimpleDialogOption(
                        //             child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text('ルームタイプ'),
                        //             Text('ルームタイプ'),
                        //           ],
                        //         )),
                        //         SimpleDialogOption(
                        //             child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text('ルーム名'),
                        //             Text('ルーム名'),
                        //           ],
                        //         )),
                        //         SimpleDialogOption(
                        //             child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text('パスワード'),
                        //             Text('パスワード'),
                        //           ],
                        //         )),
                        //         SimpleDialogOption(
                        //             child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text('ルーム内ユーザ数'),
                        //             Text('ルーム内ユーザ数'),
                        //           ],
                        //         )),
                        //       ],
                        //     );
                        //   },
                        // );
                      },
                    ),
                    MenuItem(
                      child: Icon(Icons.settings, color: Colors.white),
                      title: "各種設定",
                      titleColor: Colors.white,
                      subtitle: "ルーム内の各種設定が出来ます。",
                      subTitleColor: Colors.white,
                      backgroundColor: Colors.blue[300],
                      onTap: () {
                        infoDialog(context, "Coming soon...");
                      },
                    ),
                    MenuItem(
                      child: Icon(Icons.exit_to_app, color: Colors.white),
                      title: "ルーム退出",
                      titleColor: Colors.white,
                      subtitle: "ユーザ情報を削除して退出します。",
                      subTitleColor: Colors.white,
                      backgroundColor: Colors.pink[200],
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

                        if (processRoomGetCount["data"] == 1) {
                          // ルーム情報更新処理
                          Map processRoomUpdate =
                              await firebaseWrapper.roomUpdate(
                                  viewRoomCreateEnterToRoomMain.roomDocumentId,
                                  Map<String, dynamic>.from(
                                      {"ルームタイプ": "削除予定"}));
                          if (processRoomUpdate['process'] == 'Success')
                            Navigator.pushNamed(context, '/roomHome');
                          else
                            print("ルーム削除エラー");
                        } else {
                          // ルーム内ユーザ削除処理
                          Map processRoomUserDelete =
                              await firebaseWrapper.roomUserDelete(
                                  viewRoomCreateEnterToRoomMain.roomDocumentId,
                                  viewRoomCreateEnterToRoomMain
                                      .roomUserDocumentId);
                          if (processRoomUserDelete['process'] == 'Success')
                            Navigator.pushNamed(context, '/roomHome');
                          else
                            print("ユーザ削除エラー");
                        }
                      },
                    )
                  ]),
            ),
          ],
        ));
  }
}
