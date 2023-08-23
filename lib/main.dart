// import 'package:flutter/services.dart';

// ignore_for_file: sized_box_for_whitespace
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

import './models/transaction.dart';

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
                secondary: Colors.green, error: Colors.red // Your accent color
                ),
            textTheme: ThemeData.light().textTheme.copyWith(
                  titleSmall: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                      ),
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
  static bool _showChart = false;
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

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
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
  List<Widget> _buildLandscapeWidget(MediaQueryData mediaQuery,AppBar appBar,Widget txListWidget){
     return [Row(
      mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text('show chart',style: Theme.of(context).textTheme.titleSmall),
              Switch.adaptive(
                activeColor: Theme.of(context).colorScheme.secondary,
                value: _showChart,
                onChanged: (value) {
                  setState(() {
                    _showChart = value;
                  });
                },
              )
            ],
          ),_showChart
              ? Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.7,
                  child: Chart(_recentTransaction))
              : txListWidget];
  }

 List<Widget> _buildPortraitContent(MediaQueryData mediaQuery,AppBar appBar,Widget txListWidget){
       return  [Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.3,
              child: Chart(_recentTransaction)),txListWidget];
  }

  Widget _buildAppBarContent(){
return Platform.isIOS
        ?  CupertinoNavigationBar(
            middle:const Text(
              'Personal Expenses',
              style: TextStyle(fontFamily: 'OpenSans'),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // IconButton(
                //   icon:const Icon(Icons.add),
                //   onPressed: () => _startAddNewTransaction(context),
                // )
                GestureDetector(onTap:  () => _startAddNewTransaction(context),child: 
               const Icon(CupertinoIcons.add),)
              ],
            ),
          )
        : AppBar(
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
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final  appBar =_buildAppBarContent();

    final txListWidget = Container(
        height: (mediaQuery.size.height -
                (appBar as PreferredSizeWidget).preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    final pageBody = SafeArea(child:  SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (isLandscape)..._buildLandscapeWidget(mediaQuery,(appBar as AppBar),txListWidget),
        
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
        
        if (!isLandscape)..._buildPortraitContent(mediaQuery,(appBar as AppBar),txListWidget),
          
      ],
    )));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: (appBar as ObstructingPreferredSizeWidget),
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransaction(context),
                    child: const Icon(Icons.add),
                  ),
          );
  }
}
