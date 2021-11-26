import 'package:flutter/material.dart';
import 'package:lab3/models/repository_screen_arguments.dart';

class ListCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String description;
  final int stargazerCount;
  final int forkCount;
  final String license;
  final String owner;
  final int branches;
  final String mainRefName;
  const ListCard({
    Key? key,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.stargazerCount,
    required this.forkCount,
    required this.license,
    required this.owner,
    required this.branches,
    required this.mainRefName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/repo',
          arguments: RepositoryScreenArguments(
            name: name,
            description: description,
            license: license == "NOASSERTION" ? "No license" : license,
            branches: branches.toString(),
            owner: owner,
            mainRefName: mainRefName,
          ),
        );
      },
      child: Card(
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
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
      ),
    );
  }
}
