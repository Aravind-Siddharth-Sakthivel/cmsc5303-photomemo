import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photomemo/controller/firebase_auth_controller.dart';
import 'package:photomemo/controller/firebase_firestore_controller.dart';
import 'package:photomemo/models/constant.dart';
import 'package:photomemo/models/photomemo.dart';
import 'package:photomemo/screens/myview/mydialog.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'add_photo.dart';
import 'myview/memo_item.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = '/userHomeScreen';
  @override
  State<StatefulWidget> createState() {
    return _UserHomeState();
  }
}

class _UserHomeState extends State<UserHomeScreen> {
  _Controller con;
  User user;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Map args = ModalRoute.of(context).settings.arguments;
    user ??= args[Constant.ARG_USER];
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: Text('User Home'),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(user.displayName ?? 'N/A'),
                accountEmail: Text(user.email),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign Out'),
                onTap: con.signOut,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: con.addButton,
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {},
                    child: Text(
                      'My memos',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {},
                    child: Text(
                      'Shared with me',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(
              height: 500,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestoreController.snapshot,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      List memos = snapshot.data.docs;
                      //TODO : where is the uid ?
                      // memos.removeWhere((memo) =>
                      //     memo.data()['createdBy'].compareTo(user.uid) != 0);
                      return ListView.builder(
                        itemCount: memos.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot memo = memos[index];
                          PhotoMemo photomemo = PhotoMemo(memo.id, memo.data());
                          return Slidable(
                            child: MemoItem(
                              width: width,
                              memoItem: photomemo,
                            ),
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                caption: 'Delete',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () =>
                                    FirebaseFirestoreController.delete(memo.id),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      return Text('loading');
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class _Controller {
  _UserHomeState state;
  _Controller(this.state);

  List<PhotoMemo> memosList = [];
  int listLen;

  // void getMemo() async {
  //   memosList = await FirebaseFirestoreController.getMemo();
  //   listLen = memosList.length;
  // }

  void addButton() async {
    await Navigator.pushNamed(state.context, AddPhotoMemoScreen.routeName,
        arguments: {Constant.ARG_USER: state.user});
  }

  void signOut() async {
    try {
      await FirebaseAuthController.signOut();
    } catch (e) {
      //do nothing
    }
    Navigator.of(state.context).pop();
    Navigator.of(state.context).pop();
  }
}
