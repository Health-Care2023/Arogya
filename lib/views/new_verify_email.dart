import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hello/services/auth/bloc/auth_bloc.dart';
import 'package:hello/services/auth/bloc/auth_event.dart';
import 'package:provider/provider.dart';
//import 'package:hello/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              const Text('Verify your Email', style: TextStyle(fontSize: 25)),
          backgroundColor: Color.fromARGB(255, 5, 14, 82),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            color: Color.fromARGB(255, 243, 246, 243),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'We have already sent a verification email.Please open it and verify your email'),
                Row(
                  children: [
                    Text('If you have not received any email yet,then click '),
                    TextButton(
                      onPressed: () async {
                        context
                            .read<AuthBloc>()
                            .add(const AuthEventSendEmailVerification());
                      },
                      child: const Text(
                        'here to resend email',
                        style: TextStyle(
                          color: Color.fromARGB(255, 247, 35, 28),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // FloatingActionButton.extended(
                //   extendedPadding: EdgeInsets.only(left: 150, right: 150),
                //   label: const Text('Resend email Verification',
                //   style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.923))),
                //   backgroundColor: Color.fromARGB(255, 248, 249, 248),
                //   onPressed: () async {
                //     context
                //         .read<AuthBloc>()
                //         .add(const AuthEventSendEmailVerification());
                //   },
                // ),
                FloatingActionButton.extended(
                  extendedPadding: EdgeInsets.only(left: 150, right: 150),
                  label: const Text('Restart',
                      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.923))),
                  backgroundColor: Color.fromARGB(255, 248, 249, 248),
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
