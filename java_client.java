package rpc;
 
import java.util.HashMap;
import java.util.Map;

import org.apache.thrift.TException;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.transport.TFramedTransport;
import org.apache.thrift.transport.TSocket;
import org.apache.thrift.transport.TTransport;
 
/**
 * Thrift test client
 */
public class Client {
 
	public static void main(String[] args) {
		
		long startTime = System.currentTimeMillis();
		try {
			TTransport transport = new TFramedTransport(new TSocket("localhost", 3232));
			
			TBinaryProtocol protocol = new TBinaryProtocol(transport);
			//TCompactProtocol protocol = new TCompactProtocol(transport);
			
			RpcService.Client client = new RpcService.Client(protocol);
			transport.open();
			
			// Map<String, String> param = new HashMap<String, String>();
			// param.put("name", "qinerg");
			// param.put("passwd", "123456");
			
			// for (int i = 0; i < 1000; i++) {
			// 	System.out.println(client.funCall(System.currentTimeMillis() , "login", param));
			// }
			
			System.out.println(client.GetName("hello java"));

			transport.close();
		} catch (TException x) {
			x.printStackTrace();
		}
		long endTime = System.currentTimeMillis();
		System.out.println(" aaaaaa:" + endTime + "   " + startTime + "  " + (endTime - startTime));
	}
}