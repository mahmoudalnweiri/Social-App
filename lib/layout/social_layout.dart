import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/socialApp/newPost/New_Post_Screen.dart';
import 'package:social_app/socialApp/shimmerLoading/shimmer_loading_screen.dart';
import 'package:social_app/socialCubit/cubit.dart';
import 'package:social_app/socialCubit/states.dart';
import 'package:social_app/style/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => NewPostScreen()));
        }
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);

        return SocialCubit.get(context).posts == null || SocialCubit.get(context).userModel == null
            ? const ShimmerLoadingScreen()
            : SocialCubit.get(context).posts!.isNotEmpty? Scaffold(
                appBar: AppBar(
                  title: Text(
                    cubit.pages['title'][cubit.currentIndex],
                    style: const TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 0,
                ),
                body: Center(
                  child: cubit.pages['screen'][cubit.currentIndex],
                ),
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: BottomNavigationBar(
                    onTap: (index) {
                      cubit.changeBottomNav(index);
                    },
                    unselectedItemColor: Colors.black,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: cubit.currentIndex,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 20.0,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(IconBroken.Home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(IconBroken.Notification),
                        label: 'Notification',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(IconBroken.Plus),
                        label: 'Post',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(IconBroken.Chat),
                        label: 'Chats',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(IconBroken.Profile),
                        label: 'Profile',
                      ),
                    ],
                  ),
                ),
              ) : const ShimmerLoadingScreen();
      },
    );
  }
}
