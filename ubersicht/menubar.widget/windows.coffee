command: "echo $(/usr/local/bin/kwmc query window focused name)"

refreshFrequency: 1000 # ms

render: (output) ->
  "#{output}"

style: """
  -webkit-font-smoothing: antialiased
  color: #D6E7EE
  max-width: 800px;
  text-overflow: ellipsis
  font: 10px Monaco
  left: 40%
  overflow: hidden
  top: 2px
  width: auto
"""
