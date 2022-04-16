import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/socialCubit/cubit.dart';
import 'package:social_app/socialCubit/states.dart';
import 'package:social_app/style/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({Key? key}) : super(key: key);

  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Align(
          // عشنان السنقل سكرول فيو يبدأ من فوق لما ما تكون العناصر قليلة
          alignment: AlignmentDirectional.topCenter,
          child: RefreshIndicator(
            onRefresh: () async {
              await SocialCubit.get(context).getPosts();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is SocialCreatePostLoadingState)
                    Card(
                      margin: const EdgeInsets.only(
                        left: 8.0,
                        top: 10,
                        right: 10,
                      ),
                      elevation: 5,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SocialCubit.get(context).postImage != null
                            ? Row(
                                children: [
                                  Image(
                                    image: FileImage(
                                        SocialCubit.get(context).postImage!),
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Expanded(
                                    child: LinearProgressIndicator(
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Upload New Post...',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  LinearProgressIndicator(
                                    backgroundColor: Colors.transparent,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 8.0),
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              'https://img.freepik.com/free-photo/photo-pretty-ethnic-woman-ponders-how-answer-question-thinks-deeply-about-something-uses-modern-mobile-phone-tries-made-up-good-message-keeps-index-finger-near-lips-stands-indoor_273609-43458.jpg?w=740',
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                          ),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate With Friends',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: SocialCubit.get(context).posts!.length,
                    itemBuilder: (context, index) {
                      return buildPost(
                        SocialCubit.get(context).posts![index],
                        context,
                        index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildPost(
    PostModel postModel,
    context,
    int index,
  ) =>
      Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: CachedNetworkImage(
                        height: double.infinity,
                        width: double.infinity,
                        imageUrl: postModel.uId ==
                                SocialCubit.get(context).userModel!.uId
                            ? SocialCubit.get(context).userModel!.image!
                            : postModel.image!,
                        placeholder: (context, url) => CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.grey[300],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              postModel.name!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900, height: 1.3),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            if (postModel.uId ==
                                SocialCubit.get(context).userModel!.uId)
                              Icon(
                                Icons.check_circle,
                                color: Theme.of(context).primaryColor,
                                size: 15,
                              ),
                          ],
                        ),
                        Text(
                          postModel.dateTime!,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.3),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    splashRadius: 25.0,
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz),
                  )
                ],
              ),
              const Divider(
                height: 30,
              ),
              Text(postModel.postText!),
              /*Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 5,
                    children: [
                      SizedBox(
                        height: 20.0,
                        child: MaterialButton(
                          minWidth: 0.5,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#SaveSheikhJarrah',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                        child: MaterialButton(
                          minWidth: 0.5,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#SaveSheikhJarrah',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                        child: MaterialButton(
                          minWidth: 0.5,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#SaveSheikhJarrah',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
              if (postModel.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: double.infinity,
                    height: 250.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: postModel.postImage!,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              const Icon(
                                IconBroken.Heart,
                                color: Colors.blueGrey,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text('${SocialCubit.get(context).likes[index]}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                IconBroken.Chat,
                                color: Colors.blueGrey,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                '${SocialCubit.get(context).countComments[SocialCubit.get(context).postsId[index]]} comment',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Divider(
                  height: 1,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SocialCubit.get(context).getComments(
                            SocialCubit.get(context).postsId[index]);
                        showModalBottomSheet(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          isScrollControlled: true,
                          isDismissible: false,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                            ),
                          ),
                          context: context,
                          builder: (context) {
                            return buildCommentsScreen(context, index);
                          },
                        );
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: CachedNetworkImage(
                                height: double.infinity,
                                width: double.infinity,
                                imageUrl:
                                    SocialCubit.get(context).userModel!.image!,
                                placeholder: (context, url) => CircleAvatar(
                                  radius: 18.0,
                                  backgroundColor: Colors.grey[300],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Write a comment...',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: InkWell(
                      onTap: () {
                        SocialCubit.get(context).likePost(
                            postId: SocialCubit.get(context).postsId[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: const [
                            Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                              size: 20,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              'Like',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildCommentsScreen(
    BuildContext context,
    int index,
  ) {
    return FractionallySizedBox(
      heightFactor: 0.965,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Divider(
                height: 20,
              ),
              Expanded(
                child: SocialCubit.get(context).comments.isNotEmpty
                    ? ListView.builder(
                        itemCount: SocialCubit.get(context).comments.length,
                        itemBuilder: (context, i) {
                          return buildComment(context, i);
                        },
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'No comments yet',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey, height: 1.4),
                          ),
                          Text(
                            'Be the first to comment.',
                            style: TextStyle(color: Colors.grey, height: 1.4),
                          ),
                        ],
                      ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black12,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: TextFormField(
                          controller: commentController,
                          autofocus: true,
                          onChanged: (String value) {
                            if (!RegExp(r'^[ ]*$').hasMatch(value)) {
                              SocialCubit.get(context)
                                  .enableCommentButton(comment: value);
                            } else {
                              SocialCubit.get(context)
                                  .unableCommentButton(comment: value);
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'Write a comment...',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black12,
                    radius: 20,
                    child: IconButton(
                      color: Theme.of(context).primaryColor,
                      splashRadius: 20,
                      onPressed: SocialCubit.get(context).currentComment == ''
                          ? null
                          : () {
                              SocialCubit.get(context).commentPost(
                                postId: SocialCubit.get(context).postsId[index],
                                dateTime: DateTime.now().toString(),
                                commentText: commentController.text,
                              );
                              commentController.clear();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                      icon: const Icon(IconBroken.Send),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildComment(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: CachedNetworkImage(
                height: double.infinity,
                width: double.infinity,
                imageUrl: SocialCubit.get(context).comments[index].uId! ==
                        SocialCubit.get(context).userModel!.uId!
                    ? SocialCubit.get(context).userModel!.image!
                    : SocialCubit.get(context).comments[index].image!,
                placeholder: (context, url) => CircleAvatar(
                  radius: 18.0,
                  backgroundColor: Colors.grey[300],
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.black12,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SocialCubit.get(context).comments[index].name!,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      SocialCubit.get(context).comments[index].commentText!,
                      style: const TextStyle(height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
