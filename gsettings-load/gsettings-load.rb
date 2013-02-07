#!/usr/bin/ruby

configs = [
  {
    :schema => "org.gnome.libgnomekbd.keyboard",
    :key => "layouts",
    :value => "us",
    :type => "array",
    :append => true
  },
  {
    :schema => "org.gnome.libgnomekbd.keyboard",
    :key => "layouts",
    :value => "ru",
    :type => "array",
    :append => true
  },
  {
    :schema => "org.gnome.libgnomekbd.keyboard",
    :key => "options",
    :value => 'grp\tgrp:alt_shift_toggle',
    :type => "array",
    :append => true
  },
  {
    :schema => "org.gnome.libgnomekbd.keyboard",
    :key => "options",
    :value => 'altwin\taltwin:swap_lalt_lwin',
    :type => "array",
    :append => true
  }
]

configs.each do |config|
  # get the current settings
  before = `/usr/bin/gsettings get #{config[:schema]} #{config[:key]}`

  case config[:type]
  when "array"
    before = before.gsub(/^[^\[]*/, '').gsub('[', '').gsub(']', '').gsub("'", "").chomp.split(', ')

    if config[:append]
      unless before.include? config[:value]
        after = before << config[:value]
      else
        after = before
      end
    else
      after = config[:value].to_a
    end

    command = "/usr/bin/gsettings set #{config[:schema]} #{config[:key]} \"['#{after.join("','")}']\""
  when "string"
    command = "/usr/bin/gsettings set #{config[:schema]} #{config[:key]} \"#{config[:value]}\""
  when "boolean"
    command = "/usr/bin/gsettings set #{config[:schema]} #{config[:key]} #{config[:value]}"
  when "integer"
    command = "/usr/bin/gsettings set #{config[:schema]} #{config[:key]} #{config[:value]}"
  else
    puts "Type not know!"
  end

  system(command)
end
