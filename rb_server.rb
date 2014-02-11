require 'thrift'

$:.unshift File.dirname(__FILE__) + "/gen-rb"
require 'rpc_service'

module Server

  include Thrift

  class MessageHandler

    def GetName(name)
    	puts "aaaa"
      return name + " hello world"
    end
    
  end

  def self.start_server(host, port, serverClass)
    handler = MessageHandler.new
    processor = Rpc::RpcService::Processor.new(handler)
    transport = ServerSocket.new(host, port)
    transport_factory = FramedTransportFactory.new
    args = [processor, transport, transport_factory, nil]
    if serverClass == NonblockingServer
      logger = Logger.new(STDERR)
      logger.level = Logger::WARN
      args << logger
    end
    server = serverClass.new(*args)
    @server_thread = Thread.new do
      server.serve
    end
    @server = server
    puts 'work'
  end

  def self.shutdown
    return if @server.nil?
    if @server.respond_to? :shutdown
      @server.shutdown
    else
      @server_thread.kill
    end
  end
end

def resolve_const(const)
  const and const.split('::').inject(Object) { |k,c| k.const_get(c) }
end

host = '127.0.0.1'
port = ARGV[0] || 3242

#serverklass = 'Thrift::SimpleServer'
#serverklass = 'Thrift::ThreadedServer'
serverklass = 'Thrift::ThreadPoolServer'
#serverklass = 'Thrift::NonblockingServer'

Server.start_server(host, port.to_i, resolve_const(serverklass))
# let our host know that the interpreter has started
# ideally we'd wait until the server was serving, but we don't have a hook for that

puts "server start on #{host}:#{port}"

STDOUT.flush

Marshal.load(STDIN) # wait until we're instructed to shut down

Server.shutdown

puts "server shutdown"

