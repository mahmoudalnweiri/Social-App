import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/socialCubit/cubit.dart';
import 'package:social_app/socialCubit/states.dart';
import 'package:social_app/style/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);

  var postTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SocialCubit.get(context).userModel != null
            ? Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Create Post',
                    style: TextStyle(color: Colors.black),
                  ),
                  titleSpacing: 5.0,
                  leading: IconButton(
                    icon: const Icon(
                      IconBroken.Arrow___Left_2,
                      color: Colors.black,
                      size: 28,
                    ),
                    onPressed: () {
                      SocialCubit.get(context).removePostImage();
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (SocialCubit.get(context).postImage == null) {
                          SocialCubit.get(context).createPost(
                              dateTime: DateTime.now().toString(),
                              postText: postTextController.text);
                        } else {
                          SocialCubit.get(context).uploadPostImage(
                            dateTime: DateTime.now().toString(),
                            postText: postTextController.text,
                          );
                        }
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.pop(context);
                      },
                      child: const Text('POST'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                  elevation: 0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: CachedNetworkImage(
                                height: double.infinity,
                                width: double.infinity,
                                imageUrl:
                                    SocialCubit.get(context).userModel!.image!,
                                placeholder: (context, url) => CircleAvatar(
                                  radius: 30.0,
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
                                Text(
                                  SocialCubit.get(context).userModel!.name!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      height: 1.3,
                                      fontSize: 16),
                                ),
                                Text(
                                  'Public',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(height: 1.3, fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(fontSize: 24),
                          controller: postTextController,
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: 'What\'s on your mind?',
                            hintStyle: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w300),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      if (SocialCubit.get(context).postImage != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 250.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  image: DecorationImage(
                                    image: FileImage(
                                        SocialCubit.get(context).postImage!),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            IconButton(
                              splashRadius: 25.0,
                              onPressed: () {
                                SocialCubit.get(context).removePostImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20.0,
                                child: Icon(Icons.close),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                SocialCubit.get(context).getPostImage();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(IconBroken.Image),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('add photo'),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('# tags'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Create Post',
                    style: TextStyle(color: Colors.black),
                  ),
                  titleSpacing: 5.0,
                  leading: IconButton(
                    icon: const Icon(
                      IconBroken.Arrow___Left_2,
                      color: Colors.black,
                      size: 28,
                    ),
                    onPressed: () {
                      SocialCubit.get(context).removePostImage();
                      Navigator.pop(context);
                    },
                  ),
                  elevation: 0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }
}
