import { render } from '@testing-library/react'
import { make as App } from './App.gen'

test('renders without crashing', () => {
  render(<App />)
})
