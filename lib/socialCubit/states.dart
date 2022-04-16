abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetAllUserLoadingState extends SocialStates{}

class SocialGetAllUserSuccessState extends SocialStates{}

class SocialGetAllUserErrorState extends SocialStates{
  final String error;

  SocialGetAllUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}

class SocialEnableCommentButtonState extends SocialStates{}

class SocialEnableMessageButtonState extends SocialStates{}

class SocialUnableCommentButtonState extends SocialStates{}

class SocialUnableMessageButtonState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}

class SocialCoverImagePickedErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUpdateUserLoadingState extends SocialStates{}

class SocialUpdateUserErrorState extends SocialStates{}


// Create Post

class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}

class SocialPostImageRemoveState extends SocialStates{}

class SocialGetPostLoadingState extends SocialStates{}

class SocialGetPostSuccessState extends SocialStates{}

class SocialGetPostErrorState extends SocialStates{
  final String error;

  SocialGetPostErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates{
  final String error;

  SocialLikePostErrorState(this.error);
}

class SocialCommentPostSuccessState extends SocialStates{}

class SocialCommentPostErrorState extends SocialStates{
  final String error;

  SocialCommentPostErrorState(this.error);
}

class SocialGetCommentLoadingState extends SocialStates{}

class SocialGetCommentSuccessState extends SocialStates{}

class SocialGetCommentErrorState extends SocialStates{
  final String error;

  SocialGetCommentErrorState(this.error);
}

class SocialGetCountCommentSuccessState extends SocialStates{}

class SocialGetCountCommentErrorState extends SocialStates{
  final String error;

  SocialGetCountCommentErrorState(this.error);
}

class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates{}

class SocialGetMessagesSuccessState extends SocialStates{}

class SocialGetMessagesErrorState extends SocialStates{}

class SocialMessageImagePickedSuccessState extends SocialStates{}

class SocialMessageImagePickedErrorState extends SocialStates{}

class SocialChangeUnderLineState extends SocialStates{}
