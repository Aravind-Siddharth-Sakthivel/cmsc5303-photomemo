import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreController {
  static FirebaseFirestore firestor = FirebaseFirestore.instance;

  static CollectionReference myMemos = firestor.collection('mymemos');

  static Stream<QuerySnapshot> snapshot = myMemos.snapshots();

  static Future<void> addMemo(String uid, String title, String memo,
      List<dynamic> sharedwith, String imgname, String imgurl) async {
    return await myMemos
        .add({
          'createdBy': uid,
          'title': title,
          'Memo': memo,
          'sharedwith': sharedwith,
          'imgurl': imgurl,
          'imgname': imgname
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<void> delete(docId) async {
    await FirebaseFirestore.instance.collection('mymemos').doc(docId).delete();
  }

  //  Future<void> update(docId) async {
  //   await FirebaseFirestore.instance.collection('mymemos').doc(docId).update(this.toMap());
  // }

  // static getMemo() async {
  //   List<PhotoMemo> memosList = [];

  //   try {
  //     await firestor
  //         .collection('mymemos')
  //         .get()
  //         .then((QuerySnapshot querySnapshot) {
  //       querySnapshot.docs.forEach((QueryDocumentSnapshot doc) {
  //         PhotoMemo tempMemo = PhotoMemo();
  //         tempMemo.title = doc.data()['title'];
  //         tempMemo.docID = doc.id;
  //         tempMemo.photoFilename = doc.data()['imgname'];
  //         tempMemo.photoURL = doc.data()['imgurl'];
  //         tempMemo.memo = doc.data()['Memo'];
  //         tempMemo.createdBy = doc.data()['createdBy'];
  //         print(tempMemo.photoURL);
  //         memosList.add(tempMemo);
  //       });
  //     });

  //     return memosList;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
}
