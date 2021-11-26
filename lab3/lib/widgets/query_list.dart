import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lab3/models/repository.dart';
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
        variables: {
          "query": "stars:>1000 sort:stars language:" + selectedValue,
          "cursor": null
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

        List<Repository> repoList = [
          ...result.data?['search']['edges'].map(
            (data) {
              return Repository(
                name: data['node']['name'],
                nameWithOwner: data['node']['nameWithOwner'],
                description: data['node']['description'],
                stargazerCount: data['node']['stargazerCount'],
                forkCount: data['node']['forkCount'],
                license: data['node']['licenseInfo'] == null
                    ? "No license"
                    : data['node']['licenseInfo']['spdxId'],
                mainRefName: data['node']['defaultBranchRef']['name'],
                owner: data['node']['owner']['login'],
                branches: data['node']['refs']['totalCount'],
              );
            },
          ),
        ];
        final Map pageInfo = result.data!['search']['pageInfo'];
        final String? endCursor = pageInfo['endCursor'];

        final fetchMoreOptions = FetchMoreOptions(
          variables: {
            "query": "stars:>1000 sort:stars language:" + selectedValue,
            'cursor': endCursor
          },
          updateQuery: (previousResultData, fetchMoreResultData) {
            final repos = [
              ...previousResultData!['search']['edges'],
              ...fetchMoreResultData!['search']['edges']
            ];
            fetchMoreResultData['search']['edges'] = repos;

            return fetchMoreResultData;
          },
        );

        return ListView.builder(
          itemCount: repoList.length + 1,
          itemBuilder: (_, index) {
            if (index == repoList.length) {
              return pageInfo['hasNextPage']
                  ? ElevatedButton(
                      onPressed: () {
                        fetchMore!(fetchMoreOptions);
                      },
                      child: const Text("Load More"),
                    )
                  : const SizedBox();
            }
            // final repo = repoList[index]['node'];
            final repo = repoList[index];

            return ListCard(
              name: repo.name,
              subtitle: repo.nameWithOwner,
              description: repo.description,
              stargazerCount: repo.stargazerCount,
              forkCount: repo.forkCount,
              license: repo.license,
              owner: repo.owner,
              branches: repo.branches,
              mainRefName: repo.mainRefName,
            );
          },
        );
      },
    );
  }
}
