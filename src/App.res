@gentype @react.component
export make = () => {
  <ApolloClient.React.ApolloProvider client=Apollo.client>
    <LaunchesPast />
  </ApolloClient.React.ApolloProvider>
}
