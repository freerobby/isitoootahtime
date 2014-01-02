require 'rubygems'
require 'bundler/setup'

require 'action_view'
require 'active_support/all'
require 'dotiw'
require 'sinatra'

include ActionView::Helpers::DateHelper

CREDITS_YES = <<-EOS
  <!--
    Site by Robby Grossman (http://rob.by).
    Unicorns supplied by Cornify (http://cornify.com).
    Project is open-sourced on github (http://github.com/freerobby/isitootahtime)
  -->
EOS


CREDITS_NO = <<-EOS
  <!--
    Site by Robby Grossman (http://rob.by).
    Project is open-sourced on github (http://github.com/freerobby/isitootahtime)
  -->
EOS
  

HEADER = '
<html>
  <head>
    <title>Is it Oootah time?</title>
  </head>
  <body>
'

GA = <<-EOS
  <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-46759284-1', 'isitoootahtime.herokuapp.com');
  ga('send', 'pageview');

</script>
EOS

FOOTER = '
  </body>
</html>
'

NO = <<-EOS
  #{HEADER}
  <div id="no" style="text-align: center; font-size: 6em;">not yet.</div><div id="details" style="text-align: center; display: block; margin-top: 50px;">{}</div>
  #{GA}
  #{FOOTER}
  #{CREDITS_NO}
EOS

YES = <<-EOS
  #{HEADER}
  <div id="yes" style="text-align: center; font-size: 6em;">yes!</div>
  <script type="text/javascript" src="/cornify.js"></script>
  <script language="javascript">
    for (var i = 0; i < 10; i++) {
      cornify_add();
    }
  </script>
  #{GA}
  #{FOOTER}
  #{CREDITS_YES}
EOS

get '/' do
  oootah_at = Time.new(2014, 1, 4)
  if Time.now >= oootah_at
    YES
  else
    NO.gsub('{}', distance_of_time_in_words_to_now(oootah_at))
  end
end
