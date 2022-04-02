import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../firebase/firebase_cloud_firestore.dart';
import '../models/User.dart';

class DetailUser extends StatelessWidget {
  DetailUser({Key? key, required this.user}) : super(key: key);
  final User user;
  final controllerUserName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerAddress = TextEditingController();
  final controllerPhoneNumber = TextEditingController();
  final FireStore fireStore = FireStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.nameUser),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
          const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 0),
          child: Card(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: controllerUserName,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(fontSize: 25),
                  decoration: InputDecoration(
                      hintText: user.nameUser,
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
                      hintText: user.email,
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
                      hintText: user.address,
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
                      hintText: "0" + user.phoneNumber.toString(),
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
                            String nameUser = user.nameUser;
                            String email = user.email;
                            String address = user.address;
                            String phone = user.phoneNumber.toString();
                            if (controllerUserName.text.isNotEmpty) {
                              nameUser = controllerUserName.text;
                            }
                            if (controllerEmail.text.isNotEmpty) {
                              email = controllerEmail.text;
                            }
                            if (controllerAddress.text.isNotEmpty) {
                              address = controllerAddress.text;
                            }
                            if (controllerPhoneNumber.text.isNotEmpty) {
                              phone = controllerPhoneNumber.text;
                            }
                            //Khoi tao user moi sau khi edit user
                            User userNew = User(idUser: user.idUser, nameUser: nameUser, email: email, address: address, phoneNumber: int.parse(phone));
                            splitName(controllerUserName.text, userNew);
                            Navigator.pop(context);
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        onPressed: () {
          fireStore.deleteUser(user);
          Navigator.pop(context);
        },
      ),
    );
  }
  splitName(String name, User user) async {
    List<String> splitString = name.split(' ');
    List<String> indexList = [];
    for(int i = 0; i < splitString.length; i ++) {
      for(int j = 0; j <= splitString[i].length + i; j++){
        indexList.add(splitString[i].substring(0,j).toLowerCase());
      }
    }
    fireStore.editUser(user,indexList);
  }
}
