<?php
 
//Reduce errors
error_reporting(~E_WARNING);

$addr = "127.0.0.1";
$port = 8905;
//Create a UDP socket
if(!($sock = socket_create(AF_INET, SOCK_DGRAM, 0)))
{
    $errorcode = socket_last_error();
    $errormsg = socket_strerror($errorcode);
     
    die("Couldn't create socket: [$errorcode] $errormsg \n");
}
 
echo "Socket created at $addr, port: $port \n";
 
// Bind the source address
if( !socket_bind($sock,  $addr, $port) )
{
    $errorcode = socket_last_error();
    $errormsg = socket_strerror($errorcode);
     
    die("Could not bind socket : [$errorcode] $errormsg \n");
}
 
echo "Socket bind OK \n";
 
//Do some communication, this loop can handle multiple clients
while(1)
{
    echo "Waiting for data ... \n";
     
    //Receive some data
    $r = socket_recvfrom($sock, $buf, 512, 0, $remote_ip, $remote_port);
    echo "$remote_ip : $remote_port -- " . $buf;
     
    //Send back the data to the client
    socket_sendto($sock, "OK " . $buf , 100 , 0 , $remote_ip , $remote_port);
}
 
socket_close($sock);
