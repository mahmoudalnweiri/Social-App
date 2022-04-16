import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/login/login_screen.dart';
import 'package:social_app/shared/local/cache_helper.dart';
import 'package:social_app/shared/observer/my_observer.dart';
import 'package:social_app/socialCubit/cubit.dart';
import 'package:social_app/socialCubit/states.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
}

void main() async {
  // بيتأكد إنه كل حاجة هان في الميثود خلصت(جهزت) بعدين بيفتح الأبلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CacheHelper.init();

  final token = await FirebaseMessaging.instance.getToken();

  print(token);

  // foreground FCM
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
  });

  // when click on notification in background
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());
  });

  // background FCM
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Widget? widget;

  var uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = const SocialLayout();
  } else {
    widget = LoginScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(startWidget: widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({this.startWidget, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUser()
            ..getPosts()
            ..getAllUsers(),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'FS-Pro',
            ),
            home: startWidget,
          );
        },
      ),
    );
  }
}
