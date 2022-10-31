import 'package:flutter/material.dart';
import 'package:expense_project/component/colors.dart' as color;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../boxGetStorage.dart';
import 'package:expense_project/page/home.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  static final _otherBox = () => GetStorage('MyStorge');

  // final expense = 0.val('expense', getBox: _otherBox)
  int expense = 0;
  int? salary;
  int? balance;
  int saving = 0;
  List historyList = [];

  final items = ['Shopping', 'Restaurant', 'Cafe', 'Gifts', 'Transportation'];
  String? selectedItem = 'Shopping';

  void initState() {
    box.write('balance', balance);
    box.write('items', items);
  }

  addToExpense(
      {required int value, required String items, required DateTime date}) {
    setState(() {
      expense += value;
      // final expense = value.val('expense');
      // final realAge = expense1.val + value;
      // print(realAge);
      // expense.val = realAge;
      // final test = expense1.val;
      // print(expense.val);

      historyList.add({
        'value': value,
        'category': items,
        'date': date,
      });

      // box.write('expense', expense);
      box.write('historylist', historyList);
    });
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme;

    final expenseController = new TextEditingController();
    final itemsController = new TextEditingController();


    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              // height: 450,
              // width: 414,
              // margin: const EdgeInsets.only(bottom: 20),
              // padding: const EdgeInsets.symmetric(horizontal: 20),
              // decoration: BoxDecoration(
              //     color: color.Colors.backgroundColor,
              //     borderRadius: BorderRadius.circular(10)),

              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Choose Category',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            height: 3,
                            color: color.Colors.disableColor,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                width: 1,
                                color: color.Colors.backgroundGreenColor),
                          ),
                        ),
                        value: selectedItem,
                        iconSize: 20,
                        icon: Icon(Icons.keyboard_arrow_down_sharp,
                            color: color.Colors.backgroundGreenColor),
                        isExpanded: true,
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(fontSize: 16),
                                )))
                            .toList(),
                        onChanged: (item) =>
                            setState(() => selectedItem = item),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Your Expenses',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            height: 3,
                            color: color.Colors.disableColor,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                    child: TextFormField(
                      controller: expenseController,
                      decoration: InputDecoration(
                        hintText: '100 SR',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              width: 1,
                              color: color.Colors.backgroundGreenColor),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Exchange Data',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            height: 3,
                            color: color.Colors.disableColor,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: '2022-10-31',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              width: 1,
                              color: color.Colors.backgroundGreenColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        addToExpense(
                          value: int.parse(expenseController.text),
                          items: items.first,
                          date: DateTime.now(),
                        );
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: color.Colors.backgroundGreenColor,
                        minimumSize: Size.fromHeight(48),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
