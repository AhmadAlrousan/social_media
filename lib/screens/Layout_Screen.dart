import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/bloc/cubit.dart';
import 'package:social_app/bloc/states.dart';
import 'package:social_app/screens/add_post_screen.dart';
import 'package:social_app/screens/social_Login_Screen.dart';
import 'package:social_app/shared/cache_Helper.dart';


class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context, state){
        if(state is SocialNewPostState){
          Navigator.of(context).push
            (MaterialPageRoute(builder:
              (context)=> NewPostScreen()));
        }
      },
      builder: (context, state){
        var cubit=SocialCubit.get(context);

        return    Scaffold(
          appBar: AppBar(

            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
              IconButton(onPressed: (){}, icon: Icon(Icons.search)),
              IconButton(onPressed: (){CacheHelper.removeData(key: 'uID').then((value) {
                if(value){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                    return SocialLoginScreen();}));
                }
              });;}, icon: Icon(Icons.logout)),

            ],
          ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
              icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.blue,

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: "Chat",
                backgroundColor: Colors.blue,

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outlined),
                label: "post",
                backgroundColor: Colors.blue,

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: "Users",
                backgroundColor: Colors.blue,

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
                backgroundColor: Colors.blue,

              ),

            ],

        ),

        );
      },


    );
  }
}
