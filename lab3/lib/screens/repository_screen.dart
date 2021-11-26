import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lab3/models/repository_screen_arguments.dart';

const testGraphQL = """
query getRepositort(\$owner: String!, \$name: String!, \$mainRefName: String?){
repository(owner: \$owner, name: \$name) {
    object(expression: \$mainRefName) {
      ... on Commit {
        history {
          totalCount
        }
      }
    }
  }
}
""";

class RepositoryScreen extends StatelessWidget {
  const RepositoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as RepositoryScreenArguments;
    // return Query(options: options, builder: builder)
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              args.title,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              args.description,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("License"),
                Text(args.license),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Commits"),
                Text(args.commits),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Branches"),
                Text(args.branches),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
