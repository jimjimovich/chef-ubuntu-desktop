# Install a separate browser for FB

packages = %w(epiphany-browser)

packages.each do |pkg|
  package pkg
end

# Install Facebook "app" for each user
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
