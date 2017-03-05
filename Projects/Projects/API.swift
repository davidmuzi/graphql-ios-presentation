//  This file was automatically generated and should not be edited.

import Apollo

public final class PublicReposQuery: GraphQLQuery {
  public static let operationDefinition =
    "query PublicRepos {" +
    "  viewer {" +
    "    login" +
    "    repositories(first: 10, privacy: PUBLIC) {" +
    "      edges {" +
    "        node {" +
    "          name" +
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
        repositories = try reader.value(for: Field(responseName: "repositories", arguments: ["first": 10, "privacy": "PUBLIC"]))
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

            public init(reader: GraphQLResultReader) throws {
              name = try reader.value(for: Field(responseName: "name"))
            }
          }
        }
      }
    }
  }
}