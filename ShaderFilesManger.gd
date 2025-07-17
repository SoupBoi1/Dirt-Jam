class_name GlslFile

#var _path: String
#var _dependacies: PackedStringArray

#func _init(path: String, dependacy_folder: PackedStringArray=PackedStringArray([""]),IncluedFileParent: bool = true):
#	_path = path
#	_dependacies =dependacy_folder
""" Takes a block of text and the word we need to detech 
if the word is there it will
output intger array with the start and end indexes of the each lines"""
static func indexs_of_lines_with_the_word(Words:String,theword:String) -> PackedInt32Array:
	var i =0
	var replaceing =-1
	var content = Words
	var int_arr = PackedInt32Array([])
	while content.findn(theword,i) >-1:
		
		i = content.findn(theword,i)
		int_arr.append(i)
		replaceing = content.findn("\n",i)
		int_arr.append(replaceing)
		i=replaceing
	return int_arr
	
static func get_filename(path:String)->String:
	var tem_name=""
	for i in range(path.length()-1,0):
		if(path[i]=="/"):
			return tem_name
		tem_name+=path[i]
	return path
			
"""
This is the main function of the Class
right now takes the script path and and the depency path 
it take only one depenency adn is expected to have ONLY ONE! #include line the path scpript
"""
static func open(path: String,dependacies: String)-> String:
	var file =FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	

	var indexs = indexs_of_lines_with_the_word(content,"#include")
	for i in range(0,indexs.size(),2):
		content = content.substr(0,indexs[i]) + get_dependency(dependacies)+ content.substr(indexs[i+1])
	#print("\n\n\n\n\n")
	#print(content)
	return content
	 
	
"""
gets the take of code with out vision """
static func get_dependency(dependency_path: String ) -> String:
	var file =FileAccess.open(dependency_path, FileAccess.READ)
	var content = file.get_as_text()
	
	#remove the lines with #version
	var indexs = indexs_of_lines_with_the_word(content,"#version")
	for i in range(0,indexs.size(),2):
		content = content.substr(0,indexs[i]) +content.substr(indexs[i+1]) 
	
	return content


	
