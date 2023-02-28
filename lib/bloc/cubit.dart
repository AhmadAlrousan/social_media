import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/bloc/states.dart';
import 'package:social_app/bottom_nav_Screen/chat_Sccreen.dart';
import 'package:social_app/bottom_nav_Screen/feeds_screen.dart';
import 'package:social_app/bottom_nav_Screen/settings_screen.dart';
import 'package:social_app/bottom_nav_Screen/users_screen.dart';
import 'package:social_app/component/cons.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../models/message_model.dart';
import '../screens/add_post_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit(): super(SocialInitialState());

  static SocialCubit get(context)  => BlocProvider.of(context);

List <dynamic>? userData;
  SocialUserModel? userModel;

  void getUserData(){
    emit(SocialGetUserLoadingsState());
    FirebaseFirestore.instance.collection('users')
        .doc('NCfXphdKljRbgWq8Nre4Ktbwe772').get()
        .then((value) {
      print(value.data());
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print("Error getting document: $error");
    });
  }


  int currentIndex = 0;

  List<Widget> screens=[
    FeedsScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
    SettingsScreen(),


  ];

  List<String> titles=[
    "Home",
    "Chat",
    "add post"
    "Users",
    "Users",
    "Settings",

  ];


  void changeBottomNav(int index){
    if(index ==1)
      getUsers();
    if(index == 2)
      emit(SocialNewPostState());
    else
      {
        currentIndex = index;
        emit(SocialChangeBottomNav());

      }
  }



  File? profileImage;
  var picker =ImagePicker();

  Future<void> getProfileImage()async{
    final pickedFile=await picker.getImage
      (source: ImageSource.gallery);

    if(pickedFile != null){
      profileImage=File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else{
      print("No image selected");
      emit(SocialProfileImagePickedErrorState());
    }

  }


  File? profileCover;

  Future<void> getProfileCover()async{
    final pickedFile=await picker.getImage
      (source: ImageSource.gallery);

    if(pickedFile != null){
      profileCover=File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }else{
      print("No image selected");
      emit(SocialCoverImagePickedErrorState());
    }

  }

  void uploadProfile({
    required String name,
    required String phone,
    required String bio,
}){
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage
        .instance.ref().
    child('users/${Uri.file
      (profileImage!.path)
        .pathSegments.last}').putFile(profileImage!)
        .then((value){
          value.ref.getDownloadURL()
              .then((value) {
//            emit(SocialUploadProfileImageSuccessState());
            print(value);
            updateUser(
                name: name,
                phone: phone,
                bio: bio,
                image: value
            );
          }).catchError((error){
            emit(SocialUploadProfileImageErrorState());

          });
    }).catchError((error){
      emit(SocialUploadProfileImageErrorState());

    });
  }

  void uploadCover({
    required String name,
    required String phone,
    required String bio,
  }){
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage
        .instance.ref().
    child('users/${Uri.file
      (profileCover!.path)
        .pathSegments.last}').putFile(profileCover!)
        .then((value){
      value.ref.getDownloadURL()
          .then((value) {
//        emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            cover: value
        );
      }).catchError((error){
        emit(SocialUploadCoverImageErrorState());

      });
    }).catchError((error){
      emit(SocialUploadCoverImageErrorState());

    });
  }



  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,

  })
  {
    emit(SocialUserUpdateLoadingState());

      SocialUserModel model = SocialUserModel(
        name: name,
        phone: phone,
        bio: bio,
        email: userModel?.email,
        cover: cover ?? userModel?.cover,
        image: image ?? userModel?.image,
        uId: userModel?.uId,
        isEmailVerified: false,
      );
      FirebaseFirestore.instance.collection('users')
          .doc(userModel?.uId).
      update(model.toMap())
          .then((value) {
        getUserData();
      }).catchError((error){
        emit(SocialUserUpdateErrorState());
      });

    }



    ///..........
  //add post screen

  File? postImage ;

  Future<void> getPostImage()async{
    final pickedFile=await picker.getImage
      (source: ImageSource.gallery);

    if(pickedFile != null){
      postImage=File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    }else{
      print("No image selected");
      emit(SocialPostImagePickedErrorState());
    }

  }

  //add post screen

  void removePostImage(){
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  //add post screen

  void uploadPostImage({

    required String dateTime,
    required String text,

  }){
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage
        .instance.ref().
    child('posts/${Uri.file
      (postImage!.path)
        .pathSegments.last}').putFile(postImage!)
        .then((value){
      value.ref.getDownloadURL()
          .then((value) {
//        emit(SocialUploadCoverImageSuccessState());
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value
        );
      }).catchError((error){
        emit(SocialCreatePostErrorState());

      });
    }).catchError((error){
      emit(SocialCreatePostErrorState());

    });
  }


  //add post screen

  void createPost({

    required String dateTime,
    required String text,
    String? postImage,

  })
  {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      postImage: postImage??"",
      text: text
    );
    FirebaseFirestore.instance.collection('posts').
    add(model.toMap())
        .then((value) {
          emit(SocialCreatePostSuccessState());
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });

  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  //feeds screen

  void getPosts()
 {

  FirebaseFirestore.instance
      .collection('posts')
      .get().then((value) {
        value.docs.forEach((element) {
          element.reference
              .collection('likes')
              .get()
              .then((value) {
                likes.add(value.docs.length);
                postsId.add(element.id);
                posts.add(PostModel.fromJson(element.data()));

          }).catchError((error){

          });

        });
        emit(SocialGetPostsSuccessState());
  }).catchError((error){
    emit(SocialGetPostsErrorState(error.toString()));
  });

 }
  //feeds screen

  void getPosts2()
  {

    FirebaseFirestore.instance
        .collection('posts')
        .get().then((value) {
      value.docs.forEach((element) {
        element.reference
            .collection('comment')
            .get()
            .then((value) {
          comments.add(value.docs.length);
          postsId.add(element.id);
      //    posts.add(PostModel.fromJson(element.data()));

        }).catchError((error){

        });

      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error){
      emit(SocialGetPostsErrorState(error.toString()));
    });

  }

  //feeds screen

 void likePost(String postId)
 {
   FirebaseFirestore.instance
       .collection('posts')
       .doc(postId)
       .collection('likes')
       .doc(userModel?.uId)
       .set({'like' : true})
       .then((value) {
         emit(SocialLikePostSuccessState());
   }).catchError((error){
     emit(SocialLikePostErrorState(error.toString()));
   });
 }

 //feeds screen
  void commentPost(String postId , String comment)
  {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comment')
          .doc(userModel?.uId)
          .set({'comment': comment})
          .then((value) {
        emit(SocialCommentPostSuccessState());
      }).catchError((error) {
        emit(SocialCommentPostErrorState(error.toString()));
      });
  }


  // chat screen
  List<SocialUserModel>users=[];

  void getUsers()
  {
    //if(users.length == 0)
    users=[];
    FirebaseFirestore.instance
        .collection('users')
        .get().then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId'] != userModel?.uId)
        users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUserSuccessState());
    }).catchError((error){
      emit(SocialGetAllUserErrorState(error.toString()));
    });

  }

  // message
  void sendMessage
      ({
    required String receiverId,
    required String dateTime,
    required String text,
  })

  {

    MessageModel model = MessageModel(
        text: text,
        senderId: userModel?.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chat
    FirebaseFirestore.instance
        .collection('users')
    .doc(userModel?.uId)
    .collection('chats')
    .doc(receiverId).collection('messages')
    .add(model.toMap())
    .then((value) {
      emit(SocialSendMessageSuccessState());

    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });

    // set receiver chat

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId).collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());

    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });
  }


List<MessageModel> messages = [];
  
  void getMessage({required String receiverId,}){
    
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages').orderBy('dateTime')
        .snapshots()// stream (Q of Future)
        .listen((event)  {
          messages=[];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(SocialGetMessageSuccessState());
    });
  }

}
