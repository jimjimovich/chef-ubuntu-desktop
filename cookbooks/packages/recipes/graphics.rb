# Install some graphics packages

base = %w(gimp inkscape)

base.each do |pkg|
  package pkg
end
