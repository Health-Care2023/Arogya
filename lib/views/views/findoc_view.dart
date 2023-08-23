import 'package:flutter/material.dart';

class FindocView extends StatefulWidget {
  const FindocView({super.key});

  @override
  State<FindocView> createState() => _FindocViewState();
}

class _FindocViewState extends State<FindocView> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find a Doctor", style: TextStyle(fontSize: 25)),
        backgroundColor: Color.fromARGB(255, 5, 14, 82),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white, // Set the background color to blue
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    // The text field
                    decoration: InputDecoration.collapsed(
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 5, 14,
                              82)), // Set the hint text color to white
                    ),
                    style: TextStyle(
                        color: Color.fromARGB(
                            255, 5, 14, 82)), // Set the text color to white
                  ),
                ),
                IconButton(
                  // The search icon button
                  icon: Icon(Icons.search),
                  color: Color.fromARGB(255, 5, 14, 82),
                  onPressed: () {
                    // Handle search action here
                    // You can add your search logic or navigation to a search screen.
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
