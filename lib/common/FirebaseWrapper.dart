import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseWrapper {
  /* ルームリストの取得 */
  Future<Map> roomGetList() async {
    var resultGeted = Map();
    try {
      QuerySnapshot roomData =
          await Firestore.instance.collection('rooms').getDocuments();
      resultGeted['process'] = 'Success';
      resultGeted['data'] = roomData.documents;
    } catch (error) {
      resultGeted['process'] = 'Error';
    }
    return resultGeted;
  }

  /* ルーム詳細の取得 */
  Future<Map> roomGetDetail(String roomDocumentId) async {
    var resultGeted = Map();
    try {
      final roomData = await Firestore.instance
          .collection('rooms')
          .document(roomDocumentId)
          .get();
      resultGeted['process'] = 'Success';
      resultGeted['data'] = roomData.data;
    } catch (error) {
      resultGeted['process'] = 'Error';
    }
    return resultGeted;
  }

  /* ルーム存在チェック */
  Future<Map> roomCheckExist(String roomDocumentId) async {
    var resultChecked = Map();
    try {
      final documentRoom = await Firestore.instance
          .collection('rooms')
          .document(roomDocumentId)
          .get();
      if (documentRoom == null || !documentRoom.exists) {
        // ルーム存在無し
        print("存在なし");
        resultChecked['isRoomExist'] = false;
      } else {
        // ルーム存在有り
        print("存在あり");
        resultChecked['isRoomExist'] = true;
      }
      resultChecked['process'] = 'Success';
    } catch (error) {
      resultChecked['process'] = 'Error';
    }
    return resultChecked;
  }

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
  Future<Map> roomUpdate(String roomDocumentId, Map roomUpdateData) async {
    var resultUpdated = Map();
    try {
      await Firestore.instance
          .collection('rooms')
          .document(roomDocumentId)
          .updateData(roomUpdateData);
      resultUpdated['process'] = 'Success';
    } catch (error) {
      resultUpdated['process'] = 'Error';
    }
    return resultUpdated;
  }

  /* ルームの削除 */
  Future<Map> roomDelete(String roomDocumentId) async {
    var resultDeleted = Map();
    try {
      await Firestore.instance
          .collection('rooms')
          .document(roomDocumentId)
          .delete();
      resultDeleted['process'] = 'Success';
    } catch (error) {
      resultDeleted['process'] = 'Error';
    }
    return resultDeleted;
  }

  /* ルーム内ユーザ数の取得 */
  Future<Map> roomUserGetCount(String roomDocumentId) async {
    var resultGeted = Map();
    try {
      QuerySnapshot roomData = await Firestore.instance
          .collection('rooms')
          .document(roomDocumentId)
          .collection("users")
          .getDocuments();
      resultGeted['process'] = 'Success';
      resultGeted['data'] = roomData.documents.length;
    } catch (error) {
      resultGeted['process'] = 'Error';
    }
    return resultGeted;
  }

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
        '位置情報（緯度）': 35.3392588,
        '位置情報（経度）': 134.1966518,
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
  Future<Map> roomUserUpdate(String roomDocumentId, String roomUserDocumentId,
      Map roomUserUpdateData) async {
    var resultUpdated = Map();
    try {
      await Firestore.instance
          .collection('rooms')
          .document(roomDocumentId)
          .collection('users')
          .document(roomUserDocumentId)
          .updateData(roomUserUpdateData);
      resultUpdated['process'] = 'Success';
    } catch (error) {
      resultUpdated['process'] = 'Error';
    }
    return resultUpdated;
  }

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
