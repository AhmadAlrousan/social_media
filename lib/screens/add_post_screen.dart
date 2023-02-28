import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc/cubit.dart';
import 'package:social_app/bloc/states.dart';

class NewPostScreen extends StatelessWidget {

  var textC=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("add post"),
            actions: [
              TextButton(

                  onPressed: () {
                    if(textC.text =='' && SocialCubit.get(context).postImage == null)
                      {
                        null;
                      }
                   else if (SocialCubit.get(context).postImage == null) {
                      SocialCubit.get(context)
                          .createPost(
                          dateTime: DateTime.now().toString(),
                          text: textC.text);
                    }else{
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: DateTime.now().toString(),
                          text: textC.text,
                      );
                    }
                    SocialCubit.get(context).postImage=null;
                  },
                  child: Text(
                    "Post",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 5,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          "${SocialCubit.get(context).userModel?.image}"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            "ahmad",
                            style: TextStyle(height: 1.3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textC,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind ',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),

                          image: DecorationImage(
                            image:FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,

                          )
                      ),
                    ),
                    IconButton(onPressed: (){
                      SocialCubit.get(context).removePostImage();
                      },
                        icon: const CircleAvatar(
                          backgroundColor: Colors.white70,
                          child: Icon
                            (Icons.close,size: 20,),

                        ))
                  ],
                ),
                SizedBox(height:30,),

                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image),
                              SizedBox(
                                width: 5,
                              ),
                              Text('add photo'),
                            ],
                          )),
                    ),
                    Expanded(
                      child:
                          TextButton(onPressed: () {}, child: Text('# tags')),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
