import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions, {Key? key}) : super(key: key);

  // Função para calcular o número da semana no mês
  int getWeekOfMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final daysDiff = date.difference(firstDayOfMonth).inDays;
    return (daysDiff / 7).floor() + 1; // Calcula a semana baseado nos dias do mês
  }

  List<Map<String, Object>> get groupedTransactions {
    // Inicializar os valores das semanas
    List<Map<String, Object>> weeklyData = [
      {'weekLabel': 'Semana 1', 'totalSum': 0.0},
      {'weekLabel': 'Semana 2', 'totalSum': 0.0},
      {'weekLabel': 'Semana 3', 'totalSum': 0.0},
      {'weekLabel': 'Semana 4', 'totalSum': 0.0},
    ];

    // Iterar sobre as transações recentes
    for (var transaction in recentTransactions) {
      int weekOfMonth = getWeekOfMonth(transaction.date);
      print("Transação: ${transaction.title}, Data: ${transaction.date}, Semana: $weekOfMonth, Valor: ${transaction.value}");

      if (weekOfMonth == 1) {
        weeklyData[0]['totalSum'] = (weeklyData[0]['totalSum'] as double) + transaction.value;
      } else if (weekOfMonth == 2) {
        weeklyData[1]['totalSum'] = (weeklyData[1]['totalSum'] as double) + transaction.value;
      } else if (weekOfMonth == 3) {
        weeklyData[2]['totalSum'] = (weeklyData[2]['totalSum'] as double) + transaction.value;
      } else if (weekOfMonth == 4) {
        weeklyData[3]['totalSum'] = (weeklyData[3]['totalSum'] as double) + transaction.value;
      }
    }

    return weeklyData;
  }

  double get totalSpending {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + (item['totalSum'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Total Gasto: R\$${totalSpending.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactions.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: data['weekLabel'] as String,
                    value: data['totalSum'] as double,
                    percentage: totalSpending == 0.0
                        ? 0.0
                        : (data['totalSum'] as double) / totalSpending,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
