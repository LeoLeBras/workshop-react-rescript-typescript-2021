open ApolloClient

let client = {
  make(
    ~cache=Cache.InMemoryCache.make(
      ~typePolicies=[
        (
          "Query",
          Cache.InMemoryCache.TypePolicy.make(
            ~fields=[("launchesPast", OffsetLimitPagination(KeySpecifier([])))],
            (),
          ),
        ),
      ],
      (),
    ),
    ~uri=_ => "https://api.spacex.land/graphql/",
    (),
  )
}
