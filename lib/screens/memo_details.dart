import 'package:flutter/material.dart';

class MemoDetails extends StatefulWidget {
  static const routeName = '/memoDetail';

  @override
  _MemoDetailsState createState() => _MemoDetailsState();
}

class _MemoDetailsState extends State<MemoDetails> {
  _Controller con;
  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    Map<String, dynamic> memo = args['memoItem'];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add PhotoMemo'),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                memo['imgurl'],
                width: 200,
              ),
              SizedBox(height: 13),
              Container(
                padding: EdgeInsets.all(20),
                color: Color(0xffD6D9F0),
                child: Column(
                  children: [
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: memo['title'],
                        labelStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
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
                    ),
                    SizedBox(height: 13),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: memo['Memo'],
                        labelStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
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
                    ),
                    SizedBox(height: 13),
                    TextFormField(
                      decoration: InputDecoration(
                        enabled: false,
                        labelText: memo['sharedwith'].toString(),
                        labelStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _MemoDetailsState state;
  _Controller(this.state);
}
