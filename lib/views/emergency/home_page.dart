import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:hello/constants/routes.dart';
class HomePage extends StatefulWidget {
  final Function appointment;
  const HomePage({Key? key, required this.appointment}):super(key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width) * (0.45),
              height: (MediaQuery.of(context).size.height) * (0.15),
              child: FloatingActionButton.extended(
                //  extendedPadding: EdgeInsets.only(left: 1, right: 1),
                label: const Text(
                  'Find a doctor',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ), // <-- Text
                backgroundColor: Color.fromARGB(255, 229, 230, 234),
                icon: new Icon(FontAwesomeIcons.stethoscope),
                onPressed: () {
                widget.appointment();
                }
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: (MediaQuery.of(context).size.width) * (0.45),
              height: (MediaQuery.of(context).size.height) * (0.15),
              child: FloatingActionButton.extended(
                //  extendedPadding: EdgeInsets.only(left: 1, right: 1),
                label: const Text(
                  'Medical History',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ), // <-- Text
                backgroundColor: Color.fromARGB(255, 229, 230, 234),
                icon: new Icon(FontAwesomeIcons.bookMedical),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    prescription,
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(children: [
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: (MediaQuery.of(context).size.width) * (0.45),
            height: (MediaQuery.of(context).size.height) * (0.15),
            child: FloatingActionButton.extended(
              //  extendedPadding: EdgeInsets.only(left: 1, right: 1),
              label: const Text(
                'Blood Group',
                style: TextStyle(fontWeight: FontWeight.bold),
              ), // <-- Text
              backgroundColor: const Color.fromARGB(255, 229, 230, 234),
              icon: const Icon(
                FontAwesomeIcons.droplet,
                color: Color.fromARGB(255, 209, 51, 39),
              ),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: (MediaQuery.of(context).size.width) * (0.45),
            height: (MediaQuery.of(context).size.height) * (0.15),
            child: FloatingActionButton.extended(
              //  extendedPadding: EdgeInsets.only(left: 1, right: 1),
              label: const Text(
                'Tele-Medicine',
                style: TextStyle(fontWeight: FontWeight.bold),
              ), // <-- Text
              backgroundColor: Color.fromARGB(255, 229, 230, 234),
              icon: new Icon(FontAwesomeIcons.phone),
              onPressed: () {},
            ),
          ),
        ]),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 16, top: 10),
          child: ImageSlideshow(
            width: double.infinity,

            /// Height of the [ImageSlideshow].
            height: (MediaQuery.of(context).size.height) * 0.47,

            /// The page to show when first creating the [ImageSlideshow].
            initialPage: 0,

            /// The color to paint the indicator.
            indicatorColor: Colors.blue,

            /// The color to paint behind th indicator.
            indicatorBackgroundColor: Colors.grey,

            /// The widgets to display in the [ImageSlideshow].
            /// Add the sample image file into the images folder
            children: [
              Image.asset(
                'asset/dept_of_health.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'asset/improving-healthcare-west-bengal-medium-term-expenditure-framework_6.jpeg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'asset/Swasthya sathi 2.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'asset/Swasthya sathi.jpg',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'asset/West-Bengal-Health-Scheme.jpg',
                fit: BoxFit.cover,
              ),
            ],

            /// Called whenever the page in the center of the viewport changes.
            onPageChanged: (value) {
              print('Page changed: $value');
            },

            /// Auto scroll interval.
            /// Do not auto scroll with null or 0.
            autoPlayInterval: 1000,

            /// Loops back to first slide.
            isLoop: true,
            // alignment: Alignment.center,
            // child: const Text('Home', style: TextStyle(fontSize: 30)),
          ),
        ),
      ],
    );
  }
}
