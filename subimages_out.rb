#!/usr/bin/ruby

require 'find'

print "<html><head><title></title></head><body>"

types = ["png","PNG","jpg","JPG","jpeg","JPEG","gif","GIF","bmp","BMP"]

Find.find('./') do |f|
	types.each do |type|
		xval = f.match(".#{type}")
		if not xval.nil?
			f.each do |thumbnail|
				print "<img src='/home/daniel/#{thumbnail}' />"
			end
		end
	end
end

print "</body></html>"
