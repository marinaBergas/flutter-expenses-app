import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
// ignore: prefer_typing_uninitialized_variables
  final List<Transaction> userTransactions;
    final Function deleteTransaction;
  const TransactionList(this.userTransactions,this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return 
        // height: MediaQuery.of(context).size.height*0.6,
        // child:ListView(
        //     children: userTransactions
        //         .map((tx) => Card(
        //             color: Colors.red,
        //             child: Row(
        //               children: [
        //                 Container(
        //                   margin: const EdgeInsets.symmetric(
        //                       vertical: 10, horizontal: 15),
        //                   decoration: BoxDecoration(
        //                       border:
        //                           Border.all(color: Colors.green, width: 2)),
        //                   padding: const EdgeInsets.all(10),
        //                   child: Text(
        //                     '\$${tx.amount.toString()}',
        //                     style: const TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 20,
        //                         color: Colors.purple),
        //                   ),
        //                 ),
        //                 Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text(
        //                       tx.title,
        //                       style: const TextStyle(
        //                           fontWeight: FontWeight.bold, fontSize: 16),
        //                     ),
        //                     Text(
        //                       // DateFormat('yyyy-MM-dd').format(tx.date) ,
        //                       DateFormat.yMMMd().format(tx.date),

        //                       style: const TextStyle(
        //                           color: Colors.grey,
        //                           fontWeight: FontWeight.normal),
        //                     )
        //                   ],
        //                 )
        //               ],
        //             )))
        //         .toList()));
       userTransactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'no transaction added yet !',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(
                    height: 100,
                    child: Image.asset(
                      'assets/images/test.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (tcx, index) {
                  // return Card(
                  //     color: Colors.white,
                  //     child: Row(
                  //       children: [
                  //         Container(
                  //           margin: const EdgeInsets.symmetric(
                  //               vertical: 10, horizontal: 15),
                  //           decoration: BoxDecoration(
                  //               border: Border.all(
                  //                   color: Theme.of(context).primaryColorDark,
                  //                   width: 2)),
                  //           padding: const EdgeInsets.all(10),
                  //           child: Text(
                  //             '\$${userTransactions[index].amount.toStringAsFixed(2)}',
                  //             // style: const TextStyle(
                  //             //     fontWeight: FontWeight.bold,
                  //             //     fontSize: 20,
                  //             //     color: Colors.red),
                  //             // style: Theme.of(context).appBarTheme.titleTextStyle,
                  //             style: Theme.of(context).textTheme.titleSmall,
                  //           ),
                  //         ),
                  //         Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               userTransactions[index].title,
                  //               style: const TextStyle(
                  //                   fontWeight: FontWeight.bold, fontSize: 16),
                  //             ),
                  //             Text(
                  //               // DateFormat('yyyy-MM-dd').format(tx.date) ,
                  //               DateFormat.yMMMd()
                  //                   .format(userTransactions[index].date),

                  //               style: const TextStyle(
                  //                   color: Colors.grey,
                  //                   fontWeight: FontWeight.normal),
                  //             )
                  //           ],
                  //         )
                  //       ],
                  //     ));
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                    child: ListTile(
                        leading: CircleAvatar(
                            radius: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: FittedBox(
                                child: Text(
                                    '\$${userTransactions[index].amount.toStringAsFixed(2)}'),
                              ),
                            )),
                        title: Text(
                          userTransactions[index].title,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),subtitle: Text( DateFormat.yMMMd().format(userTransactions[index].date),),
                        trailing:  IconButton(icon: const Icon(Icons.delete),onPressed: ()=>deleteTransaction(userTransactions[index].id),color: Theme.of(context).colorScheme.error),
                        ),
                  );
                },
                itemCount: userTransactions.length);
  }
}
