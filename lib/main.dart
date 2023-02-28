import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc/cubit.dart';
import 'package:social_app/bloc/states.dart';
import 'package:social_app/component/cons.dart';
import 'package:social_app/screens/Layout_Screen.dart';
import 'package:social_app/shared/cache_Helper.dart';
import 'network/MyBlocOserver.dart';
import 'package:flutter/material.dart';

import 'screens/social_Login_Screen.dart';
Future<void> main() async {

  Bloc.observer=MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
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

