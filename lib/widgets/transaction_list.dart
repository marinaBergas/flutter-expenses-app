import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/transaction_item.dart';
class TransactionList extends StatelessWidget {
// ignore: prefer_typing_uninitialized_variables
  final List<Transaction> userTransactions;
  final Function deleteTransaction;
  const TransactionList(this.userTransactions, this.deleteTransaction);
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
            ? LayoutBuilder(builder: (ctx, constraint) {
                return Column(
                  children: [
                    Text(
                      'no transaction added yet !',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    // ignore: sized_box_for_whitespace
                    Container(
                      height: constraint.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/test.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                );
              })
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
                  return TransactionItem(userTransaction: userTransactions[index], deleteTransaction: deleteTransaction);
                },
                itemCount: userTransactions.length);
  }
}

