require 'atchoum'

class Moonitor < Atchoum::Website
  def layout
    xhtml_html do
      head do
        title 'Moonitor :: gentoo linux emerge monitor and overlay'
        link :rel => 'stylesheet', :href => "/base.css", :type => 'text/css'
      end
      body do
        div.container do
          div.header do
            img.logo :src => "/logo.jpg"
          end

          div.navbar do
            ul.menu do
              li { a 'moonitor', :href => "/" }
              li { a 'overlay', :href => "/overlay/" }
            end
          end
          div.content do
            self << yield
          end
 
          div.footer do
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
    p.what "What can be found in the overlay?"
      text "The overlay currently contains ebuilds of moonitor and some ruby stuff."


    p.what "How to fetch it?"
      text "You can fetch the overlay via layman"
      code "layman -f -o http://moonitor.org/moonitor.xml -a moonitor"
      
      br
      text "or do it manually"
      code "cd /usr/portage/local"
      code "git clone git://moonitor.org/overlay.git" 
      code 'echo "PORTDIR_OVERLAY=\"/usr/portage/local/layman/moonitor\"" >> /etc/make.conf'
  end
end