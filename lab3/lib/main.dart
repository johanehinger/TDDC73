import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const testGraphQL = """
{
  search(query: "stars:>10000", type: REPOSITORY, first: 10) {
    repositoryCount
    edges {
      node {
        ... on Repository {
          id
          name
          description
          stargazers {
            totalCount
          }
        }
      }
    }
  }
}
""";

void main() async {
  // Load personal github access token.
  await dotenv.load(fileName: "assets/.env");
  String accesToken = dotenv.env['githubPersonalAccessToken']!;

  final HttpLink httpLink = HttpLink("https://api.github.com/graphql");

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer $accesToken',
  );

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    ),
  );
  var app = GraphQLProvider(
    client: client,
    child: const MyApp(),
  );

  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: Query(
          options: QueryOptions(document: gql(testGraphQL)),
          builder: (QueryResult result, {fetchMore, refetch}) {
            if (result.hasException) {
              debugPrint(result.exception.toString());
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var repoList = result.data?['search']['edges'];
            return Column(
              children: [
                const Text("Repos"),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: repoList.length,
                    itemBuilder: (_, index) {
                      var repo = repoList[index]['node'];
                      return Text(repo["name"]);
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
