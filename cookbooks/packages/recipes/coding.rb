# Install some packages for coding Ruby, etc.

base = %w(build-essential git-core)

base.each do |pkg|
  package pkg
end
