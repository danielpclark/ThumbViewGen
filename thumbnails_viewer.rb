#!/usr/bin/ruby

require 'tk'
require 'tkextlib/tkimg'

class Thumbnails_Viewer
	def initialize(filelist)
		setup_viewer(filelist)
	end
	def run
		Tk.mainloop
	end
	def setup_viewer(filelist)
		@root = TkRoot.new {title 'Scroll List'}
		frame = TkFrame.new(@root)
		
		image_w = TkPhotoImage.new
		TkLabel.new(frame) do
			image image_w
			pack 'side'=>'right'
		end
		list_w = TkListbox.new(frame) do
			selectmode 'single'
			pack 'side' => 'left'
		end
		list_w.bind("ButtonRelease-1") do
			busy do
				filename = list_w.get(*list_w.curselection)
				tmp_img = TkPhotoImage.new('file'=>filename)
				scale = tmp_img.height / 100
				scale = 1 if scale < 1
				image_w.copy(tmp_img, 'subsample' => [scale, scale])
				tmp_img = nil
				image_w.pack
			end
		end
		filelist.each do |name|
			list_w.insert('end', name) # Insert each file name into the list
		end
		scroll_bar = TkScrollbar.new(frame) do
			command {|*args| list_w.yview *args }
			pack	'side' => 'left', 'fill' => 'y'
		end
		list_w.yscrollcommand {|first,last| scroll_bar.set(first,last) }
		frame.pack
	end
	
	# Run a block with a 'wait' cursor
	def busy
		@root.cursor "watch" # Set a watch cursor
		yield
	ensure
		@root.cursor "" # Back to orignial
	end
end

viewer = Thumbnails_Viewer.new(Dir["/home/daniel/.thumbnails/normal/*.png"])
viewer.run
