import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient{
  IO.Socket? socket;
  static SocketClient? _instance;

  // SocketClient._internal(){
  //   socket = IO.io('http://192.168.171.122:3000',<String,dynamic>{
  //     'transports':['websocket'],
  //     'autoConnect': false,
  //   });
  //   socket!.connect();
  // }
  SocketClient._internal(){
    socket = IO.io('https://type-racer-server-d26c3cfd1498.herokuapp.com/',<String,dynamic>{
      'transports':['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }

  static SocketClient get instance{
     _instance??=SocketClient._internal();
     return _instance!;
  }
}