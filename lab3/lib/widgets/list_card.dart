import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final int stargazerCount;
  final int forkCount;
  const ListCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.stargazerCount,
    required this.forkCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: Text(
                description,
                overflow: TextOverflow.fade,
              ),
            ),
            const SizedBox(
              height: 3.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                  ),
                  child: Text(
                    "Forks: " + forkCount.toString(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                  ),
                  child: Text(
                    "Stars: " + stargazerCount.toString(),
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
