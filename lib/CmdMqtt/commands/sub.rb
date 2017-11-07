require 'mqtt'

command :sub do |c|
  c.syntax = %{mqtt sub [<options>] <topics…>}
  c.action do |args, options|
    #puts "h #{$cfg['net.host']} p #{$cfg['net.port']} u #{options.username} pw #{options.password}"
    MQTT::Client.connect(
      host: $cfg['net.host'],
      port: ($cfg['net.port'] or 8883).to_i,
      ssl: true,
      username: $cfg['mqtt.user'],
      password: $cfg['mqtt.password'],
    ) do |mq|
      mq.subscribe(args) unless args.empty?
      mq.get do |topic, message|
        puts "#{topic} => #{message}"
        # json output? {"<topic>": "<message>"}
      end
    end
  end
end

#  vim: set ai et sw=2 ts=2 :
