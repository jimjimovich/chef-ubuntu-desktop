# Install some media packages

packages = %w(ubuntu-restricted-extras vlc)

packages.each do |pkg|
  package pkg
end
