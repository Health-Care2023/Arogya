// import 'dart:html';

import 'package:background_sms/background_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({super.key});

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}
String snackbarMessage = "";
class _EmergencyPageState extends State<EmergencyPage> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  Position? _currentPosition;
  String? _currentAddress;
  LocationPermission? permission;
  _getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      Fluttertoast.showToast(msg: "Permissions denied");
      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(msg: "Permissions denied Forever");
      }
    } else {
      final position = await _geolocatorPlatform.getLastKnownPosition();
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLon();
      });
      print(_currentAddress);
    }
  }

  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.locality},${place.postalCode},${place.street}";
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  _getPermissions() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;

  late final LocalAuthentication auth;
  bool _support = false;

  @override
  void initState() {
    _isPermissionGranted();
    // TODO: implement initState
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          _support = isSupported;
        }));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //Optional it is written for testing purpose
      children: <Widget>[
        // if (_support)
        //   const Text('This device supports biometrics')
        // else
        //   const Text('This device is not supported'),

        //  const Divider(height: 100),
        Container(
          margin: EdgeInsets.only(
              left: 20,
              right: 20,
              top: (MediaQuery.of(context).size.height) * 0.40),
          child: FloatingActionButton.extended(
            extendedPadding: const EdgeInsets.only(left: 120, right: 120),
            label: const Text(
              'Authenticate',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            icon: const Icon(
              FontAwesomeIcons.fingerprint,
              color: Colors.black,
            ), // <-- Text
            backgroundColor: const Color.fromARGB(255, 8, 100, 176),
            onPressed: () async {
              _authin();
              await _getCurrentLocation();
            },
          ),
        )
      ],
    );
  }

  Future<void> _authin() async {
    try {
      bool authinticate = await auth.authenticate(
          localizedReason: 'use fingerprint to authenticate',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));
      if (authinticate) {
        final action = await showConfirmDialog(
            context, _currentPosition, _currentAddress);
        print("Confirm Action $action");
      }
      print("Authenticated : $authinticate");
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _getBiometrics() async {
    List<BiometricType> availableBios = await auth.getAvailableBiometrics();
    print("List of availableBios : $availableBios");
    if (!mounted) {
      return;
    }
  }
}

// enum ConfirmAction { Cancel, Accept }

_sendSms(String phoneNumber, String message, {int? simSlot}) async {
  await BackgroundSms.sendMessage(
    phoneNumber: phoneNumber,
    message: message,
  ).then((SmsStatus status) {
    if (status == SmsStatus.sent) {
      // Fluttertoast.showToast(msg: "sent");
      snackbarMessage = "Message has been sent";
    } else {
      // Fluttertoast.showToast(msg: "failed to send message ${status}");
      snackbarMessage = "failed to send message ${status}";
    }
  });
}

// Future<ConfirmAction?> _asyncConfirmDialog(BuildContext context,
//     Position? _currentPosition, String? _currentAddress) async {
//   return showDialog<ConfirmAction>(
//     context: context,
//     barrierDismissible: false, // user must tap button for close dialog!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Are you sure to access the emergency sevices?',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             )),
//         content: const Text(
//             'If the emergency service is activated for fun,then actions will be taken according to the terms and conditions.\nPress cancel to return back to the page',
//             style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             )),
//         actions: <Widget>[
//           ElevatedButton(
//             child: const Text('Cancel',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 )),
//             onPressed: () {
//               Navigator.of(context).pop(ConfirmAction.Cancel);
//             },
//           ),
//           ElevatedButton(
//             child: const Text('Ok',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 )),
//             onPressed: () async {
//               String message =
//                   "https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}";
//               _sendSms("8335998335", " Please Help I am at: $message ");
//               Navigator.of(context).pop(ConfirmAction.Accept);
//             },
//           )
//         ],
//       );
//     },
//   );
// }
Future<bool> showConfirmDialog(BuildContext context, Position? _currentPosition, String? _currentAddress) {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (context) {
      return AlertDialog(
         title: const Text('Are you sure to access the emergency sevices?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        content: const Text('If the emergency service is activated for fun,then actions will be taken according to the terms and conditions.\nPress cancel to return back to the page',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        actions: [
           ElevatedButton(
            child: const Text('Ok',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            onPressed: () async {
                 String message = "https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}";
              _sendSms("8017285383", " Please Help I am at: $message ");
               // Show the loading popup for 3 seconds
               showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Row(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 10),
                              Text("Sending the message...",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                            ],
                          ),
                        );
                      },
                    );
                    await Future.delayed(const Duration(seconds: 1));
                     IconData iconData = snackbarMessage == "Message has been sent"
                      ? Icons.check_circle_outline
                      : Icons.close;
                      Color iconColour = snackbarMessage == "Message has been sent"
                      ? Colors.green
                      : Colors.red;
                     ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                          backgroundColor: Colors.white ,
                          content: Container(
                            // margin: EdgeInsets.only(
                            // bottom: (MediaQuery.of(context).size.height) * 0.50),
                            alignment: Alignment.center,
                            height: (MediaQuery.of(context).size.height) * 0.10,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(iconData,
                                      color: iconColour,
                                      size: 35.0,), // Custom tick icon
                                  SizedBox(width: 10), // Spacing between icon and text
                                  Text(
                                   snackbarMessage,
                                    style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    )
                                  ),
                                ],
                              ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: iconColour, width: 2),
                          ),
                          duration: Duration(
                              seconds: 1), // Adjust the duration as needed
                        ),
                      );
              // Navigator.of(context).pop(true);
               Navigator.of(context).pop(true);
              Navigator.of(context).pop(true);
            },
          ),
          ElevatedButton(
            child: const Text('Cancel',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
<<<<<<< HEAD
          ElevatedButton(
            child: const Text('Ok',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            onPressed: () async {
              String message =
                  "https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}";
              _sendSms("8335998335", " Please Help I am at: $message ");
              Navigator.of(context).pop(ConfirmAction.Accept);
            },
          )
=======
>>>>>>> 1e01e201ad91600b51433ded722d0bc17f1541cd
        ],
      );
    },
  ).then((value) => value ?? false);
}

