import 'package:flutter/material.dart';
import '../utils/utils.dart';

class HistoryCell extends StatelessWidget {
  final dynamic data;

  const HistoryCell({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        // Set the background color of each cell
        color: Colors.transparent,
        padding: const EdgeInsets.all(12.0),
        child:  Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Actual Amount:",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight:FontWeight.bold),
                ),
                Text(
                  Utility.instance.formatAmount(data["actual_amount"]),
                  style: const TextStyle(fontSize: 18.0, color: Colors.green,fontWeight:FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Profit Gain:",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight:FontWeight.bold),
                ),
                Text(
                Utility.instance.formatAmount(data["profit"]),
                  style: const TextStyle(fontSize: 18.0, color: Colors.green,fontWeight:FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Periods:",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight:FontWeight.bold),
                ),
                Text(
                  "${data["periods"]} Years",
                  style: const TextStyle(fontSize: 18.0, color: Colors.green),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Rate Of Return:",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight:FontWeight.bold),
                ),
                Text(
                  "${data["rate_of_return"]}%",
                  style: const TextStyle(fontSize: 18.0, color: Colors.green),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Times Rolled:",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight:FontWeight.bold),
                ),
                Text(
                  "${data["times_rolled"]}",
                  style: const TextStyle(fontSize: 18.0, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}