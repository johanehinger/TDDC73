import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lab3/screens/feed_screen.dart';
import 'package:lab3/screens/repository_screen.dart';

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
      title: 'Github GraphQL',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textTheme: TextTheme(
          subtitle2: TextStyle(
            color: Colors.grey[500],
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FeedScreen(),
        '/repo': (context) => const RepositoryScreen(),
      },
    );
  }
}
