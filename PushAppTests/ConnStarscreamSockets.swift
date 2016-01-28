import Starscream

public class ConnStarscreamSocket {
    var socket:WebSocket
    
    public init(urlString:String){
        let url = NSURL(string: urlString)
        socket = WebSocket(url: url!)
        
    }
    
    public func connect(completion:()->Void){
        socket.connect()
        socket.onConnect = {
            completion()
        }
    
    }
}