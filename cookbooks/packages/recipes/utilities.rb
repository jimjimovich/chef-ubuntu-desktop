# Install some utility packagse

base = %w(keepassx)

base.each do |pkg|
  package pkg
end
