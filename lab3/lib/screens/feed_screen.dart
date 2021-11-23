import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lab3/widgets/list_card.dart';
import 'package:lab3/widgets/query_list.dart';

const testGraphQL = """
query getRepositories(\$query: String!){
  search(query: \$query, type: REPOSITORY, first: 15) {
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

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    String _selectedValue = 'C++';
    List<String> listOfValue = [
      'JavaScript',
      'Python',
      'Java',
      'Go',
      'TypeScript',
      'C++',
      'Ruby',
      'PHP',
      'C#',
      'C',
      'Shell',
      'Nix',
      'Scala',
      'Dart',
      'Swift',
      'Rust',
      'Kotlin',
      'Groovy',
      'DM',
      'Elixir'
    ];

    return Scaffold(
        appBar: AppBar(
          actions: [
            Expanded(
              child: DropdownButtonFormField(
                value: _selectedValue,
                hint: const Text(
                  'choose one',
                ),
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value.toString();
                  });
                },
                onSaved: (value) {
                  setState(() {
                    _selectedValue = value.toString();
                  });
                },
                items: listOfValue.map((String val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                      val,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: QueryList(
              selectedValue: _selectedValue,
              testGraphQL: testGraphQL,
            ))
          ],
        ));
  }
}
