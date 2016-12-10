command: "echo -n $(/usr/local/bin/kwmc query space active id)"

refreshFrequency: 500 # ms

render: (_) ->
  ("<span data-i=#{i}>#{i}</span>" for i in [1..6]).join("")

update: (output, domEl) ->
	$(domEl).children("span").css("background-color", "transparent")
	$(domEl).children("span[data-i=#{output}]").css("background-color", "#788585")

style: """
  -webkit-font-smoothing: antialiased
  color: #D6E7EE
  font: 10px Monaco
  left: 10px
  top: 2px
  span
	  padding: 1px 4px
"""
