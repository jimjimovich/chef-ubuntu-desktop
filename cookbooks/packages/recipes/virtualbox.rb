# Virtualbox
apt_repository "virtualbox" do
  uri "http://download.virtualbox.org/virtualbox/debian"
  distribution node['lsb']['codename']
  components ["contrib"]
  key "http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc"
end

package "virtualbox-4.2" do
  action :install
end
