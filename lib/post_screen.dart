import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class PostScreen extends StatefulWidget {
   final DocumentSnapshot snapshot;
  PostScreen({required this.snapshot});
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Card(
        elevation: 10.0,
        margin: EdgeInsets.all(10.0),

        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        child: Text(widget.snapshot["title"][0]),
                      ),
                
                      const SizedBox (
                        width: 10.0,
                      ),
                
                      Container(
                        width: 260,
                        child: Text(widget.snapshot["title"], 
                                style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
                                maxLines: 3,
                                ),
                      ),
                
                    ],
                  ),
                  
                ),

                Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text(widget.snapshot["details"], style: const TextStyle(fontSize: 15.0),),
                      )
              ],
            );
           
          },
          
        ),
      ),
    );
  }
}
