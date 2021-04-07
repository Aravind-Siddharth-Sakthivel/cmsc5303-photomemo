import 'package:flutter/material.dart';
import 'package:photomemo/controller/firebase_firestore_controller.dart';
import 'package:photomemo/models/photomemo.dart';
import 'package:photomemo/screens/myview/mydialog.dart';

class MemoDetails extends StatefulWidget {
  static const routeName = '/memoDetail';

  @override
  _MemoDetailsState createState() => _MemoDetailsState();
}

class _MemoDetailsState extends State<MemoDetails> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  _Controller con;
  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  bool enabeled = false;
  bool edit = false;

  void render(fn) => setState(fn);
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    PhotoMemo memo = args['memoItem'];
    // IconData icon = Icons.edit;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('PhotoMemo details'),
          actions: [
            IconButton(
              icon: enabeled == false ? Icon(Icons.edit) : Icon(Icons.check),
              onPressed: () {
                setState(() {
                  enabeled = !enabeled;
                });
                if (enabeled) {
                  if (!formKey.currentState.validate()) return;
                  formKey.currentState.save();

                  FirebaseFirestoreController.update(memo.docID, memo);
                }
              },
            ),
            IconButton(
              onPressed: () {
                MyDialog.alert(
                    context: context,
                    title: "Are you sure you want to delete this memo ?",
                    action: () {
                      con.delete(memo, context);
                    });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (memo.photoURL.isNotEmpty)
                  Image.network(
                    memo.photoURL,
                    width: 200,
                  ),
                SizedBox(height: 13),
                Container(
                  padding: EdgeInsets.all(20),
                  color: Color(0xffD6D9F0),
                  child: Column(
                    children: [
                      TextFormField(
                        enabled: enabeled,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        autocorrect: true,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        initialValue: memo.title,
                        validator: PhotoMemo.validateMemo,
                        onSaved: (String value) {
                          con.saveTitle(memo, value);
                        },
                      ),
                      SizedBox(height: 13),
                      TextFormField(
                        enabled: enabeled,
                        initialValue: memo.memo,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        autocorrect: true,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        validator: PhotoMemo.validateMemo,
                        onSaved: (String value) {
                          con.saveMemo(memo, value);
                        },
                      ),
                      SizedBox(height: 13),
                      TextFormField(
                        initialValue: memo.sharedWith.toString(),
                        decoration: InputDecoration(
                          enabled: enabeled,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          hintText: 'SharedWith (comma seperated email list)',
                          hintStyle: TextStyle(
                            color: Colors.grey[800],
                          ),
                        ),
                        autocorrect: false,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 2,
                        validator: PhotoMemo.validateShareWith,
                        onSaved: (String value) {
                          con.saveSharedWith(memo, value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _MemoDetailsState state;
  _Controller(this.state);

  void saveTitle(PhotoMemo memo, String value) {
    memo.title = value;
  }

  void saveMemo(PhotoMemo memo, String value) {
    memo.memo = value;
  }

  void saveSharedWith(PhotoMemo memo, String value) {
    if (value.trim().length != 0) {
      memo.sharedWith =
          value.split(RegExp('(,| )+')).map((e) => e.trim()).toList();
    }
  }

  void delete(PhotoMemo memo, context) {
    try {
      FirebaseFirestoreController.delete(memo.docID).then((value) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    } catch (e) {
      print('#################### $e');
    }
  }
}
