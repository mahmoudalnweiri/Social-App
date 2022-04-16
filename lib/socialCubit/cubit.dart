import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/local/cache_helper.dart';
import 'package:social_app/socialApp/chats/chats_screen.dart';
import 'package:social_app/socialApp/feeds/feeds_screen.dart';
import 'package:social_app/socialApp/newPost/New_Post_Screen.dart';
import 'package:social_app/socialApp/notification/notification_screen.dart';
import 'package:social_app/socialApp/profile/profile_screen.dart';
import 'package:social_app/socialCubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  bool underPosts = true;
  bool underPhotos = false;

  underLinePosts(){
    underPosts = true;
    underPhotos = false;
    emit(SocialChangeUnderLineState());
  }

  underLinePhotos(){
    underPosts = false;
    underPhotos = true;
    emit(SocialChangeUnderLineState());
  }

  void getUser() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .get()
        .then((value) {
      //print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      if(posts!.isEmpty){
        getPosts();
      }

      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  Map<String, dynamic> pages = {
    'title': ['Home', 'Notification', 'Post', 'Chats', 'Profile'],
    'screen': [
      FeedsScreen(),
      const NotificationScreen(),
      NewPostScreen(),
      const ChatsScreen(),
      ProfileScreen(),
    ]
  };

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }

    if (index == 3) {
      getAllUsers();
    }
  }

  String currentComment = '';
  String currentMessage = '';

  enableCommentButton({required String comment}) {
    currentComment = comment;
    emit(SocialEnableCommentButtonState());
  }

  unableCommentButton({required String comment}) {
    currentComment = '';
    emit(SocialUnableCommentButtonState());
  }

  enableMessageButton({required String message}) {
    currentMessage = message;
    emit(SocialEnableMessageButtonState());
  }

  unableMessageButton({required String message}) {
    currentMessage = '';
    emit(SocialUnableMessageButtonState());
  }

  File? profileImage;
  File? coverImage;
  final picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      profileImage = File(pickerFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  Future<void> getCoverImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      coverImage = File(pickerFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((profileImageUrl) {
        print(profileImageUrl);

        /// Called updateUser method to pass profileImageUrl after upload it
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: profileImageUrl,
        );
      }).catchError((error) {
        print(error);
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error);
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((coverImageUrl) {
        print(coverImageUrl);

        /// Called updateUser method to pass coverImageUrl after upload it
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: coverImageUrl,
        );
      }).catchError((error) {
        print(error);
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      print(error);
      emit(SocialUploadCoverImageErrorState());
    });
  }

  /*void updateUserImages({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());

    if (profileImage != null) {
      uploadProfileImage();
    } else if (coverImage != null) {
      uploadCoverImage();
    } else if (profileImage != null && coverImage != null) {
    } else {
      updateUser(name: name, phone: phone, bio: bio);
    }
  }*/

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    UserModel model = UserModel(
      name: name,
      email: userModel!.email,
      phone: phone,
      uId: userModel!.uId,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      bio: bio,
      isEmailVerified: userModel!.isEmailVerified,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) {
      getUser();
    }).catchError((error) {
      emit(SocialUpdateUserErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      postImage = File(pickerFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialPostImageRemoveState());
  }

  void uploadPostImage({
    required String dateTime,
    required String postText,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((postImageUrl) {
        /// Called createPost method to pass coverImageUrl after upload it
        createPost(
          dateTime: dateTime,
          postText: postText,
          postImage: postImageUrl,
        );
      }).catchError((error) {
        print(error);
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      print(error);
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String? dateTime,
    required String? postText,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime,
      postText: postText,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model
            .toMap()) // راح يدخل في الـ collection ويعمل id لحاله للـ document
        .then((value) {
      getPosts();
      removePostImage();
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel>? posts;
  List<String> postsId = [];
  List<int> likes = [];
  List<CommentModel> comments = [];
  List<PostModel> myPosts = [];
  List<String> myPostsId = [];
  List<int> myLikes = [];
  List<CommentModel> myComments = [];
  List<String> myImages = [];

  Future<void> getPosts() async {
    emit(SocialGetPostLoadingState());

    FirebaseFirestore.instance.collection('posts').get().then((value) {
      posts = [];
      postsId = [];
      likes = [];
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          getCount(element.id);
          posts!.add(PostModel.formJson(element.data()));
        }).catchError((error) {
          print(error.toString() + '0');
        });

        if (PostModel.formJson(element.data()).uId == userModel!.uId) {
          myPosts = [];
          myPostsId = [];
          myLikes = [];
          myImages = [];
          element.reference.collection('likes').get().then((value) {
            myLikes.add(value.docs.length);
            myPostsId.add(element.id);
            myPosts.add(PostModel.formJson(element.data()));

            // إذا المنشور يحتوي على صورة، جيب الصورة وحطها في اللستة myImages
            if(PostModel.formJson(element.data()).postImage! != ""){
              myImages.add(PostModel.formJson(element.data()).postImage!);
            }

          }).catchError((error) {
            print(error.toString() + '0');
          });
        }
      }
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      print(error.toString() + '4');
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  void likePost({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void commentPost(
      {required String postId,
      required String dateTime,
      required String commentText}) {
    CommentModel commentModel = CommentModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime,
      commentText: commentText,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel.toMap())
        .then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

  void getComments(String postId) {
    emit(SocialGetCommentLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      comments = [];
      for (var element in event.docs) {
        element.reference.get().then((value) {
          comments.add(CommentModel.fromJson(value.data()!));
        });
      }
    });
    /*.get()
        .then((value) {
      for (var element in value.docs) {
        element.reference.get().then((value) {
          comments!.add(CommentModel.fromJson(value.data()!));
        });
      }
      emit(SocialGetCommentSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostErrorState(error.toString()));
    });*/
  }

  Map<String, int> countComments = {};

  void getCount(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get()
        .then((value) {
      countComments.addAll({postId: value.docs.length});
      emit(SocialGetCountCommentSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetCountCommentErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    emit(SocialGetAllUserLoadingState());

    FirebaseFirestore.instance.collection('users').get().then((value) {

      users = [];
      for (var element in value.docs) {
        // أجيب كل المستخدمين للشات وأستثني حالي
        if (element.data()['uId'] != userModel!.uId) {
          users.add(UserModel.fromJson(element.data()));
        }
      }
      emit(SocialGetAllUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetAllUserErrorState(error.toString()));
    });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String messageText,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      messageText: messageText,
    );

    /// تخزين الرسالة عندي
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialSendMessageErrorState());
    });

    /// نخزين الرسالة عند المستقبل
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessage({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.insert(0, MessageModel.fromJson(element.data()));
      }
      emit(SocialGetMessagesSuccessState());
    });
  }

  File? messageImage;

  Future getMessageImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      messageImage = File(pickerFile.path);
      emit(SocialMessageImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialMessageImagePickedErrorState());
    }
  }
}
