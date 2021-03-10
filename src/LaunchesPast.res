module LaunchesPastQuery = %graphql(`
  query launchesPast($offset: Int) {
    launchesPast(limit: 5, offset: $offset) {
      mission_name
      launch_date_local
      launch_site {
        site_name_long
      }
      ships {
        name
        home_port
        image
      }
    }
  }
`)

@react.component
export make = () => {
  let offset = React.useRef(0)
  let launchesPastQuery = LaunchesPastQuery.use(LaunchesPastQuery.makeVariables())

  let onRequestFetchMore = _ => {
    offset.current = offset.current + 5
    launchesPastQuery.fetchMore(
      ~variables=LaunchesPastQuery.makeVariables(~offset=offset.current, ()),
      (),
    )->ignore
  }

  <div>
    {switch launchesPastQuery {
    | {data: Some({launchesPast: Some(launchesPast)})} =>
      <div>
        {launchesPast
        ->Array.map(launchPast => {
          switch launchPast {
          | Some({mission_name: Some(missionName), ships}) =>
            <div key={missionName} style={ReactDOMStyle.make(~marginBottom="20px", ())}>
              <strong> {missionName->React.string} </strong>
              <div style={ReactDOMStyle.make(~display="flex", ())}>
                {switch ships {
                | Some(ships) =>
                  ships
                  ->Array.map(ship =>
                    switch ship {
                    | Some({name: Some(name), image}) =>
                      <div
                        key={name}
                        style={ReactDOMStyle.make(~display="flex", ~flexDirection="column", ())}>
                        <p> {name->React.string} </p>
                        {switch {image} {
                        | Some(image) => <img alt="" width="125" src={image} />
                        | None => React.null
                        }}
                      </div>
                    | _ => React.null
                    }
                  )
                  ->React.array
                | _ => React.null
                }}
              </div>
            </div>
          | _ => React.null
          }
        })
        ->React.array}
        <button onClick={onRequestFetchMore}> {"Fetch more"->React.string} </button>
      </div>
    | {error: Some(error)} => error.message->React.string
    | {data: None}
    | {error: None} =>
      "Loading ..."->React.string
    }}
  </div>
}
