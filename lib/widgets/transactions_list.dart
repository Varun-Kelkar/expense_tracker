import 'package:flutter/material.dart';
import '../models/transaction.dart';

import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTrans;

  TransactionList(this.transactions,this.deleteTrans);
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        //The below function is called for every element in transactions list
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'No Transactions Yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  //Function returns widget to be rendered for each list element
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text('\$${transactions[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                          DateFormat.yMMMMd().format(transactions[index].date)),
                      trailing: IconButton(icon: 
                                          Icon(Icons.delete,
                                                color: Theme.of(context).errorColor,),
                                                onPressed: ()=>deleteTrans(transactions[index].id)),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
