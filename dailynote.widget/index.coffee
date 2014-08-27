path = "<path>"     # enter the path to your dailynotes folder here;
                    # do not include a trailing slash

extension = '.txt'  # you could set this to md or something if you want
localtime = new Date()
year = localtime.getFullYear()
month = localtime.getMonth() + 1
month = ['0', month].join('') if month < 10
date = localtime.getDate()
date = [year, month, date].join('-')
filename = [date, extension].join('')
filepath = [path, filename].join('/')


command: "cat #{filepath}"
refreshFrequency: 3600000     # refresh every hour (3600k ms)

render: -> """
<h1 id="path"></h1>
  <div id="dailynote"></div>
"""

update: (output, domEl) ->
  # This relies on coreyti's showdown port, which you can find at
  # https://github.com/coreyti/showdown
  # it is included with the widget distribution
  $.getScript "dailynote.widget/assets/showdown.js", ->
    converter = new Showdown.converter()
    markdown = converter.makeHtml(output);
    $(domEl).find('#dailynote').html markdown

style: """
  @import url('dailynote.widget/assets/gfm.css');
  #dailynote {
    float:left;
    top:0;
  }
"""
