import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:api_user/models/User.dart';
import 'package:api_user/firebase/firebase_cloud_firestore.dart';

class AddUser extends StatelessWidget {
  AddUser({Key? key}) : super(key: key);
  final controllerUserName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerAddress = TextEditingController();
  final controllerPhoneNumber = TextEditingController();
  final FireStore fireStore = FireStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0.0),
        child: Column(
          children: [
            TextField(
              controller: controllerUserName,
              keyboardType: TextInputType.name,
              style: const TextStyle(fontSize: 25),
              decoration: InputDecoration(
                  labelText: 'User Name',
                  labelStyle: const TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: controllerEmail,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontSize: 25),
              decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: controllerAddress,
              keyboardType: TextInputType.streetAddress,
              style: const TextStyle(fontSize: 25),
              decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: const TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: controllerPhoneNumber,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(fontSize: 25),
              decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: const TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 25),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28))),
                      onPressed: () {
                        final user = User(
                            nameUser: controllerUserName.text,
                            email: controllerEmail.text,
                            address: controllerAddress.text,
                            phoneNumber: int.parse(controllerPhoneNumber.text)
                        );
                        splitName(controllerUserName.text, user);
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Ham chia nho "name" de tim kiem va tao user
  splitName(String name, User user) async {
    List<String> splitString = name.split(' ');
    List<String> indexList = [];
    for(int i = 0; i < splitString.length; i++) {
      for(int j = 0; j <= splitString[i].length + i; j++){
        indexList.add(splitString[i].substring(0,j).toLowerCase());
      }
    }
    // Tao user
    fireStore.createUser(user,indexList);
  }
}
