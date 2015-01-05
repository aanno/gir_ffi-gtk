=begin
  calendar.rb - Gtk::Calendar sample script.

  Copyright (c) 2002-2006 Ruby-GNOME2 Project Team
  This program is licenced under the same licence as Ruby-GNOME2.

  $Id: calendar.rb,v 1.7 2006/06/17 13:18:12 mutoh Exp $
=end

require 'gir_ffi-gtk3'
# always needed
Gtk.init

cal = Gtk::Calendar.new

w = Gtk::Window.new(:toplevel)
w.name = "Calendar sample"
=begin
# TODO: chaining does NOT work
w.add(cal).show_all.signal_connect('delete_event') do
  Gtk.main_quit
end
=end
w.add(cal)
w.show_all
# TODO: delete_event is used in gtk3, but delete-event is used in gir_ffi-gtk3
w.signal_connect('delete-event') do
  Gtk.main_quit
end

date = Time.new

cal.select_month(date.month, date.year)
cal.select_day(date.day)
cal.mark_day(date.day)
#cal.clear_marks

#
# Gtk::Calendar::DisplayOptions::WEEK_START_MONDAY does not exist anymore
#

# TODO: set_display_options does not work
=begin
cal.set_display_options(Gtk::Calendar::DisplayOptions::SHOW_HEADING |
                Gtk::Calendar::DisplayOptions::SHOW_DAY_NAMES |
                Gtk::Calendar::DisplayOptions::NO_MONTH_CHANGE |
                Gtk::Calendar::DisplayOptions::SHOW_WEEK_NUMBERS)
=end
year, month, day = cal.date
puts "this is #{month} #{day}, #{year}"

cal.signal_connect('day-selected') do
  year, month, day = cal.date
  puts "selected day: #{day}"
end
cal.signal_connect('month-changed') do
  year, month, day = cal.date
  puts "changed month: #{month}"
end
cal.signal_connect('day-selected-double-click') do
  year, month, day = cal.date
  puts "dclicked day: #{day}"
end
cal.signal_connect('prev-month') do
  year, month, day = cal.date
  puts "prev month: #{month}"
end
cal.signal_connect('next-month') do
  year, month, day = cal.date
  puts "next_month: #{month}"
end
cal.signal_connect('prev-year') do
  year, month, day = cal.date
  puts "prev_year: #{year}"
end
cal.signal_connect('next-year') do
  year, month, day = cal.date
  puts "next year: #{year}"
end

Gtk.main
