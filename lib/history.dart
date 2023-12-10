import 'package:flutter/material.dart';
import 'package:sippy/components/app_theme.dart';
import 'package:sippy/components/history_cell.dart';
import 'db/db_helper.dart';


class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  List<Map<String, dynamic>> dataArray  = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await bindData();
  }

  Future<void> bindData() async {
    DBHelper dbHelper = DBHelper();
    var array = await dbHelper.getData();
    setState(() {
      dataArray = array;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBG,
      appBar: AppBar(
        title: const Text('History'),
        // Add a back button to the app bar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back when the back button is pressed
            Navigator.of(context).pop();
          },
        ),
      ),
      body: dataArray.isEmpty ? const Center(child: Text("No record found!",style: TextStyle(color: Colors.white, fontSize: 19),)) : ListView.builder(
        itemCount: dataArray.length,
        itemBuilder: (context, index) {
          return HistoryCell(data: dataArray[index]);
        },
      ),
    );
  }

}

