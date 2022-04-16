import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/socialApp/images/image_details/image_details_screen.dart';
import 'package:social_app/socialCubit/cubit.dart';
import 'package:social_app/socialCubit/states.dart';
import 'package:social_app/style/icon_broken.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Photos',
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
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SocialCubit.get(context).myImages.isNotEmpty
              ? SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: GridView.builder(
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
                              imageUrl:
                                  SocialCubit.get(context).myImages[index],
                              placeholder: (context, url) => Container(
                                color: Colors.grey[300],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : const Center(
                  child: Text('No images yet.'),
                ),
        );
      },
    );
  }
}
