type action =
  | AddTodo(string)
  | RemoveTodo(string)

type todo = {name: string, completed: bool}

let initialState = [{name: "salut", completed: false}]

let reducer = (state, action) => {
  switch action {
  | AddTodo(todoName) => state->Array.concat([{name: todoName, completed: false}])
  | RemoveTodo(todoName) => state->Array.keep(todo => todo.name !== todoName)
  }
}

@gentype @react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState)
  let (inputValue, setInputValue) = React.useState(() => "")

  <div>
    {state
    ->Array.map(todo => {
      <div>
        <span> {todo.name->React.string} </span>
        <button onClick={_ => dispatch(RemoveTodo(todo.name))}> {"x"->React.string} </button>
      </div>
    })
    ->React.array}
    <div>
      <input
        type_="text"
        value={inputValue}
        onChange={event => setInputValue(ReactEvent.Form.currentTarget(event)["value"])}
      />
      <button
        onClick={_ => {
          dispatch(AddTodo(inputValue))
          setInputValue(_ => "")
        }}>
        {"Add todo"->React.string}
      </button>
    </div>
  </div>
}
