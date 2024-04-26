import 'dart:async';

import 'package:blogs_app/post_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Blogs_Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => home_screen();
}

class home_screen extends State {
  late StreamSubscription<QuerySnapshot> subscription;

  late List<DocumentSnapshot> snapshot = [];

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("blogs");

  final searchFilter = TextEditingController();
  final titleController = TextEditingController();
  final detailsController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        snapshot = datasnapshot.docs;
      });
    });
  }

  PassData(DocumentSnapshot snap) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PostScreen(snapshot: snap),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bloging app",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () => debugPrint("search"),
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                showMyDialog(titleController.text.toString(), detailsController.text.toString());
              }, icon: const Icon(Icons.add))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.purple),
              accountName: Text('Rafay Deswali'),
              accountEmail: Text('rafadeswaliy@gmail.com'),
            ),
            const ListTile(
              title: Text('Fisrt page'),
              leading: Icon(
                Icons.cake,
                color: Colors.purple,
              ),
            ),
            const ListTile(
              title: Text('Second page'),
              leading: Icon(
                Icons.search,
                color: Colors.redAccent,
              ),
            ),
            const ListTile(
              title: Text('Third page'),
              leading: Icon(
                Icons.cached,
                color: Colors.orange,
              ),
            ),
            const ListTile(
              title: Text('Fourth page'),
              leading: Icon(
                Icons.menu,
                color: Colors.green,
              ),
            ),
            const Divider(
              height: 10.0,
              color: Colors.black,
            ),
            ListTile(
              title: const Text('Close'),
              trailing: const Icon(
                Icons.close,
                color: Colors.red,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: searchFilter,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  
                ),
              ),
            ),
          ),

          const SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
            
                itemCount: snapshot.length,
                itemBuilder: (context, index) {
                    final title =snapshot[index]['title'].toString();
                  // ignore: unused_local_variable
                  final id = snapshot[index]['details'].toString();
                  if(searchFilter.text.isEmpty){
                    return Card(
                    elevation: 10.0,
                    margin: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            child: Text(snapshot[index]['title'][0]),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          InkWell(
                            child: Container(
                              width: 260,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot[index]["title"],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    snapshot[index]["details"],
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              PassData(snapshot[index]);
                            },
                          )
                        ],
                      ),
                    ),
                  );
                  }else if(title.toLowerCase().contains(searchFilter.text.toLowerCase())){
                     return Card(
                    elevation: 10.0,
                    margin: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            child: Text(snapshot[index]['title'][0]),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          InkWell(
                            child: Container(
                              width: 260,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot[index]["title"],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    snapshot[index]["details"],
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              PassData(snapshot[index]);
                            },
                          )
                        ],
                      ),
                    ),
                  );
                    

                  }
                  return null;
                }),
          ),
        ],
      ),
    );
  }

 Future<void> showMyDialog(String title, String details) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          width: 300.0,
          height: 355.0,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add Post', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20.0),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: detailsController,
                decoration: const InputDecoration(
                  hintText: 'Enter details',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      String id = DateTime.now().millisecondsSinceEpoch.toString();
                      collectionReference.doc(id).set({
                          'id' : id,
                          'title': titleController.text.toString(),
                          'details' : detailsController.text.toString(),
                      });
                    },
                    child: const Text('Post'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}


}
