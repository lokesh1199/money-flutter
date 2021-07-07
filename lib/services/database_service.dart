import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money/models/transaction.dart' as my;

class DatabaseService {
  late CollectionReference _collection;

  late String uid;

  DatabaseService(String uid) {
    this.uid = uid;
    this._collection = FirebaseFirestore.instance.collection(uid);
  }

  Future addTransaction(my.Transaction transaction) async {
    await _collection.doc(_genEpoch()).set({
      'money': transaction.money,
      'description': transaction.description,
      'time': transaction.time,
    });
  }

  String _genEpoch() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  // DateTime _epochToDateTime(int epoch) {
  //   return DateTime.fromMillisecondsSinceEpoch(epoch);
  // }

  List<my.Transaction> _transactionFromQuerySnapShot(QuerySnapshot query) {
    return query.docs.map((e) {
      Map tmp = e.data() as Map;
      return my.Transaction(
        money: tmp['money'],
        description: tmp['description'],
        time: tmp['time'],
      );
    }).toList();
  }

  Stream<List<my.Transaction>> get transcations {
    return _collection.snapshots().map(_transactionFromQuerySnapShot);
  }
}
