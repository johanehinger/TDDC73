import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lab3/widgets/list_card.dart';

const testGraphQL = """
{
  search(query: "stars:>10000", type: REPOSITORY, first: 15) {
    repositoryCount
    edges {
      node {
        ... on Repository {
          id
          name
          nameWithOwner
          description
          forkCount
          stargazerCount
        }
      }
    }
  }
}
""";

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Query(
        options: QueryOptions(document: gql(testGraphQL)),
        builder: (QueryResult result, {fetchMore, refetch}) {
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
        },
      ),
    );
  }
}