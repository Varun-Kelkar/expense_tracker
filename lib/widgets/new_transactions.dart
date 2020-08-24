//Custom Widget designed to handle new transactions
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;

  NewTransactions(this.addTx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleInput = TextEditingController();
  final _amountInput = TextEditingController();
  DateTime _selectedDate;
  void _submitData() {
    if (_amountInput == null) return;
    final String _enteredTitle = _titleInput.text;
    final double _enteredAmount = double.parse(_amountInput.text);
    //data validation
    if (_enteredTitle.isEmpty || _enteredAmount <= 0 || _selectedDate == null)
      return;

    //widget object : Used to access properties of Widget class inside State class
    widget.addTx(_enteredTitle, _enteredAmount,_selectedDate);

    //Closes Modal Bottom Sheet after data is input and submitted
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((datePicked) {
      if (datePicked == null) return;
      setState(() {
        _selectedDate = datePicked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleInput,
                onSubmitted: (_) => _submitData()),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountInput,
              //only numeric keyboard appears
              keyboardType: TextInputType.number,
              //'_' indicates arguement is received but ignored
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Choosen!!'
                        : 'Picked Date : ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Select Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              onPressed: _submitData,
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            )
          ],
        ),
      ),
    );
  }
}
