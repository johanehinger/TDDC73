import 'package:flutter/material.dart';
import 'package:lab2/widgets/credit_card.dart';
import 'package:lab2/widgets/credit_card_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String cardNumber = "";
  final cardNumberController = TextEditingController();

  void _updateCardNumber() {
    cardNumber = cardNumberController.text;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cardNumberController.addListener(_updateCardNumber);
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 600,
          child: Stack(
            alignment: Alignment.center,
            textDirection: TextDirection.rtl,
            fit: StackFit.loose,
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                top: 120,
                left: 5,
                right: 5,
                child: CreditCardForm(
                  controller: cardNumberController,
                ),
              ),
              Positioned(
                top: 0,
                child: CreditCard(
                  cardNumber: cardNumber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
