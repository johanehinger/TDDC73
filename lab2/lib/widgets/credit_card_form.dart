import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab2/utils/card_types.dart';

class CreditCardForm extends StatefulWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderController;
  final TextEditingController cardCVVController;
  final FocusNode cardNumberFocusNode;
  final FocusNode cardHolderFocusNode;
  final FocusNode expirationMonthFocusNode;
  final FocusNode expirationYearFocusNode;
  final FocusNode cardCVVFocusNode;
  final Function setExpirationMonth;
  final Function setExpirationYear;
  final Function flipCard;
  final CardTypes cardType;
  const CreditCardForm({
    Key? key,
    required this.cardNumberController,
    required this.cardHolderController,
    required this.cardCVVController,
    required this.cardNumberFocusNode,
    required this.cardHolderFocusNode,
    required this.cardCVVFocusNode,
    required this.setExpirationMonth,
    required this.setExpirationYear,
    required this.flipCard,
    required this.expirationMonthFocusNode,
    required this.expirationYearFocusNode,
    required this.cardType,
  }) : super(key: key);

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

/// Override default TextInputFormatter to format text in "#### #### #### ####"
/// Source: https://medium.com/flutter-community/validating-and-formatting-payment-card-text-fields-in-flutter-bebe12bc9c60
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class _CreditCardFormState extends State<CreditCardForm> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 420,
        padding: const EdgeInsets.all(24.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 95.0,
              ),
              const Text("Card Number"),
              TextFormField(
                onChanged: (_) {
                  widget.flipCard();
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CardNumberInputFormatter(),
                  LengthLimitingTextInputFormatter(19)
                ],
                controller: widget.cardNumberController,
                focusNode: widget.cardNumberFocusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  // label: const Text("Card Number"),
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
              const SizedBox(
                height: 8,
              ),
              const Text("Card Holder"),
              TextFormField(
                onChanged: (_) {
                  widget.flipCard();
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(26),
                  FilteringTextInputFormatter.allow(RegExp("[ a-zA-Z????????????]")),
                ],
                focusNode: widget.cardHolderFocusNode,
                controller: widget.cardHolderController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
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
              const SizedBox(
                height: 8,
              ),
              Row(
                children: const [
                  Expanded(
                    child: Text("Expiration Date"),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(child: Text("CVV"))
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      focusNode: widget.expirationMonthFocusNode,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
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
                      iconEnabledColor: Colors.black,
                      items: <String>[
                        '01',
                        '02',
                        '03',
                        '04',
                        '05',
                        '06',
                        '07',
                        '08',
                        '09',
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
                          widget.setExpirationMonth(month);
                          widget.flipCard(true);
                        });
                      },
                      onTap: () {
                        widget.expirationMonthFocusNode.requestFocus();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      focusNode: widget.expirationYearFocusNode,
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
                          widget.setExpirationYear(year);
                          widget.flipCard(true);
                        });
                      },
                      onTap: () {
                        widget.expirationYearFocusNode.requestFocus();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        widget.cardType == CardTypes.amex
                            ? LengthLimitingTextInputFormatter(4)
                            : LengthLimitingTextInputFormatter(3),
                      ],
                      controller: widget.cardCVVController,
                      focusNode: widget.cardCVVFocusNode,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
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
                      onChanged: (_) {
                        widget.flipCard();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
