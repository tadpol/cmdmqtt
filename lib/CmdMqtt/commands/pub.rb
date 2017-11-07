require 'mqtt'

command :pub do |c|
  c.syntax = %{mqtt pub [<options>] <topic> (<message>|-)}
  c.option '--retain BOOL'
  c.option '--qos [0,1,2]'
  c.option '--record EOL'

  c.action do |args, options|
    options.defaults retain: false, qos: 0, record: $/
    #puts "h #{$cfg['net.host']} p #{$cfg['net.port']} u #{options.username} pw #{options.password}"
    MQTT::Client.connect(
      host: $cfg['net.host'],
      port: ($cfg['net.port'] or 8883).to_i,
      ssl: true,
      username: $cfg['mqtt.user'],
      password: $cfg['mqtt.password'],
      # TODO: add support for the other connection options.
    ) do |mq|

      if args[1] == '-' then
        # use STDIN
        # Option to publish on each line (or record)
        $stdin.each_line(options.record) do |line|
          mq.publish(args[0], line, options.retain, options.qos)
        end
      else
        mq.publish(args[0], args[1], options.retain, options.qos)
      end
    end
  end
end

#  vim: set ai et sw=2 ts=2 :
