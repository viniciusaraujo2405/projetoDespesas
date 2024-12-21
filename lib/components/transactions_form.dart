import 'package:flutter/material.dart';

class TransactionsForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  @override 

  Widget build(BuildContext context){
    return   Card(
          elevation: 5, 
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Column(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Título',
                    ),
                ),
                TextField(
                  controller : valueController,
                  decoration: InputDecoration(
                    labelText: 'Valor (R\$)',
                    ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text('Nova Transação:'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.purple,
                      ),
                      onPressed: (){
                        print(titleController.text);
                        print(valueController.text);
                      },
                    ),
                  ],
                )
                    ],
              
              
              ),
            ),
          );
           
  }
}