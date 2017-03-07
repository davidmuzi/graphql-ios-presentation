# GraphQL
## No time for REST

---

## What's wrong with REST?
- Not flexible
  - `http://www.example.com/api/v3/stuffs/?showThis=true&notThat=true&sortOrder=titleAsc
`
- Bandwidth heavy
  - articles count?
- No type information
  - Date?, URL?

---

## GraphQL

### Schema -> Query -> Response

---

**Schema** -> Query -> Response

```yaml
type Repository {
  id: ID!
  isPrivate: Boolean!
  name: String!
  path: URI!
  labels(first: Int, after: String): LabelConnection
}

type LabelConnection {
  edges: [LabelEdge]
  nodes: [Label]
  pageInfo: PageInfo!
  totalCount: Int!
}
```

*Github: https://developer.github.com/early-access/graphql/explorer/*

---

### Terminology

```yaml
  "Repository": Object type
  "isPrivate": field
  "String": Scalar type
  "String!": non-nullable
```

---

Schema -> **Query** -> Response

```yaml
{  
  repository(owner:"davidmuzi", name: "Provenance") {
    path
    id
    isPrivate
  }
}
```

---

Schema -> Query -> **Response**

```json
  “repository": {
    "path": "/davidmuzi/Provenance",  
    "id": "MDEwOlJlcG9zaXRvcnkxMzU0MjQ3OA==",
    "isPrivate": false    
  }
```

---

## Browsing a Schema

[Github graphQL API Explorer | GitHub Developer Guide](https://developer.github.com/early-access/graphql/explorer/)

---

## Making a Request

```
curl -X "POST" "https://api.github.com/graphql" \
     -H "Authorization: Bearer <TOKEN>" \
     -H "Content-Type: text/plain; charset=utf-8" \
     -d "{\"query\": \"{ viewer { name } }\"}"
```

---

## Aliases

Allows multiple queries of the same type in a single Request

```yaml
{  
  repo1: repository(owner:"davidmuzi", name: "Provenance") { id }
  repo2: repository(owner:"davidmuzi", name: "DMDiskStation") { id }
}
```
```json
{
  "data": {
    "repo1": {
      "id": "MDEwOlJlcG9zaXRvcnkxMzU0MjQ3OA=="
    },
    "repo2": {
      "id": "MDEwOlJlcG9zaXRvcnkyODYzNzAxMg=="
    }
  }
}
```
___

## Mutations

Create and modify existing data

- 2 parts
  - mutation
  - variables

---

## Mutation

mutation

```yaml
mutation AddComment($input: AddCommentInput!) {
  addComment(input: $input) {
    clientMutationId
  }
}
```
variables

```json
{
  "input": {
    "clientMutationId": "asdlkfbao87sdt==",
    "subjectId": "asdkjfasdf97asd==",
    "body": "A Comment"
  }
}
```

___

## Other Features

- Enums
- Inheritance
- Unions
- Fragments
- Directives

___

# :iphone:
___

# Apollo  

![inline, 200%](apollo.png)

### iOS (and Android) Client
http://dev.apollodata.com
