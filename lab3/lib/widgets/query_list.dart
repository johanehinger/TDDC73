import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'list_card.dart';

class QueryList extends StatelessWidget {
  final String selectedValue;
  final String testGraphQL;
  const QueryList(
      {Key? key, required this.selectedValue, required this.testGraphQL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: gql(testGraphQL),
          variables: {"query": "stars:>100 languages:" + selectedValue},
          pollInterval: Duration(seconds: 5),
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

          var repoList = result.data?['search']['edges'];
          return ListView.builder(
            itemCount: repoList.length,
            itemBuilder: (_, index) {
              var repo = repoList[index]['node'];
              return ListCard(
                title: repo['name'],
                subtitle: repo['nameWithOwner'],
                description: repo['description'],
                stargazerCount: repo['stargazerCount'],
                forkCount: repo['forkCount'],
              );
            },
          );
        });
  }
}
