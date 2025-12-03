import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 203, 203),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 86, 82, 82),
        title: Text(
          "Chat Bot",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: 
      Column(mainAxisAlignment: MainAxisAlignment.end,
        children: [const Expanded(child: Center(child: Text("What can i help with?",style: TextStyle(fontSize: 35,))),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "Ask anything",
                hintStyle: TextStyle(color: Colors.black),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send, color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
