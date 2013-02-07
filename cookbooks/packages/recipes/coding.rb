# Install some packages for coding Ruby, etc.

packages = %w(build-essential git-core ruby)

packages.each do |pkg|
  package pkg
end
