import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:l3photomemo/model/constant.dart';
import 'package:l3photomemo/screens/addphotomemo_screen.dart';
import 'package:l3photomemo/screens/signin_screen.dart';
import 'package:l3photomemo/screens/userhome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PhotoMemoApp());
}

class PhotoMemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: Constant.DEV,
      initialRoute: SignInScreen.routeName,
      routes: {
        SignInScreen.routeName: (context) => SignInScreen(),
        UserHomeScreen.routeName: (context) => UserHomeScreen(),
        AddPhotoMemoScreen.routeName: (context) => AddPhotoMemoScreen(),
      },
    );
  }
}
