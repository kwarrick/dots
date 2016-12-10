command: "pmset -g batt | egrep '([0-9]+\%).*' -o --colour=auto | cut -f1 -d';'"

refreshFrequency: 150000 # ms

render: (output) ->
  "bat <span>#{output}<span>"

style: """
  -webkit-font-smoothing: antialiased
  color: #FFFFFF
  font: 10px Monaco
  right: 130px
  top: 2px
  span
    color: #AFAFAF
"""
