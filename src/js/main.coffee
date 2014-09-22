#--------------------------------------------------------
# Requirements
#--------------------------------------------------------

DOM = require("./DOM.coffee")

{div, h1, ul, li, h2, input, a} = DOM


#--------------------------------------------------------
# Outer
#--------------------------------------------------------

Outer = React.createClass
  
  getInitialState: ->
    state =
      secondsElapsed: 0
      name: @props.name
    return state

  tick: ->
    @setState
      secondsElapsed: @state.secondsElapsed + 1

  onChange: (e) ->
    @setState
      name: e.target.value

  componentDidMount: ->
    @interval = setInterval @tick, 1000

  render: ->
    div {className: "outer"}, 
      h1 {ref: "header"}, "Hey #{@state.name} / #{@state.secondsElapsed}"
      input {type: "text", name: "name", onChange: @onChange}
      ul {},
        li {}, "One #{@state.secondsElapsed}"
        li {}, "Two #{@state.secondsElapsed}"
        li {}, "Three #{@state.secondsElapsed}"
      Inner
        name: @state.name
        secondsElapsed: @state.secondsElapsed


#--------------------------------------------------------
# Inner
#--------------------------------------------------------

Inner = React.createClass
  render: ->
    div {className: "inner"}, 
      h2 {}, "Name - #{@props.name}"
      a {href: "http://www.google.com", target: "_blank"}, "Link!"
      List
        secondsElapsed: @props.secondsElapsed


#--------------------------------------------------------
# List
#--------------------------------------------------------

List =  React.createClass
  render: ->
    ul {},
      li {}, "one #{@props.secondsElapsed}"
      li {}, "two #{@props.secondsElapsed}"
      li {}, "three #{@props.secondsElapsed}"


#--------------------------------------------------------
# DOM Ready
#--------------------------------------------------------
      
$ ->
  React.renderComponent Outer({name: "there"}), $("#content")[0]
