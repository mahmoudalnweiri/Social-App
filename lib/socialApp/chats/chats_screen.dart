import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/socialApp/chats/chat_details/chat_details_screen.dart';
import 'package:social_app/socialCubit/cubit.dart';
import 'package:social_app/socialCubit/states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SocialCubit.get(context).users.isNotEmpty
            ? ListView.separated(
                itemCount: SocialCubit.get(context).users.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                itemBuilder: (context, index) {
                  return buildChatItem(
                      context, SocialCubit.get(context).users[index]);
                },
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildChatItem(BuildContext context, UserModel model) {
    return InkWell(
      onTap: () {
        SocialCubit.get(context).getMessage(receiverId: model.uId!);
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsScreen(model)));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: CachedNetworkImage(
                  height: double.infinity,
                  width: double.infinity,
                  imageUrl: model.image!,
                  placeholder: (context, url) => CircleAvatar(radius: 25.0, backgroundColor: Colors.grey[300],),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              model.name!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
