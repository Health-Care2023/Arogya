import 'package:flutter/material.dart';
import 'package:hello/constants/routes.dart';
import 'package:hello/services/auth/auth_service.dart';

import 'package:hello/providers/models_provider.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';
import 'providers/chats_provider.dart';

import 'package:hello/views/login_view.dart';
import 'package:hello/views/notes/new_notes_view.dart';
import 'package:hello/views/notes/notes_view.dart';
import 'package:hello/views/otp.dart';
import 'package:hello/views/notes/chat_view.dart';
import 'package:hello/views/phone.dart';
import 'package:hello/views/register_view.dart';
import 'package:hello/views/verify_email_view.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ModelsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ChatProvider(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 48, 143, 221)),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        loginroute: (context) => const LoginView(),
        registerroute: (context) => const RegisterView(),
        notesroute: (context) => const NotesView(),
        myphone: (context) => const MyPhone(),
        myverify: (context) => const MyVerify(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        newNotesRoute: (context) => const NewNotesView(),
        chatroute: (context) => const ChatView(),
      },
    ),
  )
      // MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   title: 'Flutter Demo',
      //   theme: ThemeData(
      //     colorScheme:
      //         ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 48, 143, 221)),
      //     useMaterial3: true,
      //   ),
      //   home: const HomePage(),
      //   routes: {
      //     loginroute: (context) => const LoginView(),
      //     registerroute: (context) => const RegisterView(),
      //     notesroute: (context) => const NotesView(),
      //     myphone: (context) => const MyPhone(),
      //     myverify: (context) => const MyVerify(),
      //     verifyEmailRoute: (context) => const VerifyEmailView(),
      //     newNotesRoute: (context) => const NewNotesView(),
      //     chatroute: (context) => const ChatView(),
      //   },
      // ),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Authservice.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = Authservice.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          // final sol = user?.emailVerified ?? false;
          // if (sol) {
          //   print("The User is verified");
          //   return const Text('Done');
          // } else {
          //   print("Not Verified");
          //   return const VerifyEmailView();
          // }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
