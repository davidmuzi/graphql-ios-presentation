//  This file was automatically generated and should not be edited.

import Apollo

public final class ReposProjectsQuery: GraphQLQuery {
  public static let operationDefinition =
    "query ReposProjects($repo: String!) {" +
    "  viewer {" +
    "    repository(name: $repo) {" +
    "      id" +
    "      projects(first: 10) {" +
    "        edges {" +
    "          node {" +
    "            id" +
    "            name" +
    "          }" +
    "        }" +
    "      }" +
    "    }" +
    "  }" +
    "}"

  public let repo: String

  public init(repo: String) {
    self.repo = repo
  }

  public var variables: GraphQLMap? {
    return ["repo": repo]
  }

  public struct Data: GraphQLMappable {
    public let viewer: Viewer

    public init(reader: GraphQLResultReader) throws {
      viewer = try reader.value(for: Field(responseName: "viewer"))
    }

    public struct Viewer: GraphQLMappable {
      public let __typename = "User"
      public let repository: Repository?

      public init(reader: GraphQLResultReader) throws {
        repository = try reader.optionalValue(for: Field(responseName: "repository", arguments: ["name": reader.variables["repo"]]))
      }

      public struct Repository: GraphQLMappable {
        public let __typename = "Repository"
        public let id: GraphQLID
        public let projects: Project

        public init(reader: GraphQLResultReader) throws {
          id = try reader.value(for: Field(responseName: "id"))
          projects = try reader.value(for: Field(responseName: "projects", arguments: ["first": 10]))
        }

        public struct Project: GraphQLMappable {
          public let __typename = "ProjectConnection"
          public let edges: [Edge?]?

          public init(reader: GraphQLResultReader) throws {
            edges = try reader.optionalList(for: Field(responseName: "edges"))
          }

          public struct Edge: GraphQLMappable {
            public let __typename = "ProjectEdge"
            public let node: Node?

            public init(reader: GraphQLResultReader) throws {
              node = try reader.optionalValue(for: Field(responseName: "node"))
            }

            public struct Node: GraphQLMappable {
              public let __typename = "Project"
              public let id: GraphQLID
              public let name: String

              public init(reader: GraphQLResultReader) throws {
                id = try reader.value(for: Field(responseName: "id"))
                name = try reader.value(for: Field(responseName: "name"))
              }
            }
          }
        }
      }
    }
  }
}

public final class PublicReposQuery: GraphQLQuery {
  public static let operationDefinition =
    "query PublicRepos {" +
    "  viewer {" +
    "    login" +
    "    repositories(first: 20, privacy: PUBLIC) {" +
    "      edges {" +
    "        node {" +
    "          name" +
    "          projects(first: 100) {" +
    "            edges {" +
    "              node {" +
    "                name" +
    "              }" +
    "            }" +
    "          }" +
    "        }" +
    "      }" +
    "    }" +
    "  }" +
    "}"
  public init() {
  }

  public struct Data: GraphQLMappable {
    public let viewer: Viewer

    public init(reader: GraphQLResultReader) throws {
      viewer = try reader.value(for: Field(responseName: "viewer"))
    }

    public struct Viewer: GraphQLMappable {
      public let __typename = "User"
      public let login: String
      public let repositories: Repository

      public init(reader: GraphQLResultReader) throws {
        login = try reader.value(for: Field(responseName: "login"))
        repositories = try reader.value(for: Field(responseName: "repositories", arguments: ["first": 20, "privacy": "PUBLIC"]))
      }

      public struct Repository: GraphQLMappable {
        public let __typename = "RepositoryConnection"
        public let edges: [Edge?]?

        public init(reader: GraphQLResultReader) throws {
          edges = try reader.optionalList(for: Field(responseName: "edges"))
        }

        public struct Edge: GraphQLMappable {
          public let __typename = "RepositoryEdge"
          public let node: Node?

          public init(reader: GraphQLResultReader) throws {
            node = try reader.optionalValue(for: Field(responseName: "node"))
          }

          public struct Node: GraphQLMappable {
            public let __typename = "Repository"
            public let name: String
            public let projects: Project

            public init(reader: GraphQLResultReader) throws {
              name = try reader.value(for: Field(responseName: "name"))
              projects = try reader.value(for: Field(responseName: "projects", arguments: ["first": 100]))
            }

            public struct Project: GraphQLMappable {
              public let __typename = "ProjectConnection"
              public let edges: [Edge?]?

              public init(reader: GraphQLResultReader) throws {
                edges = try reader.optionalList(for: Field(responseName: "edges"))
              }

              public struct Edge: GraphQLMappable {
                public let __typename = "ProjectEdge"
                public let node: Node?

                public init(reader: GraphQLResultReader) throws {
                  node = try reader.optionalValue(for: Field(responseName: "node"))
                }

                public struct Node: GraphQLMappable {
                  public let __typename = "Project"
                  public let name: String

                  public init(reader: GraphQLResultReader) throws {
                    name = try reader.value(for: Field(responseName: "name"))
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}