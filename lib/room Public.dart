import 'package:flutter/material.dart';

class RoomePublic extends StatelessWidget {
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
                  image: new AssetImage("images/sample.gif"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 80, bottom: 40),
                  child: Text(
                    '公開ルーム',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 300.0,
                        height: 60.0,
                        child: RaisedButton.icon(
                          icon: const Icon(
                            Icons.cloud_queue,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "ルームを作る",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/roomCreate'); //routesで定義した名称を指定する
                          },
                          elevation: 16,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: Colors.lightBlue[400],
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 300.0,
                        height: 60.0,
                        child: RaisedButton.icon(
                          icon: const Icon(
                            Icons.cloud_queue,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "ルームへ参加",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {},
                          elevation: 16,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: Colors.lightBlue[400],
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RichText(
                      // textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: '< ルームとは >\n',
                            style: TextStyle(
                              color: Colors.yellow[500],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '・位置情報を共有する為の、共通の部屋です。\n',
                          ),
                          TextSpan(
                            text: '・ルームは誰でも作る事が出来ます。',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ));
  }
}
