import "package:flutter/material.dart";
import 'package:photomemo/controller/firebase_firestore_controller.dart';
import 'package:photomemo/screens/memo_details.dart';

class MemoItem extends StatelessWidget {
  MemoItem({@required this.width, @required this.memoItem});

  final double width;
  final Map<String, dynamic> memoItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MemoDetails.routeName,
            arguments: {"memoItem": memoItem});
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Row(
              children: [
                memoItem['imgurl'].isNotEmpty
                    ? Image.network(
                        memoItem['imgurl'],
                        width: width * 0.3,
                      )
                    : SizedBox(width: width * 0.3),
                SizedBox(width: width * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      memoItem['title'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: width * 0.5,
                      child: Text(memoItem['Memo']),
                    ),
                    GestureDetector(
                      onTap: () {
                        FirebaseFirestoreController.delete(memoItem['id']);
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(color: Colors.white),
        ],
      ),
    );
  }
}
