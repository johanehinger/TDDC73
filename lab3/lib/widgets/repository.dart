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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              description,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text("License"),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(license),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text("Commits"),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(commits),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text("Branches"),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(branches),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
