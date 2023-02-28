import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc/cubit.dart';
import 'package:social_app/bloc/cubit.dart';
import 'package:social_app/bloc/states.dart';
import 'package:social_app/models/post_model.dart';

class FeedsScreen extends StatelessWidget {

  var commentC=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return ConditionalBuilder(
      condition:SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).userModel !=null ,
      builder: (context)
      => SingleChildScrollView(
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 10,
              margin: EdgeInsets.all(8),
              child:
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Image(
                    image: NetworkImage
                      ("https://images.pexels.com/photos/2694434/pexels-photo-2694434.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,


                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("communicate with friends"
                      ,style: TextStyle(color: Colors.white),),
                  ),

                ],
              ),
            ),

            ListView.separated(itemBuilder:
                (context, index)=> buildPostItem( SocialCubit.get(context).posts[index],context , index),
              itemCount: SocialCubit.get(context).posts.length,

              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 8,

              );
              },
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
      fallback: (context)
      =>Center(child: CircularProgressIndicator()),
    );
  },
);
  }

  Widget buildPostItem(PostModel model ,BuildContext context,index) {
    return Card(
            margin: EdgeInsets.symmetric(horizontal: 8),
            clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          child:Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                      NetworkImage('${model.image}'),

                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("${model.name}",
                              style: TextStyle(height: 1.3),),
                              SizedBox(width: 5,),
                              Icon(Icons.check_circle,
                              color: Colors.blue,
                                size: 16,
                              ),
                            ],
                          ),
                          Text("${model.dateTime}",
                            style: Theme.of(context).textTheme.caption?.
                            copyWith(height: 1.3),),

                        ],
                      ),
                    ),
                    SizedBox(width: 15,),
                    IconButton(onPressed: (){},
                        icon: Icon(Icons.more_horiz,size: 20,))

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],

                  ),
                ),
                Text("${model.text}",
                ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10,top: 5),
              //   child: Container(
              //     width: double.infinity,
              //
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const
              //           EdgeInsetsDirectional.only(end: 6),
              //
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(onPressed: (){},
              //                 minWidth: 1,
              //                 padding: EdgeInsets.zero,
              //                 child: Text("#software",
              //                   style: Theme.of(context).textTheme.caption?.copyWith(
              //                       color: Colors.blue
              //                   ),
              //                 )),
              //           ),
              //         ),
              //         Padding(
              //           padding: const
              //           EdgeInsetsDirectional.only(end: 6),
              //
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(onPressed: (){},
              //                 minWidth: 1,
              //                 padding: EdgeInsets.zero,
              //                 child: Text("#software",
              //                   style: Theme.of(context).textTheme.caption?.copyWith(
              //                       color: Colors.blue
              //                   ),
              //                 )),
              //           ),
              //         ),
              //
              //
              //       ],
              //     ),
              //   ),
              // ),
                if(model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 15),
                child: Container(
                  height: 420,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(5) ,
                    image: DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover,

                    )
                  ),
                ),
              ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Icon(Icons.favorite,
                                  color: Colors.red,
                                size: 15,
                                ),
                                SizedBox(width: 5,),
                                Text("${SocialCubit.get(context).likes[index]}",style: Theme.of(context).textTheme?.caption,)
                              ],
                            ),
                          ),
                          onTap: (){
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.comment,
                                  color: Colors.amber,
                                size: 15,
                                ),
                                SizedBox(width: 5,),
                                Text("${SocialCubit.get(context).comments[index]}",style: Theme.of(context).textTheme.caption,)
                              ],
                            ),
                          ),
                          onTap: (){},
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],

                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller:commentC ,
                        decoration: InputDecoration(
                          label: Text('write a comment',style: TextStyle(fontSize: 15),),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      // InkWell(
                      //   child: Row(
                      //     children: [
                      //       CircleAvatar(
                      //         radius: 15,
                      //         backgroundImage:
                      //         NetworkImage("${SocialCubit.get(context).userModel?.image}"),
                      //
                      //       ),
                      //       SizedBox(width: 15,),
                      //
                      //       Text("write a comment",
                      //         style: Theme.of(context).textTheme.caption?.
                      //         copyWith(height: 1.3),),
                      //     ],
                      //   ),
                      //   onTap: (){},
                      // ),
                    ),
                    IconButton(onPressed: (){
                      SocialCubit.get(context).commentPost
                        (SocialCubit.get(context).postsId[index], commentC.text);
                      commentC.text = "";
                    }, icon: Icon(Icons.send,color: Colors.blue,)),
                    InkWell(
                      child: Row(
                        children: [
                          Icon(Icons.favorite,
                            color: Colors.red,
                            size: 20,
                          ),
                          SizedBox(width: 5,),
                          Text("Like",style: Theme.of(context).textTheme.caption,)
                        ],
                      ),
                      onTap: (){
                        SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);

                      },
                    ),

                  ],
                )
              ],
            ),
          )
        );
  }
}
