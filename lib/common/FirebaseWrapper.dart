import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseWrapper {
  /* ルームの作成 */
  Future<Map> roomCreate(bool roomType, String roomName, String roomPassword,
      DateTime nowTime) async {
    var resultCreated = Map();
    try {
      DocumentReference documentReference =
          Firestore.instance.collection('rooms').document(roomName);
      await documentReference.setData({
        'ルームタイプ': (roomType) ? "公開中" : "非公開",
        'ルームパスワード': roomPassword,
        '作成時間': nowTime,
        '更新時間': nowTime
      });
      resultCreated['process'] = 'Success';
      resultCreated['data'] = {
        'documentID': documentReference.documentID,
        'roomType': (roomType) ? "公開中" : "非公開",
        'roomName': roomName,
        'roomPassword': roomPassword
      };
    } catch (error) {
      resultCreated['process'] = 'Error';
    }
    return resultCreated;
  }

  /* ルームの更新 */
  void roomUpdate() {}

  /* ルームの削除 */
  void roomDelete() {}

  /* ルームユーザの作成 */
  Future<Map> roomUserCreate(String roomDocumentId, String userNickname,
      String userIcon, DateTime nowTime) async {
    var resultCreated = Map();

    try {
      DocumentReference documentReference = Firestore.instance
          .collection('rooms')
          .document(roomDocumentId)
          .collection('users')
          .document();
      await documentReference.setData({
        'ユーザニックネーム': userNickname,
        'ユーザアイコン': userIcon,
        '作成時間': nowTime,
        '更新時間': nowTime
      });
      resultCreated['process'] = 'Success';
      resultCreated['data'] = {
        'documentID': documentReference.documentID,
        'userNickname': userNickname,
        'userIcon': userIcon
      };
    } catch (error) {
      resultCreated['process'] = 'Error';
    }
    return resultCreated;
  }

  /* ルームユーザの更新 */
  void roomUserUpdate() {}

  /* ルームユーザの削除 */
  Future<Map> roomUserDelete(
      String roomDocumentId, String userDocumentId) async {
    var resultDeleted = Map();

    try {
      await Firestore.instance
          .collection('rooms')
          .document(roomDocumentId)
          .collection('users')
          .document(userDocumentId)
          .delete();
      resultDeleted['process'] = 'Success';
    } catch (error) {
      resultDeleted['process'] = 'Error';
    }
    return resultDeleted;
  }
}
