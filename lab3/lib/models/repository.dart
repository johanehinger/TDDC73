class Repository {
  final String name;
  final String nameWithOwner;
  final String description;
  final int stargazerCount;
  final int forkCount;
  final String license;
  final String mainRefName;
  final String owner;
  final int branches;

  Repository({
    required this.name,
    required this.nameWithOwner,
    required this.description,
    required this.stargazerCount,
    required this.forkCount,
    required this.license,
    required this.mainRefName,
    required this.owner,
    required this.branches,
  });
}
