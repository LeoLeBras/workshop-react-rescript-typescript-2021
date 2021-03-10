import { greeting } from './Greeting'

function App() {
  return (
    <div className="App">
      {/* Poor type inference */}
      {greeting(1, 2)}
      {greeting('1', '2')}
    </div>
  )
}

export default App
