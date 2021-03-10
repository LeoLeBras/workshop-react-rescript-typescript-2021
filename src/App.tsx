import { useRef } from 'react'
import { useLaunchesPastQuery } from './generated/graphql'

function App() {
  const offset = useRef(0)
  const { data, fetchMore } = useLaunchesPastQuery()

  const onRequestFetchMore = () => {
    offset.current += 5
    return fetchMore({
      variables: { offset: offset.current },
    })
  }

  if (!Array.isArray(data?.launchesPast)) {
    return <span>Fetching initial data</span>
  }

  return (
    <div className="App">
      {data?.launchesPast?.map((launch) => {
        if (launch) {
          return (
            <div key={launch.mission_name} style={{ marginBottom: '60px' }}>
              <strong>{launch.mission_name}</strong>
              <div style={{ display: 'flex' }}>
                {launch.ships?.map((ship) => {
                  if (ship) {
                    return (
                      <div style={{ display: 'flex', flexDirection: 'column' }}>
                        <p>{ship.name}</p>
                        {ship.image && <img alt="" width={125} src={ship.image} />}
                      </div>
                    )
                  }
                  return null
                })}
              </div>
            </div>
          )
        }
        return null
      })}
      <button onClick={onRequestFetchMore}>Fetch more</button>
    </div>
  )
}

export default App
