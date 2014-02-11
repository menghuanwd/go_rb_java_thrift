require 'thrift'
$:.unshift File.dirname(__FILE__) + "/gen-rb"
require 'rpc_service'

class Client
  def initialize(port)
    @host = '127.0.0.1'
    @port = port || 3242
  end

  def run
    socket = Thrift::Socket.new(@host, @port)
    transport = Thrift::FramedTransport.new(socket)
    protocol = Thrift::BinaryProtocol.new(transport)
    client = Rpc::RpcService::Client.new(protocol)
    begin
      start = Time.now
      transport.open
    rescue => e
      print_exception e
    else
      begin
        time1 = Time.now
        puts a = client.GetName("aaa")

        puts Time.now - time1
        transport.close
      rescue Thrift::TransportException => e
        print_exception e
      end
    end
  end

  def print_exception(e)
    STDERR.puts "ERROR: #{e.message}"
    STDERR.puts "\t#{e.backtrace * "\n\t"}"
  end
end

port = ARGV[0]

Client.new(port).run
