# Minimal Cairo PNG drawing.
#
# Based on:
# http://zetcode.com/gfx/cairo/cairobackends/
# by Jan Bodnar
#
# Adapted to Ruby and gir_ffi-gtk by Thomas Pasch. 

require 'gir_ffi-cairo'

# surface = Cairo::ImageSurface.create Cairo::Format::CAIRO_FORMAT_ARGB32, 390, 60
surface = Cairo::ImageSurface.create 0, 390, 60
# cr = Cairo::Context.create surface
cr = Cairo::Context.create surface

puts "cr=", cr, "surface=", surface

cr.set_source_rgb 0, 0, 0
cr.select_font_face "Sans", 0, 0
cr.set_font_size 40.0

cr.move_to 10.0, 50.0
cr.show_text "Disziplin ist Macht."

cr.surface_write_to_png surface, "cairo-png-01 cairo-png-01"
cr.destroy 
surface.cairo_surface_destroy
