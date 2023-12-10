import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sippy/components/app_theme.dart';
import 'package:sippy/history.dart';
import 'package:sippy/utils/utils.dart';
import 'components/slider.dart';
import 'db/db_helper.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double rateOfReturn = 12.5;
  int period = 17;
  bool isInputActive = false;
  String monthlyInvestment = "";
  double actualAmount = 0;
  double timesRolledOver = 0;
  double netReturn = 0;
  bool showingHistory = false;
  bool showSetting = false;

  _HomePageState() {
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor:AppTheme.lightBG,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.add), // Gear button icon
            onPressed: () async {
              // Handle gear button click
              if(netReturn > 0 ) {
                DBHelper dbHelper = DBHelper();
                await dbHelper.insertData({'actual_amount': actualAmount, 'profit':netReturn+actualAmount,'periods':period,'rate_of_return':rateOfReturn,'times_rolled':timesRolledOver.toInt()});
              } else {
                Fluttertoast.showToast(
                  msg: "Please enter amount",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                );
              }

            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.bookmark), // Bookmark icon
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryPage()),
                );
              },
            ),
          ],
          title: const Center(child: Text('Sippy')),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              Utility.instance.formatAmount(actualAmount),
                              style: const TextStyle(color: Colors.black26, fontSize: 22.0, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Actual Amount',
                              style: TextStyle(color: Colors.black26, fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              Utility.instance.formatAmount(actualAmount + netReturn),
                              style: const TextStyle(color: Colors.black26, fontSize: 22.0, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Expected Amount',
                              style: TextStyle(color: Colors.black26, fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'PROFIT GAIN',
                      style: TextStyle(color: Colors.black26, fontSize: 18.0),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          Utility.instance.formatAmount(netReturn),
                          style: TextStyle(color: (netReturn > 0) ? Colors.green : Colors.red, fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'AMOUNT PER MONTH',
                      style: TextStyle(color: Colors.black26, fontSize: 18.0),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                      child: TextField(
                        style: const TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Enter Amount',
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          setState(() {
                            monthlyInvestment = value;
                            calculateSIP();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Period (Years)',
                              style: TextStyle(color: Colors.black26, fontSize: 14.0),
                            ),
                            Text(
                              '$period',
                              style: const TextStyle(color: Colors.black26, fontSize: 14.0),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        SliderWidget(
                          sliderValue: period.toDouble(),
                          onSliderValueChanged: (value) {
                            setState(() {
                              period = value.toInt();
                              calculateSIP();
                            });
                            // Handle the updated slider value here
                            if (kDebugMode) {
                              print('Slider value outside the widget: $period');
                            }
                          },
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Rate Of Return(%)',
                              style: TextStyle(color: Colors.black26, fontSize: 14.0),
                            ),
                            Text(
                              '$rateOfReturn',
                              style: const TextStyle(color: Colors.black26, fontSize: 14.0),
                            ),
                          ],
                        ),
                        SliderWidget(
                          sliderValue: rateOfReturn,
                          onSliderValueChanged: (value) {
                            setState(() {
                              rateOfReturn = double.parse(value.toStringAsFixed(2));
                              calculateSIP();
                            });
                            // Handle the updated slider value here
                            if (kDebugMode) {
                              print('Slider value outside the widget: $rateOfReturn');
                            }
                          },
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
                const Text(
                  'Return can vary based on the market trends',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateSIP() {
    double amount = double.tryParse(monthlyInvestment) ?? 0;

    if (amount > 0 && period > 0 && rateOfReturn > 0) {
      double periodMonthly = period * 12.0;
      double rateOfReturnMonthly = rateOfReturn / 12.0 / 100.0;

      actualAmount = amount * periodMonthly;

      double futureAmount = Utility.instance.futureSipValue(rateOfReturnMonthly, periodMonthly, amount);
      netReturn = futureAmount - actualAmount;
      timesRolledOver = actualAmount == 0 ? 0 : futureAmount / actualAmount;
    } else {
      actualAmount = 0;
      timesRolledOver = 0;
      netReturn = 0;
    }
  }

}

