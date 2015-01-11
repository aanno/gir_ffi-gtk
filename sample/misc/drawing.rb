=begin
  drawing.rb - Gtk::Drawing sample script.

  Copyright (c) 2002-2006 Ruby-GNOME2 Project Team
  This program is licenced under the same licence as Ruby-GNOME2.

  $Id: drawing.rb,v 1.7 2006/06/17 13:18:12 mutoh Exp $
=end

require 'gir_ffi-gtk3'
# always needed
Gtk.init

# TODO: real Pixbuf support
GirFFI.setup :Gdk
GirFFI.setup :GdkPixbuf

# TODO: inheritance
class Canvas < Gtk::DrawingArea
  
  def initialize
    super
    @buffer = nil
    @bgc = nil
  end
  
  def init2
    signal_connect("draw") { |w,e| expose_event(w,e) }
    signal_connect("configure-event") { |w, e| configure_event(w,e) }
  end

  def expose_event(w,e)
    unless @buffer.nil?
      rec = e.area
      w.window.draw_drawable(@bgc, @buffer, rec.x, rec.y,
			   rec.x, rec.y, rec.width, rec.height)
    end
    false
  end

  def clear(b = @buffer)
    return if b.nil?

    g = b.size
    @bgc = self.style.bg_gc(self.state) if @bgc.nil?
    if (g[0] > 0 && g[1] > 0)
      b.draw_rectangle(@bgc, true, 0,0, g[0], g[1])
    end
  end

  def configure_event(w,e)
    g = w.window.geometry
    if (g[2] > 0 && g[3] > 0)
      # TODO: Gdk::Pixmap has been replaced by cairo surfaces
      # see https://developer.gnome.org/gtk3/stable/ch25s02.html#id-1.6.3.4.5
      # b = Gdk::Pixmap::new(w.window, g[2], g[3], -1)
      b = GdkPixbuf::Pixbuf.new(w.window, g[2], g[3], -1)
      clear(b)
      if not @buffer.nil?
        g = @buffer.size
        b.draw_drawable(@bgc, @buffer, 0, 0, 0, 0, g[0], g[1])
      end
      @buffer = b
    end
    true
  end
end

# TODO: inheritance
class A < Canvas
  
  def initialize
    super
  end
    
  def init2
    super   
    signal_connect("button-press-event") { |w,e| pressed(w,e) }
    # TODO: set_events
    # set_events(Gdk::Event::BUTTON_PRESS_MASK)
    # set_events(:button_press_mask)
  end

  def pressed(widget, ev)
    if not @last.nil?
      @buffer.draw_line(widget.style.fg_gc(widget.state),
			@last.x, @last.y, ev.x, ev.y)

      x1,x2 = if (@last.x < ev.x)
	      then [@last.x, ev.x]
	      else [ev.x, @last.x]
	      end
      y1,y2 = if (@last.y < ev.y)
  	    then [@last.y, ev.y]
	      else [ev.y, @last.y]
	      end
      widget.queue_draw_area(x1, y1, x2 - x1 + 1, y2 - y1 + 1)
    end
    @last = nil
    @last = ev
    true
  end
end

window = Gtk::Window.new :toplevel
window.name = "drawing test"
window.signal_connect("destroy") { Gtk.main_quit }

canvas = A.new
# TODO: Avoid init2 for inheritance
canvas.init2
window.add(canvas)

window.show_all
Gtk::main
