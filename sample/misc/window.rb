#!/usr/bin/env ruby
=begin
  window.rb - Gtk::Window sample.

  Copyright (c) 2002-2006 Ruby-GNOME2 Project Team
  This program is licenced under the same licence as Ruby-GNOME2.

  $Id: window.rb,v 1.9 2006/10/21 16:58:00 mutoh Exp $
=end

require 'gir_ffi-gtk3'
# always needed
Gtk.init

window = Gtk::Window.new(:toplevel)
window.name = "Gtk::Window sample"
window.signal_connect("destroy"){Gtk.main_quit}

# TODO: Unsupported Hash/Map constructor
#button = Gtk::Button.new(:label => "Hello World")
button = Gtk::Button.new_with_label("Hello World")
button.signal_connect("clicked") do
  puts "hello world"
  Gtk.main_quit
end
window.add(button)
window.show_all

Gtk.main
