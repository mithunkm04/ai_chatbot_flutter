import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController promptcon = TextEditingController();
  List<Map<String, dynamic>> messagelist = [];
  Future<void> sendmsg(String usermsg) async {
    setState(() {
      messagelist.add({"role": "user", "text": usermsg});
    });
    final uri = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyA8xYbJSHMKxYFyBYJb8ZitL-661U8blW4",
    );
    final headers = {'Content-Type':'application/jason'};
    final body =jsonEncode({
      "contents": [
      {
        "parts": [
          {
            "text": usermsg
          },
        ]
      }
    ]
    });
    try{
      final response=await http.post(uri,headers:headers,body :body);
      if(response.statusCode==200){
        final data = jsonDecode(response.body);
        final botReplay= data['candidates'][0]['content']['parts'][0]['text'];
        setState(() {
          messagelist.add({'role':'bot','text':botReplay});
        });
      }else{
        setState(() {
          messagelist.add({'role':'bot','text':'something went wrong,please try again later'});
        });
      }

    }catch(e){
      setState(() {
        messagelist.add({'role':'bot','text':'Error:$e'});
      });

    }
    finally{
      setState(() {
        promptcon.clear();
      });
    }
  }

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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messagelist.length,
              itemBuilder: (context, index) =>
                  messagebox(messagelist.toList()[index]),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(height: 45,
                    child: TextField(
                      controller: promptcon,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Ask anything",
                        hintStyle: TextStyle(color: Colors.black),
                      
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),IconButton(
                          onPressed:(){
                            sendmsg(promptcon.text.trim());
                          },
                          icon: Icon(Icons.send, color: Colors.black),
                        ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget messagebox(Map<String, dynamic> textmsg) {
    bool isuser = textmsg["role"] == "user";
    return Align(
      alignment: isuser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: EdgeInsets.all(10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isuser ? Colors.grey : Colors.blueGrey,
        ),
        child: Text(
          textmsg['text'] ?? '',
          style: TextStyle(color: isuser ? Colors.white : Colors.grey),
        ),
      ),
    );
  }
}
