abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserLoadingsState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;

  SocialGetUserErrorState(this.error);

}

class SocialGetAllUserSuccessState extends SocialStates{}

class SocialGetAllUserLoadingsState extends SocialStates{}

class SocialGetAllUserErrorState extends SocialStates{
  final String error;

  SocialGetAllUserErrorState(this.error);

}

class SocialChangeBottomNav extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}

class SocialCoverImagePickedErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUserUpdateLoadingState extends SocialStates{}

class SocialUserUpdateErrorState extends SocialStates{}

// create post
class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}

class SocialRemovePostImageState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsLoadingsState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates{
  final String error;

  SocialGetPostsErrorState(this.error);

}
// like post

class SocialLikePostSuccessState extends SocialStates{}


class SocialLikePostErrorState extends SocialStates{
  final String error;

  SocialLikePostErrorState(this.error);

}

// comment post
class SocialCommentPostSuccessState extends SocialStates{}


class SocialCommentPostErrorState extends SocialStates{
  final String error;

  SocialCommentPostErrorState(this.error);
}

// message

class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates{}

class SocialGetMessageSuccessState extends SocialStates{}

