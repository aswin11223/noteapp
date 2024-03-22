import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './AddNote.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> list = [];
  late SharedPreferences sharedPreferences;
  getdata() async {
    sharedPreferences = await SharedPreferences.getInstance();
    List<String>? stringlist = sharedPreferences.getStringList("list");
    print(stringlist);
    if (stringlist != Null) {
      setState(() {
        list =
            stringlist!.map((item) => Note.FromNap(json.decode(item))).toList();
      });
    }
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async {
          String refreh = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyWidget()));

          if (refreh == "loaddat") {
            setState(() {
              getdata();
            });
          }
        },
        child: Icon(Icons.add,),backgroundColor: Colors.blueAccent,
        
        ),
        
        body:
        Column(children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Text("Notes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.blue),),
            ),
             SizedBox(height: 10,),
         list.isEmpty
            ? const Center(
                child: Text("is empty"),
              )
            : Expanded(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          leading: CircleAvatar(
                            child: Text("$index"),
                          ),
                          title: Text(list[index].title),
                          subtitle: Text(list[index].description),
                          trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  list.remove(list[index]);
                                  
                    
                                   sharedPreferences.remove('list');
                                
                                  
                                });
                              },
                              icon: Icon(Icons.delete)));
                    })
                    )
        ]
                    ),
                    
    );
  }
}
