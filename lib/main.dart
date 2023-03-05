
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/bloc/cubit.dart';
import 'package:social_app/bloc/states.dart';
import 'package:social_app/component/cons.dart';
import 'package:social_app/screens/Layout_Screen.dart';
import 'package:social_app/shared/cache_Helper.dart';
import 'network/MyBlocOserver.dart';
import 'package:flutter/material.dart';

import 'screens/social_Login_Screen.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  // await Firebase.initializeApp();
  // print("Handling a background message : ${message.messageId}");
  print(message.data.toString());
  Fluttertoast.showToast(
      msg: " Messaging Background Handler",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
Future<void> main() async {

  Bloc.observer=MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token=await FirebaseMessaging.instance.getToken();

  print('token >>>>> ${token.toString()}');

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());

    Fluttertoast.showToast(
        msg: "On message",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    Fluttertoast.showToast(
        msg: "on Message Opened App",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Widget widget;


   uId=CacheHelper.getData(key: 'uID').toString()??"";
   print(uId);

  if(uId != null)
    {
      widget = SocialLayout();
    }else
      {
        widget= SocialLoginScreen();
      }
  // widget = SocialLoginScreen();
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  MyApp( this.startWidget);
   Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      SocialCubit()..getUserData()..getPosts()..getPosts2(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state){},
          builder: (context, state){
          return  MaterialApp(
          title: 'Social App',
          debugShowCheckedModeBanner: false,
    theme: ThemeData(

    primarySwatch: Colors.blue,
    ),
    home: startWidget,
    );
    }

      ),
    );
  }
}

