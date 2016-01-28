//
//  ConnectionSocketIO.swift
//  PushApp
//
//  Created by MTLab on 28/01/16.
//  Copyright © 2016 dare. All rights reserved.
//
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