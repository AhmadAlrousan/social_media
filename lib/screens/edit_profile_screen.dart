
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc/states.dart';
import '../bloc/cubit.dart';

class EditProfileScreen extends StatelessWidget {

  var nameC=TextEditingController();
  var bioC=TextEditingController();
  var phoneC=TextEditingController();


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel=SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var profileCover = SocialCubit.get(context).profileCover;

        nameC.text=userModel!.name!;
        bioC.text=userModel.bio!;
        phoneC.text=userModel.phone!;

        return     Scaffold(
          appBar: AppBar(
            title: const Text("Edit profile"),
            actions: [
              TextButton(onPressed: (){
                SocialCubit.get(context).
                updateUser(
                    name: nameC.text,
                    phone: phoneC.text,
                    bio: bioC.text);
              },
                child:  const Text(
                  "Update",
                  style: TextStyle
                    (color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
              const SizedBox(width: 15,)
            ],

          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),

                  SizedBox(
                    height: 220,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                height: 170,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:const BorderRadius.only(
                                        topLeft: Radius.circular(4)
                                        ,topRight:  Radius.circular(4)),

                                    image: DecorationImage(
                                      image:  profileCover == null ?
                                      NetworkImage("${userModel.cover}")
                                          : FileImage(profileCover) as ImageProvider,
                                      fit: BoxFit.cover,

                                    )
                                ),
                              ),
                              IconButton(onPressed: (){ SocialCubit.get(context).getProfileCover();},
                                  icon: const CircleAvatar(
                                      backgroundColor: Colors.white70,
                                      child: Icon
                                        (Icons.camera_alt,size: 20,),

                                  ))
                            ],
                          ),
                        ),
                        Container(
                          width: 110,
                          height: 110,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white70
                          ),
                          child:  Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                profileImage == null ?
                                NetworkImage("${userModel.image}")
                                : FileImage(profileImage) as ImageProvider,
                              ),
                              IconButton(onPressed: (){
                                SocialCubit.get(context).getProfileImage();
                              },
                                  icon: const CircleAvatar(
                                    maxRadius: 15,
                                    backgroundColor: Colors.white70,
                                    child: Icon
                                      (Icons.camera_alt,size: 15,),

                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20,),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).profileCover != null)
                  Row(children: [
                      if(SocialCubit.get(context).profileImage != null)
                   Expanded(
                     child: Column(
                       children: [
                         ElevatedButton(
                             onPressed: (){
                               SocialCubit.get(context).uploadProfile(name: nameC.text, phone: phoneC.text, bio: bioC.text);
                             },
                             child: Text('upload profile')),
                         if(state is SocialUserUpdateLoadingState)
                           SizedBox(height: 5,),
                         if(state is SocialUserUpdateLoadingState)
                           LinearProgressIndicator(),
                       ],
                     ),
                   ),
                      const SizedBox(width: 8,),
                    if(SocialCubit.get(context).profileCover != null)
                    Expanded(
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: (){
                                SocialCubit.get(context).uploadCover(name: nameC.text, phone: phoneC.text, bio: bioC.text);
                              },
                              child: Text('upload cover')),
                          if(state is SocialUserUpdateLoadingState)
                           SizedBox(height: 5,),
                          if(state is SocialUserUpdateLoadingState)
                            LinearProgressIndicator(),
                        ],
                      ),
                    ),
                  ],),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).profileCover != null)
                    const SizedBox(height: 20,),

                  TextFormField(
                    controller:nameC,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      label: const Text('name'),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.8)
                        ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "name is Empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: bioC,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.short_text_sharp),
                      label: const Text('bio'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.8),
                      ),
                    ),
                    validator: (val) {
                      // validator Shows some notifications under the TextFormField
                      if (val!.isEmpty) {
                        // Here, if the TextFormField is empty, it gives an alert
                        return "bio is Empty";
                      }
                      return null;
                    }
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller:phoneC,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.phone),
                      label: const Text('phone'),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.8)
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "phone is Empty";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
