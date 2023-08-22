import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;
  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('${spendingPctOfTotal}sss');
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: <Widget>[
          // ignore: sized_box_for_whitespace
          Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
          // const SizedBox(
          //   height: 4,
          // ),
          // ignore: sized_box_for_whitespace
          Container(
            height: constraint.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: const Color.fromARGB(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )
              ],
            ),
          ),
           SizedBox(
            height:constraint.maxHeight*0.1,
          ),
          // ignore: sized_box_for_whitespace
          Container(height:constraint.maxHeight*0.15 ,child: FittedBox(child: Text(label)))
        ],
      );
    });
  }
}
