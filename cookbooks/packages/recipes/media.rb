# Install some media packages

base = %w(ubuntu-restricted-extras vlc)

base.each do |pkg|
  package pkg
end
