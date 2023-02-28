import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc/cubit.dart';
import 'package:social_app/bloc/cubit.dart';
import 'package:social_app/bloc/states.dart';
import 'package:social_app/models/social_user_model.dart';

import '../screens/Layout_Screen.dart';
import '../screens/chat_details_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length >0,
          builder: (context)=> ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index)=>buildChatItem( SocialCubit.get(context).users[index] ,context ),
        separatorBuilder: (context, index)=>
        Divider( color: Colors.blue,),
        itemCount:  SocialCubit.get(context).users.length),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );


      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ChatDetailsScreen( model,);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage:
              NetworkImage(
                  '${model.image}'),

            ),
            SizedBox(width: 15,),
            Text("${model.name}")

          ],
        ),
      ),
    );
  }


}