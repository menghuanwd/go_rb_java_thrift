//RpcService.thrift
 
namespace go rpc
namespace java rpc
namespace rb rpc
// 测试服务
//service RpcService {
// 	string GetName(1:string name)
//}

struct Picture{
	1: i64 id
	2: string file_key
	3: string file_name
	4: i64 file_size
	5: string file_type
	6: string file_url
	7: string created_at
	8: string updated_at
}

service RpcService {
 	list<Picture> GetPicture()
 	//string GetName(1:string name)
}