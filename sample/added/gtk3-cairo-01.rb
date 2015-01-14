=begin
  Minimal Gtk3 Cairo drawing.
  
  Based on:
  http://www.gtkforums.com/viewtopic.php?f=3&t=988&p=195286=Drawing%20with%20Cairo%20in%20GTK3#p195286
  by zerohour
  
  Adapted to Ruby and gir_ffi-gtk by Thomas Pasch. 
=end

=begin
 Original code:
 
/* COMPILE USING:  gcc `pkg-config --cflags gtk+-3.0` -o gtk3-cairo-01 gtk3-cairo-01.c `pkg-config --libs gtk+-3.0` */
#include <gtk/gtk.h>

#define WINDOW_WIDTH  300
#define WINDOW_HEIGHT 300

static gboolean draw_cb(GtkWidget *widget, cairo_t *cr, gpointer data)
{   
   /* Set color for background */
   cairo_set_source_rgb(cr, 1, 1, 1);
   /* fill in the background color*/
   cairo_paint(cr);
     
   /* set color for rectangle */
   cairo_set_source_rgb(cr, 0.42, 0.65, 0.80);
   /* set the line width */
   cairo_set_line_width(cr,6);
   /* draw the rectangle's path beginning at 3,3 */
   cairo_rectangle (cr, 3, 3, 100, 100);
   /* stroke the rectangle's path with the chosen color so it's actually visible */
   cairo_stroke(cr);

   /* draw circle */
   cairo_set_source_rgb(cr, 0.17, 0.63, 0.12);
   cairo_set_line_width(cr,2);
   cairo_arc(cr, 150, 210, 20, 0, 2*G_PI);
   cairo_stroke(cr);

   /* draw horizontal line */
   cairo_set_source_rgb(cr, 0.77, 0.16, 0.13);
   cairo_set_line_width(cr, 6);
   cairo_move_to(cr, 80,160);
   cairo_line_to(cr, 200, 160);
   cairo_stroke(cr);

   return FALSE;
}

int main (int argc, char *argv[])
{
   GtkWidget *window;
   GtkWidget *da;

   gtk_init (&argc, &argv);

   window = gtk_window_new (GTK_WINDOW_TOPLEVEL);
   g_signal_connect (window, "destroy", G_CALLBACK (gtk_main_quit), NULL);

   da = gtk_drawing_area_new();
   gtk_widget_set_size_request (da, WINDOW_WIDTH, WINDOW_HEIGHT);
   g_signal_connect (da, "draw", G_CALLBACK(draw_cb),  NULL);

   gtk_container_add (GTK_CONTAINER (window), da);
   gtk_widget_show(da);
   gtk_widget_show (window);

   gtk_main ();

   return 0;
} 
=end

require 'gir_ffi-gtk3'
require 'gir_ffi-cairo'
# always needed
Gtk.init

# TODO: real Pixbuf support
GirFFI.setup :Gdk
GirFFI.setup :GdkPixbuf

window = Gtk::Window.new :toplevel
window.name = "minimal Gtk3 Cairo drawing test"
window.signal_connect("destroy") { 
  Gtk.main_quit 
}

da = Gtk::DrawingArea.new 
da.set_size_request 300, 300
da.signal_connect("draw") { |area, cairo_context, data|
                            
  # Set color for background
  cairo_context.set_source_rgb 1.0, 1.0, 1.0 
  # fill in the background color
  cairo_context.paint
     
  # set color for rectangle
  cairo_context.set_source_rgb 0.42, 0.65, 0.80
  # set the line width
  cairo_context.set_line_width 6.0
  # draw the rectangle's path beginning at 3,3
  cairo_context.rectangle 3.0, 3.0, 100.0, 100.0
  # stroke the rectangle's path with the chosen color so it's actually visible
  cairo_context.stroke

  # draw circle
  cairo_context.set_source_rgb 0.17, 0.63, 0.12
  cairo_context.set_line_width 2.0
  # cairo_context.cairo_arc 150, 210, 20, 0, 2*G_PI
  cairo_context.arc 150.0, 210.0, 20.0, 0.0, 2 * 3.1415
  cairo_context.stroke

  # draw horizontal line
  cairo_context.set_source_rgb 0.77, 0.16, 0.13
  cairo_context.set_line_width 6.0
  cairo_context.move_to 80.0, 160.0
  cairo_context.line_to 200.0, 160.0
  cairo_context.stroke

  false
}

window.add(da)
window.show_all

Gtk::main
