import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction) {
    // ignore: avoid_print
    print('constructor');
  }

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  //constructor-initstate(for first time only)
  //when change in component constructor-didupdate
  //dispose when widget remove
  @override
  void initState() {
    // ignore: avoid_print
    print('initstate');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // ignore: avoid_print
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // ignore: avoid_print
    print('dispose');
    super.dispose();
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final titleEntered = _titleController.text;
    final amountEntered = double.parse(_amountController.text);
    if (titleEntered.isEmpty || amountEntered <= 0 || _selectedDate == null) {
      return;
    }
    widget.addNewTransaction(titleEntered, amountEntered, _selectedDate);
    //to close build context popup
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.purple,
                colorScheme: const ColorScheme.light(primary: Colors.yellow),
                buttonTheme: const ButtonThemeData(
                    textTheme: ButtonTextTheme.primary,
                    buttonColor: Colors.green),
              ),
              child: SizedBox(child: child));
        }).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              right: 10,
              top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // CupertinoTextField(),
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                // onChanged: (value) {
                //   titleInput=value;
                // },
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                // onChanged: (value) {
                //   amountInput=value;
                // },
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(_selectedDate == null
                            ? 'No Date Chosen !'
                            : 'picke Date :${DateFormat.yMd().format(_selectedDate!)}')),
                    TextButton(
                      onPressed: _presentDatePicker,
                      style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).primaryColor),
                      child: const Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              AdaptiveFlatButton(_submitData, 'Add transaction')
            ],
          ),
        ),
      ),
    );
  }
}
