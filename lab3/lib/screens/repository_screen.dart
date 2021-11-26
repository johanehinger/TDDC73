import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lab3/models/repository_screen_arguments.dart';
import 'package:lab3/widgets/repository.dart';

const testGraphQL = """
query getRepository(\$owner: String!, \$name: String!, \$mainRefName: String!){
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(testGraphQL),
          variables: {
            "owner": args.owner,
            "name": args.name,
            "mainRefName": args.mainRefName,
          },
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            debugPrint(result.exception.toString());
            return Center(
              child: Text(
                result.exception.toString(),
              ),
            );
          }
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          int commits =
              result.data?['repository']['object']['history']['totalCount'];

          return Repository(
            name: args.name,
            description: args.description,
            license: args.license,
            commits: commits.toString(),
            branches: args.branches,
          );
        },
      ),
    );
  }
}
