# Install a separate browser for FB

package "epiphany-browser" do
  action :install
end

# Install a skeleton Facebook "application" for each user with user id between 1000 and 1099
node['etc']['passwd'].each do |user, data|
  if data['uid'].to_i >= 1000 && data['uid'].to_i < 1100 then

    directory "/home/#{user}/.gnome2/epiphany" do
      mode 00770
      owner user
		  group user
      action :create
    end

    directory "/home/#{user}/.gnome2/epiphany/app-epiphany-facebook" do
      mode 00770
      owner user
		  group user
      action :create
    end

    template "/home/#{user}/.local/share/applications/epiphany-facebook.desktop" do
      source "epiphany-facebook.desktop.erb"
      mode 0770
		  owner user
		  group user
		  variables({
		    :user => user
		  })
    end

    cookbook_file "/home/#{user}/.gnome2/epiphany/app-epiphany-facebook/facebook.png" do
      source "facebook.png"
      mode 0770
		  owner data['uid']
		  group data['uid']
    end

  end
end
