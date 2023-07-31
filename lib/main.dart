import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/Helper/loading/loading_screen.dart';
import 'package:hello/constants/routes.dart';

import 'package:hello/providers/models_provider.dart';
import 'package:hello/services/auth/bloc/auth_bloc.dart';
import 'package:hello/services/auth/bloc/auth_event.dart';
import 'package:hello/services/auth/bloc/auth_state.dart';
import 'package:hello/services/auth/firebase_auth_provide.dart';
import 'package:hello/views/forgot_password_view.dart';

import 'package:provider/provider.dart';

import 'providers/chats_provider.dart';

import 'package:hello/views/login_view.dart';

import 'package:hello/views/notes/notes_view.dart';
import 'package:hello/views/otp.dart';
import 'package:hello/views/notes/chat_view.dart';

import 'package:hello/views/phone.dart';
import 'package:hello/views/register_view.dart';
import 'package:hello/views/verify_email_view.dart';

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
      home: BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(FirebaseAuthProvider()),
          child: const HomePage()),
      routes: {
        myphone: (context) => const MyPhone(),
        myverify: (context) => const MyVerify(),

        chatroute: (context) => const ChatView(),
        // profileroute: (context) => const ProfileView(),
      },
    ),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isloading) {
          LoadingScreen().show(
              context: context,
              text: state.loadingText ?? "Please wait a moment...");
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
