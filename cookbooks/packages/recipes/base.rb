# Install some base packages 

base = %w(openssh-server curl)

base.each do |pkg|
  package pkg
end
