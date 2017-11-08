require 'CmdMqtt/Config'

module CmdMqtt
  class ParamBuilder
    include Verbose
    def initialize(options)
      @h = {
        host: $cfg['net.host'],
        port: ($cfg['net.port'] or 8883).to_i,
        ssl: ($cfg['net.port'].to_i != 1883),
        username: $cfg['mqtt.user'],
        password: $cfg['mqtt.password'],
      }
      verbose @h
    end

    def to_h
      @h
    end
  end
end

#  vim: set ai et sw=2 ts=2 :
