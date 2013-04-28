# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gosu"
  s.version = "0.7.47.1"
  s.platform = "x86-mingw32"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Julian Raschke"]
  s.date = "2013-04-01"
  s.description = "  2D game development library.\n\n  Gosu features easy to use and game-friendly interfaces to 2D graphics\n  and text (accelerated by 3D hardware), sound samples and music as well as\n  keyboard, mouse and gamepad/joystick input.\n\n  Also includes demos for integration with RMagick, Chipmunk and OpenGL.\n"
  s.email = "julian@raschke.de"
  s.homepage = "http://www.libgosu.org/"
  s.rdoc_options = ["README.txt", "COPYING", "reference/gosu.rb", "reference/Drawing_with_Colors.rdoc", "reference/Order_of_Corners.rdoc", "reference/Tileability.rdoc", "reference/Z_Ordering.rdoc", "--title", "Gosu", "--main", "README.txt"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.2")
  s.rubygems_version = "1.8.25"
  s.summary = "2D game development library."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
