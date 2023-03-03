import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../models/message_model.dart';
import '../models/social_user_model.dart';

class ChatDetailsScreen extends StatefulWidget {
  ChatDetailsScreen(this.userModel);
  // ChatDetailsScreen({ Key? key, @required this.userModel}) : super(key: key);

  SocialUserModel? userModel;

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState(userModel);
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  var messageC = TextEditingController();
  bool a = false;
  SocialUserModel? userModel;

  _ChatDetailsScreenState(this.userModel); //constructor

  @override
  void initState() {
    return SocialCubit.get(context).getMessage(receiverId: userModel!.uId!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('${userModel!.image}'),
                ),
                SizedBox(
                  width: 15,
                ),
                Text('${userModel!.name}'),
              ],
            ),
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).messages.length >= 0,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      reverse: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var message =
                              SocialCubit.get(context).messages[index];
                          if (SocialCubit.get(context).userModel!.uId != message.senderId) {
                            return buildMessage(message);
                          }else {
                            return buildMyMessage(message);
                          }
                        },
                        separatorBuilder: (context, state) => SizedBox(
                              height: 15,
                            ),
                        itemCount: SocialCubit.get(context).messages.length),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            SocialCubit.get(context).getMessageImage();
                          },
                          child: Icon(
                            Icons.photo,
                            color: Colors.white,
                          ),
                          minWidth: 2,
                          height: 50,
                          color: Colors.blue[300],
                        ),
                        Expanded(
                          child: TextFormField(
                            onTap: () {
                              return SocialCubit.get(context)
                                  .getMessage(receiverId: userModel!.uId!);
                            },
                            controller: messageC,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'enter your massage ',
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            // if (messageC == '' &&
                            //     SocialCubit.get(context).messageImage == null) {
                            //   null;
                            // } else if (SocialCubit.get(context).messageImage ==
                            //     null) {
                            //   null;
                            // } else if (messageC.text == '') {
                            //   null;
                            // } else if (messageC.text != '') {
                            //   SocialCubit.get(context).sendMessage(
                            //       receiverId: userModel!.uId!,
                            //       dateTime: DateTime.now().toString(),
                            //       text: messageC.text);
                            //   messageC.text = '';
                            // } else if (SocialCubit.get(context).messageImage !=
                            //     null) {
                            //   SocialCubit.get(context).uploadMessageImage(
                            //       dateTime: DateTime.now().toString(),
                            //       text: messageC.text,
                            //       receiverId: userModel!.uId!);
                            // } else if (SocialCubit.get(context).messageImage !=
                            //         null &&
                            //     messageC.text != '') {
                            //   SocialCubit.get(context).sendMessage(
                            //       receiverId: userModel!.uId!,
                            //       dateTime: DateTime.now().toString(),
                            //       text: messageC.text);
                            // }

                            // if(messageC.text != ''){
                            //   SocialCubit.get(context)
                            //       .sendMessage
                            //     (receiverId: userModel!.uId!,
                            //       dateTime: DateTime.now().toString(),
                            //       text:messageC.text );
                            //   messageC.text='';
                            // }else
                            if(SocialCubit.get(context).messageImage != null && messageC.text != '')
                              {
                                SocialCubit.get(context).sendMessage(
                                    receiverId: userModel!.uId!,
                                    dateTime:  DateTime.now().toString(),
                                    text: messageC.text);
                                messageC.text='';

                                SocialCubit.get(context).uploadMessageImage(
                                    dateTime: DateTime.now().toString(),
                                    text: 'messageC.text',
                                    receiverId: userModel!.uId!);
                                SocialCubit.get(context).messageImage=null;
                              }
                          else  if(SocialCubit.get(context).messageImage != null)
                              {
                                SocialCubit.get(context).uploadMessageImage(
                                          dateTime: DateTime.now().toString(),
                                          text: 'messageC.text',
                                          receiverId: userModel!.uId!);
                                SocialCubit.get(context).messageImage=null;
                              }
                              else if(messageC.text != '')
                                {
                                  SocialCubit.get(context).sendMessage(
                                      receiverId: userModel!.uId!,
                                      dateTime:  DateTime.now().toString(),
                                      text: messageC.text);
                                  messageC.text='';
                                }

                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          minWidth: 1,
                          height: 50,
                          color: Colors.blue[300],
                        )
                      ],
                    ),
                  ),
                  if (SocialCubit.get(context).messageImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image: FileImage(
                                    SocialCubit.get(context).messageImage!),
                                fit: BoxFit.cover,
                              )),
                        ),
                        IconButton(
                            onPressed: () {
                              SocialCubit.get(context).removeMessageImage();
                            },
                            icon: const CircleAvatar(
                              backgroundColor: Colors.white70,
                              child: Icon(
                                Icons.close,
                                size: 20,
                              ),
                            ))
                      ],
                    ),
                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildMyMessage(MessageModel model) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                    topStart: Radius.circular(10),
                  ),
                  color: Colors.blue[300]),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child:model.text == null ? SizedBox() :Text('${model.text}')),
        ),
        if (model.messageImage != '' && model.messageImage != null)
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage( '${model.messageImage}'  ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        else
          SizedBox(height: 0,width: 0,)
      ],
    );
  }

  Widget buildMessage(MessageModel model) {
    return Column(
      children: [

        Align(
          alignment: AlignmentDirectional.bottomStart,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10),
                    topEnd: Radius.circular(10),
                    topStart: Radius.circular(10),
                  ),
                  color: Colors.grey[400]),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child:model.text == null ? SizedBox() :Text('${model.text}')),
        ),

        if (model.messageImage != '' && model.messageImage != null)
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage( '${model.messageImage}'  ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        else
          SizedBox(height: 0,width: 0,)
      ],
    );
  }
}

//
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../bloc/cubit.dart';
// import '../bloc/states.dart';
// import '../models/message_model.dart';
// import '../models/social_user_model.dart';
//
//
//
// class ChatDetailsScreen extends StatelessWidget {
//   ChatDetailsScreen(  this.userModel);
//
//   SocialUserModel? userModel;
//
//   var messageC=TextEditingController();
//   bool a=false;
//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//         builder: (context) {
//
//           SocialCubit.get(context).
//           getMessage(receiverId: userModel!.uId!);
//
//           return BlocConsumer<SocialCubit, SocialStates>(
//             listener: (context, state) {},
//             builder: (context, state) {
//               return Scaffold(
//                 appBar: AppBar(
//                   titleSpacing: 0,
//                   title: Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 20,
//                         backgroundImage:
//                         NetworkImage('${userModel!.image}'),
//                       ),
//                       SizedBox(width: 15,),
//                       Text('${userModel!.name}'),
//                     ],
//                   ),
//                 ),
//
//                 body: ConditionalBuilder(
//                   condition:SocialCubit.get(context).messages.
//                   length >= 0,
//                   builder:(context)=>
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           children: [
//                             Expanded(
//                               child: ListView.separated(
//                                   physics: BouncingScrollPhysics(),
//                                   itemBuilder: (context, index){
//                                     var message=
//                                     SocialCubit.get(context).messages[index];
//                                     if(SocialCubit.get(context)
//                                         .userModel!.uId == message.senderId)
//                                       return buildMyMessage(message);
//
//                                     return buildMessage(message);
//                                   },
//                                   separatorBuilder: (context, state)
//                                   =>SizedBox(height: 15,),
//                                   itemCount: SocialCubit.get(context).messages.length),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.black12,
//                                   width: 1,
//                                 ),
//                                 borderRadius:
//                                 BorderRadius.circular(8),
//
//                               ),
//                               clipBehavior: Clip.antiAliasWithSaveLayer,
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: TextFormField(
//                                       onTap: (){
//                                         return SocialCubit.get(context).
//                                         getMessage(receiverId: userModel!.uId!);
//                                       },
//                                       controller: messageC,
//                                       decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         hintText: 'enter your massage ',
//                                       ),
//                                     ),
//                                   ),
//                                   MaterialButton(
//                                     onPressed: (){
//                                       SocialCubit.get(context)
//                                           .sendMessage
//                                         (receiverId: userModel!.uId!,
//                                           dateTime: DateTime.now().toString(),
//                                           text:messageC.text );
//                                       a=true;
//                                       return SocialCubit.get(context).
//                                       getMessage(receiverId: userModel!.uId!);
//                                     },
//                                     child: Icon(Icons.send ,
//                                       color: Colors.white,),
//                                     minWidth: 1,
//                                     height: 50,
//                                     color: Colors.blue[300],
//
//                                   )
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                   fallback:(context)=>Center(child: CircularProgressIndicator()),
//                 ),
//               );
//             },
//           );
//         }
//     );
//   }
//
//   Widget buildMyMessage(MessageModel model) {
//     return Align(
//       alignment: AlignmentDirectional.centerEnd,
//       child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadiusDirectional.only(
//                 bottomStart: Radius.circular(10),
//                 topEnd: Radius.circular(10),
//                 topStart: Radius.circular(10),
//               ),
//               color: Colors.blue[300]
//           ),
//           padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
//           child: Text('${model.text!}')
//       ),
//     );
//   }
//
//   Widget buildMessage(MessageModel model) {
//     return Align(
//       alignment: AlignmentDirectional.centerStart,
//       child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadiusDirectional.only(
//                 bottomEnd: Radius.circular(10),
//                 topEnd: Radius.circular(10),
//                 topStart: Radius.circular(10),
//               ),
//               color: Colors.grey[400]
//           ),
//           padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
//           child: Text('${model.text}')
//       ),
//     );
//   }
// }
//
