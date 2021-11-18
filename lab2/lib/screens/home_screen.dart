import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:lab2/utils/card_types.dart';
import 'package:lab2/widgets/credit_card.dart';
import 'package:lab2/widgets/credit_card_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String cardNumber = "#### #### #### ####";
  String cardHolder = "FULL NAME";
  String expirationMonth = "MM";
  String expirationYear = "YY";
  String cardCVV = "";
  CardTypes cardType = CardTypes.visa;
  final cardNumberController = TextEditingController();
  final cardHolderController = TextEditingController();
  final cardCVVController = TextEditingController();

  final cardNumberFocusNode = FocusNode();
  final cardHolderFocusNode = FocusNode();
  final cardCVVFocusNode = FocusNode();
  final expirationMonthFocusNode = FocusNode();
  final expirationYearFocusNode = FocusNode();

  final flipCardController = FlipCardController();

  void _flipCard([bool focus = false]) {
    debugPrint("in flipcard");
    if (cardCVVFocusNode.hasFocus && flipCardController.state!.isFront) {
      flipCardController.toggleCard();
      return;
    } else if ((cardNumberFocusNode.hasFocus || cardHolderFocusNode.hasFocus) &&
        !flipCardController.state!.isFront) {
      flipCardController.toggleCard();
      return;
    }
    if (focus && !flipCardController.state!.isFront) {
      flipCardController.toggleCard();
      return;
    }
    return;
  }

  void _updateCardType(String cardNumber) {
    RegExp visa = RegExp(r'^4');
    RegExp mastercard = RegExp(r'^5');
    RegExp discover = RegExp(r'^6');
    RegExp amex = RegExp(r'^3(4|7)');
    if (visa.hasMatch(cardNumber)) {
      cardType = CardTypes.visa;
      return;
    } else if (mastercard.hasMatch(cardNumber)) {
      cardType = CardTypes.masterCard;
      return;
    } else if (discover.hasMatch(cardNumber)) {
      cardType = CardTypes.discover;
      return;
    } else if (amex.hasMatch(cardNumber)) {
      cardType = CardTypes.amex;
      return;
    }
    cardType = CardTypes.visa;
  }

  void _updateCardNumber() {
    _updateCardType(cardNumberController.text);
    cardNumber = "#### #### #### ####";
    cardNumber = cardNumber.substring(cardNumberController.text.length);
    cardNumber = cardNumberController.text + cardNumber;
    setState(() {});
  }

  void _updateCardHolder() {
    cardHolder = cardHolderController.text.isEmpty
        ? "FULL NAME"
        : cardHolderController.text.toUpperCase();
    setState(() {});
  }

  void _updateCVV() {
    cardCVV = cardCVVController.text;
    setState(() {});
  }

  void _setExpirationMonth(String? month) {
    expirationMonth = month ?? "MM";
    setState(() {});
  }

  void _setExpirationYear(String? year) {
    expirationYear = year ?? "YY";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cardNumberController.addListener(_updateCardNumber);
    cardHolderController.addListener(_updateCardHolder);
    cardCVVController.addListener(_updateCVV);
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    cardHolderController.dispose();
    cardCVVController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                    cardType: cardType,
                    cardNumberController: cardNumberController,
                    cardCVVController: cardCVVController,
                    cardHolderController: cardHolderController,
                    cardNumberFocusNode: cardNumberFocusNode,
                    cardHolderFocusNode: cardHolderFocusNode,
                    expirationMonthFocusNode: expirationMonthFocusNode,
                    expirationYearFocusNode: expirationYearFocusNode,
                    cardCVVFocusNode: cardCVVFocusNode,
                    setExpirationMonth: _setExpirationMonth,
                    setExpirationYear: _setExpirationYear,
                    flipCard: _flipCard,
                  ),
                ),
                Positioned(
                  top: 0,
                  child: CreditCard(
                    expirationMonthFocusNode: expirationMonthFocusNode,
                    expirationYearFocusNode: expirationYearFocusNode,
                    cardVV: cardCVV,
                    expirationYear: expirationYear,
                    expirationMonth: expirationMonth,
                    cardNumber: cardNumber,
                    cardType: cardType,
                    cardHolder: cardHolder,
                    cardNumberFocusNode: cardNumberFocusNode,
                    cardHolderFocusNode: cardHolderFocusNode,
                    cardCVVFocusNode: cardCVVFocusNode,
                    flipCardController: flipCardController,
                    flipCard: _flipCard,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
