//package demo.rpc;
 
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
 
import org.apache.thrift.TException;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.protocol.TBinaryProtocol.Factory;
import org.apache.thrift.server.TNonblockingServer;
import org.apache.thrift.server.TServer;
import org.apache.thrift.transport.TNonblockingServerSocket;
import org.apache.thrift.transport.TNonblockingServerTransport;
import org.apache.thrift.transport.TTransportException;
 
/**
 * Thrift server
 */
public class Server implements RpcService.Iface {
 
	public static void main(String[] as) {
		TNonblockingServerTransport serverTransport = null;
		try {
			serverTransport = new TNonblockingServerSocket(3252);
		} catch (TTransportException e) {
			e.printStackTrace();
		}
 
		RpcService.Processor<RpcService.Iface> processor = new RpcService.Processor<RpcService.Iface>(
				new Server());
 
		Factory protFactory = new TBinaryProtocol.Factory(true, true);
		//TCompactProtocol.Factory protFactory = new TCompactProtocol.Factory();
 
		TNonblockingServer.Args args = new TNonblockingServer.Args(
				serverTransport);
		args.processor(processor);
		args.protocolFactory(protFactory);
		TServer server = new TNonblockingServer(args);
		System.out.println("Start server on port 3252 ...");
		server.serve();
	}
 
	@Override
	public String GetName(String name) throws TException {
		return name+" guyifeng oo99ii";
	}
}