import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/socialCubit/cubit.dart';
import 'package:social_app/socialCubit/states.dart';
import 'package:social_app/style/icon_broken.dart';

class ImageDetailsScreen extends StatelessWidget {
  final int? imageIndex;

  ImageDetailsScreen(this.imageIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                IconBroken.Arrow___Left_2,
                size: 28,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.black87,
            elevation: 0,
          ),
          backgroundColor: Colors.black87,
          body: SafeArea(
            child: Center(
              child: Hero(
                tag: SocialCubit.get(context).myImages[imageIndex!],
                child: CachedNetworkImage(
                  imageUrl: SocialCubit.get(context).myImages[imageIndex!],
                  progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                      ),
                    ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
