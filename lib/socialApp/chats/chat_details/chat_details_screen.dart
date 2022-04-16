import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/socialCubit/cubit.dart';
import 'package:social_app/socialCubit/states.dart';
import 'package:social_app/style/icon_broken.dart';

class ChatDetailsScreen extends StatefulWidget {
  UserModel? userModel;

  ChatDetailsScreen(this.userModel, {Key? key}) : super(key: key);

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  var messageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageController.dispose();
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 15.0,
                  backgroundImage: NetworkImage(widget.userModel!.image!),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: CachedNetworkImage(
                      height: double.infinity,
                      width: double.infinity,
                      imageUrl: widget.userModel!.image!,
                      placeholder: (context, url) => CircleAvatar(
                        radius: 15.0,
                        backgroundColor: Colors.grey[300],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  widget.userModel!.name!,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                )
              ],
            ),
            titleSpacing: 5.0,
            leading: IconButton(
              icon: const Icon(
                IconBroken.Arrow___Left_2,
                color: Colors.black,
                size: 28,
              ),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                messageController.clear();
                SocialCubit.get(context).currentMessage = '';
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (SocialCubit.get(context).messages.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      reverse: true,
                      itemCount: SocialCubit.get(context).messages.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                      itemBuilder: (context, index) {
                        return SocialCubit.get(context)
                                    .messages[index]
                                    .senderId ==
                                SocialCubit.get(context).userModel!.uId
                            ? buildMyMessage(
                                SocialCubit.get(context).messages[index], index)
                            : buildMessage(
                                SocialCubit.get(context).messages[index],
                                index);
                      },
                    ),
                  ),
                if (SocialCubit.get(context).messages.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text('No messages yet'),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40.0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                            controller: messageController,
                            onChanged: (String value) {
                              if (!RegExp(r'^[ ]*$').hasMatch(value)) {
                                SocialCubit.get(context)
                                    .enableMessageButton(message: value);
                              } else {
                                SocialCubit.get(context)
                                    .unableMessageButton(message: value);
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Message',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: IconButton(
                        color: Theme.of(context).primaryColor,
                        splashRadius: 20,
                        onPressed: SocialCubit.get(context).currentMessage == ''
                            ? null
                            : () {
                                SocialCubit.get(context).sendMessage(
                                  receiverId: widget.userModel!.uId!,
                                  dateTime: DateTime.now().toString(),
                                  messageText: messageController.text,
                                );
                                SocialCubit.get(context).currentMessage = '';
                                messageController.clear();
                              },
                        icon: const Icon(IconBroken.Send),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Align buildMyMessage(MessageModel messageModel, int index) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            bottomStart: Radius.circular(10.0),
          ),
        ),
        child: Text(
          messageModel.messageText!,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Align buildMessage(MessageModel messageModel, int index) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            bottomEnd: Radius.circular(10.0),
          ),
        ),
        child: Text(
          messageModel.messageText!,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
