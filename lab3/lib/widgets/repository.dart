import 'package:flutter/material.dart';

class Repository extends StatelessWidget {
  final String name;
  final String description;
  final String license;
  final String commits;
  final String branches;
  const Repository({
    Key? key,
    required this.name,
    required this.description,
    required this.license,
    required this.commits,
    required this.branches,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            description,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("License"),
              Text(license),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Commits"),
              Text(commits),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Branches"),
              Text(branches),
            ],
          ),
        ],
      ),
    );
  }
}
