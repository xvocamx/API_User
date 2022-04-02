import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:api_user/models/User.dart';

class FireStore {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //Ham tao user va day user len cloud firestore
  Future createUser(User user, List<String> indexList) async {
    final docUser = _firebaseFirestore.collection('users').doc();
    user.idUser = docUser.id;
    user.searchIndex = indexList;
    final json = user.toJson();
    await docUser.set(json);
  }

  Future editUser(User user, List<String> indexList) async {
    final docUser = _firebaseFirestore.collection('users').doc(user.idUser);
    user.searchIndex = indexList;
    final json = user.toJson();
    await docUser.update(json);
  }

  Future deleteUser(User user) async {
    final docUser = _firebaseFirestore.collection('users').doc(user.idUser);
    await docUser.delete();
  }
}
