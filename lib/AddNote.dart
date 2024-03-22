import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6/HomeScreen.dart';
import 'package:flutter_application_6/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './model.dart';


  class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  TextEditingController tittle=TextEditingController();
  TextEditingController description=TextEditingController();
  List<Note>list=[];
  late SharedPreferences sharedPreferences;
  getdata()async{
    sharedPreferences=await SharedPreferences.getInstance();
  List<String>? stringlist=sharedPreferences.getStringList('list');
  if(stringlist != Null){
    list=stringlist!.map((item) => Note.FromNap(json.decode(item))).toList();
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
      appBar: AppBar(title: Text("Add Note"),backgroundColor: Colors.blue,centerTitle: true,),

      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 50,horizontal: 50),
            height: 400,
            width: double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue,width: 2)),
             child:  Column(
              children: [
                TextField(
                  controller: tittle,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                  decoration: const InputDecoration(
                    hintText: "Tittle",
                    border: InputBorder.none
                  ),


                ),
               TextField(
                controller: description,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Description",
                    border: InputBorder.none
                    
                  ),


                ),

               
              ],
             ),
          ),
           ElevatedButton(onPressed: (){
               list.add(Note(title: tittle.text, description: description.text));
               List<String>stringlist=list.map((item) => json.encode(item.tomap())).toList();
               sharedPreferences.setStringList("list", stringlist);
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
               

           }, child: Text('Save'))
        ],
      ),
    );
  }
}