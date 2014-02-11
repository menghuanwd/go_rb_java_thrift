package main

import (
	"./gen-go/rpc"
	"fmt"
	"git.apache.org/thrift.git/lib/go/thrift"
	"os"
)

const (
	NetworkAddr = "127.0.0.1:3232"
)

type RpcServiceImpl struct {
}

func (this *RpcServiceImpl) GetName(name string) (r string, err error) {
	r = "guyifeng" + name
	return
}

func main() {
	transportFactory := thrift.NewTFramedTransportFactory(thrift.NewTTransportFactory())
	protocolFactory := thrift.NewTBinaryProtocolFactoryDefault()

	serverTransport, err := thrift.NewTServerSocket(NetworkAddr)
	if err != nil {
		fmt.Println("Error!", err)
		os.Exit(1)
	}

	handler := &RpcServiceImpl{}
	processor := rpc.NewRpcServiceProcessor(handler)

	server := thrift.NewTSimpleServer4(processor, serverTransport, transportFactory, protocolFactory)
	fmt.Println("thrift server in", NetworkAddr)
	server.Serve()
}
