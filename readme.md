# Environment Setup

[Setup Apollo](http://dev.apollodata.com/ios/installation.html)
1. Create new iOS project in Xcode
2. Use Carthage to bring in Apollo as a dependancy
  `touch Cartfile`
  `open Cartfile`
  `github "apollostack/apollo-ios"`
  `carthage update`
3. Link to `Apollo.framwork`
4. Add build script
  `/usr/local/bin/carthage copy-frameworks`
  `$(SRCROOT)/Carthage/Build/iOS/Apollo.framework`
5. Install `apollo-codegen`
  `npm install -g apollo-codegen`
6. Add codegen build phase
  ```
  APOLLO_FRAMEWORK_PATH="$(eval find $FRAMEWORK_SEARCH_PATHS -name "Apollo.framework" -maxdepth 1)"

if [ -z "$APOLLO_FRAMEWORK_PATH" ]; then
  echo "error: Couldn't find Apollo.framework in FRAMEWORK_SEARCH_PATHS; make sure to add the framework to your project."
  exit 1
fi

cd "${SRCROOT}/${TARGET_NAME}"
$APOLLO_FRAMEWORK_PATH/check-and-run-apollo-codegen.sh generate $(find . -name '*.graphql') --schema  schema.json --output API.swift
  ```

[Downloading a schema](http://dev.apollodata.com/ios/downloading-schema.html)
1. `apollo-codegen download-schema https://api.github.com/graphql --output schema.json --header "Authorization: Bearer <token>"`
2. Build to generate `API.swift`, link to target

# Creating Queries
1. Use [GraphiQL](https://developer.github.com/early-access/graphql/explorer/) to create query
```
query PublicRepos {
    viewer {
        login
        repositories(first: 10, privacy: PUBLIC) {
            edges {
                node {
                    id
                    name
                }
            }
        }
    }
}
```
2. Build, take a look at `API.swift`
