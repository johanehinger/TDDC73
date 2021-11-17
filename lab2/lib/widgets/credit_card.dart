import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:lab2/utils/card_types.dart';
import 'dart:ui';

class CreditCard extends StatefulWidget {
  final CardTypes cardType;
  final String cardNumber;
  final String cardHolder;
  final String expirationMonth;
  final String expirationYear;
  final String cardVV;
  final FocusNode cardNumberFocusNode;
  final FocusNode cardHolderFocusNode;
  final FocusNode cardCVVFocusNode;
  final FocusNode expirationMonthFocusNode;
  final FocusNode expirationYearFocusNode;
  final FlipCardController flipCardController;
  final Function flipCard;

  const CreditCard({
    Key? key,
    required this.cardNumber,
    required this.cardType,
    required this.cardHolder,
    required this.cardVV,
    required this.cardNumberFocusNode,
    required this.cardHolderFocusNode,
    required this.expirationMonthFocusNode,
    required this.expirationYearFocusNode,
    required this.expirationMonth,
    required this.expirationYear,
    required this.cardCVVFocusNode,
    required this.flipCardController,
    required this.flipCard,
  }) : super(key: key);

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  @override
  Widget build(BuildContext context) {
    String _getCardAsset() {
      if (widget.cardType == CardTypes.visa) {
        return 'assets/images/visa.png';
      } else if (widget.cardType == CardTypes.masterCard) {
        return 'assets/images/mastercard.png';
      } else if (widget.cardType == CardTypes.amex) {
        return 'assets/images/amex.png';
      } else if (widget.cardType == CardTypes.discover) {
        return 'assets/images/discover.png';
      }
      return 'assets/images/visa.png';
    }

    return FlipCard(
      flipOnTouch: false,
      controller: widget.flipCardController,
      speed: 1000,
      front: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/images/2.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/chip.png',
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          _getCardAsset(),
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    widget.cardNumberFocusNode.requestFocus();
                  },
                  child: Container(
                    width: 280,
                    padding: const EdgeInsets.all(
                      3.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: Colors.white,
                          width: 1.5,
                          style: widget.cardNumberFocusNode.hasFocus
                              ? BorderStyle.solid
                              : BorderStyle.none),
                    ),
                    child: Center(
                      child: Text(
                        widget.cardNumber,
                        style: const TextStyle(
                          fontFeatures: [FontFeature.tabularFigures()],
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          widget.cardHolderFocusNode.requestFocus();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                                style: widget.cardHolderFocusNode.hasFocus
                                    ? BorderStyle.solid
                                    : BorderStyle.none),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                              3.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Card holder",
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.grey),
                                ),
                                Text(
                                  widget.cardHolder,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(
                        3.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                            style: widget.expirationYearFocusNode.hasFocus ||
                                    widget.expirationMonthFocusNode.hasFocus
                                ? BorderStyle.solid
                                : BorderStyle.none),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Expires",
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  widget.expirationMonthFocusNode
                                      .requestFocus();
                                  setState(() {});
                                },
                                child: Text(
                                  widget.expirationMonth,
                                  style: const TextStyle(
                                      fontSize: 12.0, color: Colors.white),
                                ),
                              ),
                              const Text(
                                "/",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.expirationYearFocusNode.requestFocus();
                                  setState(() {});
                                },
                                child: Text(
                                  widget.expirationYear,
                                  style: const TextStyle(
                                      fontSize: 12.0, color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ]),
            ],
          ),
        ),
      ),
      back: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/images/2.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Text(
                  "CVV",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.cardCVVFocusNode.requestFocus();
                  widget.flipCard();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(widget.cardVV),
                        const SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            _getCardAsset(),
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
