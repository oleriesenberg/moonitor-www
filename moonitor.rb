require 'atchoum'

class Moonitor < Atchoum::Website
  ROOT = ENV['SITE_ROOT'] || ''

  def layout
    xhtml_html do
      head do
        title 'Moonitor :: gentoo linux emerge monitor and overlay'
        link :rel => 'stylesheet', :href => "#{ROOT}/base.css", :type => 'text/css'
      end
      body do
        div.container! do
          div.header! do
            img.logo! :src => "/logo.jpg"
          end

          div.navbar! do
            ul.menu! do
              li { a 'moonitor', :href => "#{ROOT}/" }
              li { a 'overlay', :href => "#{ROOT}/overlay/" }
            end
          end
          div.content! do
            self << yield
          end
 
          div.footer! do
            text "&copy; 2008 Ole Riesenberg | Logo &copy; 2008 N. Kittel"
          end
        end
      end
    end
  end

  def index_page
    p.what "What is Moonitor?"
      text "Moonitor is a dbus monitoring suite for emerge with KDE panel support, a Qt Widget and an ncurses CLI."


    p.what "Get it"
      text "You can clone the code directly from our git repository" 
      code "git clone git://moonitor.org/moonitor.git"
      
      br
      text "or install it from our overlay"
      code "layman -f -o http://moonitor.org/moonitor.xml -a moonitor"
      code "sudo emerge app-portage/moonitor" 

    p.what "How to contribute?"
      text "Our Bugtracker is available at " 
      a(:href => "http://trac.moonitor.org/") { "trac.moonitor.org" }
  end

  def overlay_page
    p.what "What is Moonitor?"
    text "Moonitor is a dbus monitoring suite for emerge with KDE panel support, a Qt Widget and an ncurses CLI."


    p.what "Get it"
      text "You can clone the code directly from our git repository" 
      code "git clone git://moonitor.org/moonitor.git"
      
      br
      text "or install it from our overlay"
      code "layman -f -o http://moonitor.org/moonitor.xml -a moonitor"
      code "sudo emerge app-portage/moonitor" 
  end
end