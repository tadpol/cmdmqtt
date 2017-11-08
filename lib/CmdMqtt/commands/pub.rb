require 'mqtt'

command :pub do |c|
  c.syntax = %{mqtt pub [<options>] <topic> (<message>|-)}
  c.option '--retain BOOL'
  c.option '--qos [0,1,2]'
  c.option '--record EOL'

  c.action do |args, options|
    options.defaults retain: false, qos: 0, record: $/
    params = CmdMqtt::ParamBuilder.new(options)
    MQTT::Client.connect(params.to_h) do |mq|
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
