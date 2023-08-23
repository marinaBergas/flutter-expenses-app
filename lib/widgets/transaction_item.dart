import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.userTransaction,
    required this.deleteTransaction,
  });

  final Transaction userTransaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin:
          const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: FittedBox(
                child: Text(
                    '\$${userTransaction.amount.toStringAsFixed(2)}'),
              ),
            )),
        title: Text(
          userTransaction.title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(userTransaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton.icon(
                onPressed: () =>
                    deleteTransaction(userTransaction.id),
                style: TextButton.styleFrom(
                    foregroundColor:
                        Theme.of(context).colorScheme.error),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () =>
                    deleteTransaction(userTransaction.id),
                color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}
