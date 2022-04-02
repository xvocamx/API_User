import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:api_user/Screen/AddUser.dart';
import 'package:api_user/Screen/DetailUser.dart';
import '../models/User.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controllerSearch = TextEditingController();
  String searchString = "";

  final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('API User')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 10),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value.toLowerCase();
                });
              },
              controller: controllerSearch,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(26.0))
                  )
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: (searchString == null || searchString.trim() == '')
                  ? _userStream :
              FirebaseFirestore.instance.collection('users').where('searchIndex', arrayContains: searchString).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("something is wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<
                        String,
                        dynamic>;
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                            ),
                            elevation: 16,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(data['nameUser']),
                                subtitle: Text(data['email']),
                              ),
                            ),
                          ),
                          onTap: () {
                            User user = User(idUser: data['idUser'],
                                nameUser: data['nameUser'],
                                email: data['email'],
                                address: data['address'],
                                phoneNumber: data['phoneNumber']);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailUser(user: user)));
                          },
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddUser()));
        },
      ),
    );
  }
}
