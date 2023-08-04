import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({super.key});

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {

  late final LocalAuthentication auth;
  bool _support = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then(
      (bool isSupported) => setState((){
        _support = isSupported;
      })
      );
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if(_support)
            const Text('This device supports biometrics')
        else
            const Text('This device is not supported'),
          
        const Divider(height: 100),

           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             
             children: [
               FloatingActionButton.extended(
                      extendedPadding: EdgeInsets.only(left: 150, right: 150),
                      label: const Text(
                        'Authenticate',
                        style: TextStyle(color: Colors.white),
                      ), // <-- Text
                      backgroundColor: Colors.black,
                      onPressed: _authin,
                    ),
             ],
           ),
          
      ],
    );
  }
  Future<void> _authin() async {
    try {
      bool authinticate = await auth.authenticate(
        localizedReason: 
                'use fingerprint to authenticate',
                options: const AuthenticationOptions(
                  stickyAuth: true,
                  biometricOnly: true,
                )
        );

        print("Authenticated : $authinticate");


      
    } on PlatformException catch (e) {
      print(e);
    }



  }


  Future<void> _getBiometrics() async {
    List<BiometricType> availableBios =
       await auth.getAvailableBiometrics();

    print("List of availableBios : $availableBios");

    if (!mounted){
      return ;
    }
    


  }


}