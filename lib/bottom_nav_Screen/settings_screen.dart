import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc/cubit.dart';
import 'package:social_app/bloc/states.dart';
import 'package:social_app/screens/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel=SocialCubit.get(context).userModel;
        return     Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 220,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 170,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.only(
                                topLeft: Radius.circular(4)
                                ,topRight:  Radius.circular(4)),

                            image: DecorationImage(
                              image: NetworkImage("${userModel!.cover}"),
                              fit: BoxFit.cover,

                            )
                        ),
                      ),
                    ),

                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white70
                      ),
                      child:  CircleAvatar(
                        radius: 60,
                        backgroundImage:
                        NetworkImage("${userModel!.image}"),

                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Text('${userModel.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
              Text('${userModel.bio} ',style: Theme.of(context).textTheme.caption),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100 ',
                              style: TextStyle
                                (fontWeight:
                              FontWeight.bold,fontSize: 17),),
                            Text('post ',
                                style:
                                Theme.of(context).textTheme.caption),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('39 ',
                              style: TextStyle
                                (fontWeight:
                              FontWeight.bold,fontSize: 17),),
                            Text('Followings ',
                                style:
                                Theme.of(context).textTheme.caption),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('10k ',
                              style: TextStyle
                                (fontWeight:
                              FontWeight.bold,fontSize: 17),),
                            Text('Followers ',
                                style:
                                Theme.of(context).textTheme.caption),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('50 ',
                              style: TextStyle
                                (fontWeight:
                              FontWeight.bold,fontSize: 17),),
                            Text('Photos ',
                                style:
                                Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: (){
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){

                      },
                      child: const Text('Add Photos'),),
                  ),
                  SizedBox(width: 10,),
                  OutlinedButton(onPressed: (){
                    Navigator.of(context).
                    push(MaterialPageRoute(builder: (context)=>EditProfileScreen()));

                  },
                      child: Icon(Icons.edit  , color: Colors.blue,))
                ],
              )
            ],
          ),
        );
      },


    );
  }
}
