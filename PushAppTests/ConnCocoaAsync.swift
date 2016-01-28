import CocoaAsyncSocket

public class ConnCocoaAsync {
    var socket:GCDAsyncUdpSocket!
    
    public init(server:String,port:UInt16){

        socket = GCDAsyncUdpSocket(delegate: self, delegateQueue: dispatch_get_main_queue())
        do{
            try socket.bindToPort(port)
            try socket.connectToHost(server, onPort: port)
            try socket.beginReceiving()
        } catch{
            print("errore")
        }
        
    }
    
    public func send(msg:String){
       let data = msg.dataUsingEncoding(NSUTF8StringEncoding)
        socket.sendData(data, withTimeout: 2, tag: 0)
    }
}