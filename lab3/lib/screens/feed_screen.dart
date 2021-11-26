import 'package:flutter/material.dart';
import 'package:lab3/widgets/query_list.dart';

const testGraphQL = """
query getRepositories(\$query: String!, \$cursor: String){
  search(query: \$query, type: REPOSITORY, first: 10, after: \$cursor) {
    repositoryCount
    edges {
      node {
        ... on Repository {
          name
          nameWithOwner
          description
          forkCount
          stargazerCount
          licenseInfo {
            spdxId
          }
          defaultBranchRef {
            name
          }
          refs(refPrefix: "refs/heads/") {
            totalCount
          }
        }
      }
    }
    pageInfo {
      endCursor
      hasNextPage
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
  String _selectedValue = 'JavaScript';
  @override
  Widget build(BuildContext context) {
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
            ),
          ),
        ],
      ),
    );
  }
}
