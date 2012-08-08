#!/usr/bin/ruby

print "<html><head><title></title></head><body>"

xval = `ls ~/.thumbnails/normal/`.to_a
xval.each do |thumbnail|
	print "<img src='~/.thumbnails/normal/#{thumbnail}' />"
end

print "</body></html>"
