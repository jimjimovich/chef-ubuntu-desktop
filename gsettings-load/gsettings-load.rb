#!/usr/bin/ruby

configs = [
  {
    :schema => "org.gnome.libgnomekbd.keyboard",
    :key => "layouts",
    :value => "us",
    :type => "array",
    :append => true,
    :comment => 'Make sure US English keyboard is set'
  },
  {
    :schema => "org.gnome.libgnomekbd.keyboard",
    :key => "layouts",
    :value => "ru",
    :type => "array",
    :append => true,
    :comment => 'Add Russian keyboard (or any that you would like)'
  },
  {
    :schema => "org.gnome.libgnomekbd.keyboard",
    :key => "options",
    :value => 'grp\tgrp:alt_shift_toggle',
    :type => "array",
    :append => true,
    :comment => 'Set layout switching to Alt+Shift'
  },
  {
    :schema => "org.gnome.libgnomekbd.keyboard",
    :key => "options",
    :value => 'altwin\taltwin:swap_lalt_lwin',
    :type => "array",
    :append => true,
    :comment => 'Swap Alt and Left Win key (for Apple keyboard)'
  },
  {
    :schema => "com.canonical.indicator.datetime",
    :key => "show-day",
    :value => true,
    :type => "boolean",
    :comment => 'Show the day on the clock'
  },
  {
    :schema => "com.canonical.indicator.datetime",
    :key => "show-date",
    :value => true,
    :type => "boolean",
    :comment => 'Show the date on the clock'
  },
  {
    :schema => "com.canonical.indicator.datetime",
    :key => "show-locations",
    :value => true,
    :type => "boolean",
    :comment => 'Show other locations on clock indicator'
  },
  {
    :schema => "com.canonical.indicator.datetime",
    :key => "locations",
    :value => 'America/Indiana/Indianapolis Fort Wayne',
    :type => "array",
    :append => true,
    :comment => 'Add a location to to clock'
  },
  {
    :schema => "com.canonical.indicator.datetime",
    :key => "time-format",
    :value => "24-hour",
    :type => "string",
    :comment => 'Change clock to 24-hour format'
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
