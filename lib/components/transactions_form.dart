import 'package:flutter/material.dart';

class TransactionsForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final void Function(String, double) onSubmit;

  TransactionsForm(this.onSubmit);


  _submitForm(){
      final title = titleController.text;
      final value = double.tryParse(valueController.text) ?? 0.0;
      
  
      if(title.isEmpty || value <= 0){
        return;
      }

      onSubmit(title, value);
      }   

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
                  onSubmitted: (value) => _submitForm(),
                  decoration: InputDecoration(
                    labelText: 'Título',
                    ),
                ),
                TextField(
                  controller : valueController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _submitForm(),
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
                      onPressed: _submitForm,
                    ),
                  ],
                )
                    ],
              
              
              ),
            ),
          );
           
  }
}