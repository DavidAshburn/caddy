module NameHelper
	def shortmaker(longname)
		return longname.gsub(/\(.+\)/, '')
	end
	def shortmodel(longname)
		return longname.gsub(/originally\s/,"")
	end
end