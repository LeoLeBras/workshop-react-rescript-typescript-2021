import React from 'react'

type State = { todos: { name: string; completed: boolean }[] }

const ADD_TODO = 'ADD_TODO'
type AddTodo = { type: typeof ADD_TODO; payload: { name: string } }
const addTodo = (name: string): AddTodo => ({ type: ADD_TODO, payload: { name } })

const REMOVE_TODO = 'REMOVE_TODO'
type RemoveTodo = { type: typeof REMOVE_TODO; payload: { name: string } }
const removeTodo = (name: string): RemoveTodo => ({ type: REMOVE_TODO, payload: { name } })

type Action = AddTodo | RemoveTodo

export const intiailState: State = { todos: [] }

const reducer = (state: State, action: Action): State => {
  switch (action.type) {
    case ADD_TODO: {
      const { name } = action.payload
      return { ...state, todos: [...state.todos, { name, completed: false }] }
    }
    case REMOVE_TODO: {
      const { name } = action.payload
      return { ...state, todos: state.todos.filter((todo) => todo.name !== name) }
    }
    default: {
      return state
    }
  }
}

const App: React.FC<{ initialState: State }> = (props) => {
  const [state, dispatch] = React.useReducer<React.Reducer<State, Action>>(
    reducer,
    props.initialState,
  )
  const [inputValue, setInputValue] = React.useState<string>(() => '')

  return (
    <div className="App">
      {state.todos.map((todo) => (
        <div>
          <span key={todo.name}>{todo.name}</span>
          <button onClick={() => dispatch(removeTodo(todo.name))}>x</button>
        </div>
      ))}
      <div>
        <input
          type="text"
          value={inputValue}
          defaultValue={inputValue}
          onChange={(event) => setInputValue(event.target.value)}
        />
        <button
          onClick={() => {
            dispatch(addTodo(inputValue))
            setInputValue(() => '')
          }}
        >
          Add todo
        </button>
      </div>
    </div>
  )
}

export default App
