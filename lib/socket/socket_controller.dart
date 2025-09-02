import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketController extends GetxController{
  late IO.Socket socket;
  final messages = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    connectToServer();
  }

  @override
  void onClose() {
    super.onClose();
    socket.dispose();
  }

  void connectToServer() {
    socket = IO.io('http://localhost:3000',
      IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
    );

    socket.connect();

    socket.onConnect((_) {print('Connected to server');});
    socket.on('chat_message', (data) {messages.add(data.toString());});
    socket.onDisconnect((_) => print('Disconnected from server'));
  }

  void sendMessage(String msg) {
    if (msg.isNotEmpty){
      socket.emit('chat_message', msg);
      messages.add("You: $msg");
    }
  }
}