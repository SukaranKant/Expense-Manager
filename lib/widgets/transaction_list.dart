import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(
    this.transactions,
    this.deleteTransaction,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No transactions found',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView(
              children: transactions
                  .map((transaction) => Card(
                        margin: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 5,
                        ),
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            child: Padding(
                              padding: EdgeInsets.all(6),
                              child: FittedBox(
                                child: Text(
                                  '\$${transaction.amount}',
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            transaction.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          subtitle: Text(
                            DateFormat.yMMMd().format(transaction.date),
                          ),
                          trailing: IconButton(
                            onPressed: (() =>
                                deleteTransaction(transaction.id)),
                            icon: Icon(
                              Icons.delete,
                            ),
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                      ))
                  .toList(),
            ),
    );
  }
}
