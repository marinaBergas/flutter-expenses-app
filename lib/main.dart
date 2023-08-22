// import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {

  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
   runApp(
      MaterialApp(
          title: 'Personal Expenses',
          home: const MyHomePage(),
          theme: ThemeData(
              primarySwatch: Colors.purple,
              fontFamily: 'QuickSand',
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: Colors.green,
                error: Colors.red // Your accent color
              ),
              textTheme: ThemeData.light().textTheme.copyWith(
                  titleSmall: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      backgroundColor: Colors.green),
                      ),
              appBarTheme: const AppBarTheme(
                  titleTextStyle: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
    );
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 static bool _showChart=false;
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 10.98, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'weekly ct', amount: 16.45, date: DateTime.now())
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount,DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

void _deleteTransaction(String id){
setState(() {
  _userTransactions.removeWhere((element) => element.id==id);
});
}
  //  static String? titleInput;
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) => GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addNewTransaction),
            ));
  }



  @override
  Widget build(BuildContext context) {
    final appBar=AppBar(
          title: const Text(
            'Personal Expenses',
            style: TextStyle(fontFamily: 'OpenSans'),
          ),
          actions: [
            IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: const Icon(Icons.add))
          ],
        );
    return Scaffold(
        appBar:appBar ,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(children: [
              const Text('show chart'),
              Switch(value: _showChart, onChanged: (value) {
                setState(() {
                  _showChart=value;
                });
              },)
            ],)
            // const Card(
            //   color: Colors.blue,
            //   elevation: 5,
            //   child: SizedBox(
            //       width: double.infinity,
            //       child: Text(
            //         'chart',
            //         textAlign: TextAlign.center,
            //       )),
            // ),
            // ignore: sized_box_for_whitespace
            ,_showChart?Container(height: (MediaQuery.of(context).size.height - appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.35,child: Chart(_recentTransaction))
            // ignore: sized_box_for_whitespace
           : Container(height: (MediaQuery.of(context).size.height - appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.65,child: TransactionList(_userTransactions,_deleteTransaction))
          ],
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: const Icon(Icons.add),
          
        ),
        
        );
  }
}
