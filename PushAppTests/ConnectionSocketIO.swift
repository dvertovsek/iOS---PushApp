import SocketIOClientSwift

public class ConnectionSocketIO {
    var socket:SocketIOClient
    
    public init(urlString:String){
        
        socket = SocketIOClient(socketURL: urlString)
        
    }
    
    public func connect(completion:()->Void){
        socket.connect()
        socket.on("connect"){
            _,_ in
            completion()
        }
    }
}