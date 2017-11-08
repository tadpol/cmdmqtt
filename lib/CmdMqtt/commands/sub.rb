require 'mqtt'

command :sub do |c|
  c.syntax = %{mqtt sub [<options>] <topics…>}
  c.action do |args, options|
    params = CmdMqtt::ParamBuilder.new(options)
    MQTT::Client.connect(params.to_h) do |mq|
      mq.subscribe(args) unless args.empty?
      mq.get do |topic, message|
        puts "#{topic} => #{message}"
        # json output? {"<topic>": "<message>"}
      end
    end
  end
end

#  vim: set ai et sw=2 ts=2 :
