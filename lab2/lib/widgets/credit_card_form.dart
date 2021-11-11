import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreditCardForm extends StatefulWidget {
  final TextEditingController controller;
  const CreditCardForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  String? _chosenMonth;
  String? _chosenYear;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 350,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 60.0,
            ),
            TextFormField(
              controller: widget.controller,
              maxLength: 16,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Card Number",
                contentPadding: const EdgeInsets.all(5),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Card Holder",
                contentPadding: const EdgeInsets.all(5),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    value: _chosenMonth,
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                      '6',
                      '7',
                      '8',
                      '9',
                      '10',
                      '11',
                      '12',
                    ].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      },
                    ).toList(),
                    hint: const Text(
                      "Month",
                    ),
                    onChanged: (String? month) {
                      setState(() {
                        _chosenMonth = month;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isExpanded: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    value: _chosenYear,
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      '2021',
                      '2022',
                      '2023',
                      '2024',
                      '2025',
                      '2026',
                      '2027',
                      '2028',
                      '2029',
                      '2030',
                      '2031',
                      '2032'
                    ].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      },
                    ).toList(),
                    hint: const Text(
                      "Year",
                    ),
                    onChanged: (String? year) {
                      setState(() {
                        _chosenYear = year;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "CVV",
                      contentPadding: const EdgeInsets.all(5),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
