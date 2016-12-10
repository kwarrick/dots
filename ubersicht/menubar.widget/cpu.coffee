command: "ESC=`printf \"\e\"`; uptime | cut -d, -f4 | cut -d: -f2"

refreshFrequency: 2000 # ms

render: (output) ->
  "cpu <span>#{output}</span>"

style: """
  -webkit-font-smoothing: antialiased
  color: #FFFFFF
  font: 10px Monaco
  right: 200px
  top: 2px
  span
    color: #AFAFAF
"""
