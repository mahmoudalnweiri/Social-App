import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/socialApp/editProfile/Edit_Profile_Screen.dart';
import 'package:social_app/socialApp/images/image_details/image_details_screen.dart';
import 'package:social_app/socialApp/images/images_screen.dart';
import 'package:social_app/socialCubit/cubit.dart';
import 'package:social_app/socialCubit/states.dart';
import 'package:social_app/style/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  var myCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel!;

        return SocialCubit.get(context).userModel != null
            ? Align(
                // عشنان السنقل سكرول فيو يبدأ من فوق لما ما تكون العناصر كثيرة
                alignment: AlignmentDirectional.topCenter,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 280.0,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Container(
                                  width: double.infinity,
                                  height: 200.0,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                  ),
                                  child: CachedNetworkImage(
                                    height: double.infinity,
                                    width: double.infinity,
                                    imageUrl: model.cover!,
                                    placeholder: (context, url) => Container(color: Colors.grey[300],),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                radius: 86.0,
                                child: CircleAvatar(
                                  radius: 80.0,
                                  backgroundImage: NetworkImage(
                                    model.image!,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80.0),
                                    child: CachedNetworkImage(
                                      height: double.infinity,
                                      width: double.infinity,
                                      imageUrl: model.image!,
                                      placeholder: (context, url) => CircleAvatar(radius: 80.0, backgroundColor: Colors.grey[300],),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          model.name!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          model.bio!,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 14),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      const Text(
                                        '112',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            height: 2),
                                      ),
                                      Text(
                                        'Posts',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      const Text(
                                        '64',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            height: 2),
                                      ),
                                      Text(
                                        'Photos',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      const Text(
                                        '1,763',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            height: 2),
                                      ),
                                      Text(
                                        'Followers',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      const Text(
                                        '753',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            height: 2),
                                      ),
                                      Text(
                                        'Following',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 5.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ImagesScreen()));
                                    },
                                    child: const Text(
                                      'Photos',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                height: 50,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                EditProfileScreen()));
                                  },
                                  child: Icon(
                                    IconBroken.Edit,
                                    color: Theme.of(context).primaryColor,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: InkWell(
                                      onTap: () {
                                        SocialCubit.get(context)
                                            .underLinePosts();
                                      },
                                      child: Column(
                                        children: const [
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                'Posts',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: InkWell(
                                      onTap: () {
                                        SocialCubit.get(context)
                                            .underLinePhotos();
                                      },
                                      child: Column(
                                        children: const [
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                'Photos',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: AnimatedAlign(
                                    curve: Curves.easeInOut,
                                    duration: const Duration(milliseconds: 500),
                                    alignment:
                                        SocialCubit.get(context).underPosts ==
                                                true
                                            ? AlignmentDirectional.centerStart
                                            : AlignmentDirectional.centerEnd,
                                    child: Container(
                                      width: 188,
                                      height: 4,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (SocialCubit.get(context).underPosts == true)
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return buildPost(
                                  SocialCubit.get(context).myPosts[index],
                                  context,
                                  index);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount: SocialCubit.get(context).myPosts.length,
                          ),
                        if (SocialCubit.get(context).underPhotos == true)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              mainAxisExtent: 120,
                            ),
                            itemCount: SocialCubit.get(context).myImages.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ImageDetailsScreen(index)));
                                },
                                child: Hero(
                                  tag: SocialCubit.get(context).myImages[index],
                                  child: CachedNetworkImage(
                                    height: double.infinity,
                                    imageUrl: SocialCubit.get(context).myImages[index],
                                    placeholder: (context, url) => Container(color: Colors.grey[300],),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
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
        margin: const EdgeInsets.all(0.0),
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
                        imageUrl: SocialCubit.get(context).userModel!.image!,
                        placeholder: (context, url) => CircleAvatar(radius: 25.0, backgroundColor: Colors.grey[300],),
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
                                  fontWeight: FontWeight.w600, height: 1.3),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
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
                      placeholder: (context, url) => Container(color: Colors.grey[300],),
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
                              Text('${SocialCubit.get(context).myLikes[index]}',
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
                                '${SocialCubit.get(context).countComments[SocialCubit.get(context).myPostsId[index]]} comment',
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
                            SocialCubit.get(context).myPostsId[index]);
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
                                imageUrl: SocialCubit.get(context).userModel!.image!,
                                placeholder: (context, url) => CircleAvatar(radius: 18.0, backgroundColor: Colors.grey[300],),
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
                            postId: SocialCubit.get(context).myPostsId[index]);
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
                          controller: myCommentController,
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
                                postId:
                                    SocialCubit.get(context).myPostsId[index],
                                dateTime: DateTime.now().toString(),
                                commentText: myCommentController.text,
                              );
                              myCommentController.clear();
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
                imageUrl: SocialCubit.get(context).comments[index].image!,
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
