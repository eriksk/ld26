require 'rubygems'
require 'bundler/setup' # Releasy requires require that your application uses bundler.
require 'releasy'

Releasy::Project.new do
  name "Ludum Dare 26"
	version "0.0.1"
  #verbose # Can be removed if you don't want to see all build messages.

  executable "lib/ld26.rb"
	files ["lib/**/*.*"]
	exposed_files "README.md"
	add_link "http://skoggy.se/games/9", "Game site"
	exclude_encoding # Applications that don't use advanced encoding (e.g. Japanese characters) can save build size with this.
	
	# Create a variety of releases, for all platforms.
	add_build :osx_app do
		url "se.skoggy.ld26"
		wrapper "wrappers/gosu-mac-wrapper-0.7.44.tar.gz" # Assuming this is where you downloaded this file.
		#icon "media/icon.icns"
		add_package :tar_gz
	end
	
	add_build :source do
		add_package :"7z"
	end
	
	# If building on a Windows machine, :windows_folder and/or :windows_installer are recommended.
	add_build :windows_folder do
		#icon "content/icon.ico"
		executable_type :windows # Assuming you don't want it to run with a console window.
		add_package :exe # Windows self-extracting archive.
	end

	add_build :windows_installer do
		#icon "content/icon.ico"
		start_menu_group "Skoggy"
		readme "README.md" # User asked if they want to view readme after install.
		license "LICENSE.txt" # User asked to read this and confirm before installing.
		executable_type :windows # Assuming you don't want it to run with a console window.
		add_package :zip
	end
	
	# If unable to build on a Windows machine, :windows_wrapped is the only choice.
	add_build :windows_wrapped do
		wrapper "wrappers/ruby-1.9.3-p0-i386-mingw32.7z" # Assuming this is where you downloaded this file.
		executable_type :windows # Assuming you don't want it to run with a console window.
		exclude_tcl_tk # Assuming application doesn't use Tcl/Tk, then it can save a lot of size by using this.
		add_package :zip
	end
	
	add_deploy :local # Only deploy locally.
end
