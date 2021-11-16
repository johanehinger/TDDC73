import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:lab2/utils/card_types.dart';

class CreditCard extends StatefulWidget {
  final CardTypes cardType;
  final String cardNumber;
  final String cardHolder;
  const CreditCard({
    Key? key,
    required this.cardNumber,
    required this.cardType,
    required this.cardHolder,
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
      flipOnTouch: true,
      speed: 5000,
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
            children: [
              Expanded(
                child: Row(
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
              ),
              Center(
                child: Text(
                  widget.cardNumber,
                  style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Card holder",
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                          Text(
                            widget.cardHolder,
                            style: const TextStyle(
                                fontSize: 12.0, color: Colors.white),
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Expires",
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                          Text(
                            "MM/YY",
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ]),
              ),
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
        ),
      ),
    );
  }
}
