// import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
//
// class SocketController extends GetxController{
//   late IO.Socket socket;
//   final messages = [].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     connectToServer();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//     socket.dispose();
//   }
//
//   void connectToServer() {
//     socket = IO.io('://heritage-despite-relaxation-became.trycloudflare.com',
//       IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
//     );
//
//     socket.connect();
//     socket.onConnect((_) {print('Connected to server');});
//     socket.on('chat_message', (data) {messages.add(data.toString());});
//     socket.onDisconnect((_) => print('Disconnected from server'));
//   }
//
//   void sendMessage(String msg) {
//     if (msg.isNotEmpty){
//       socket.emit('chat_message', msg);
//       messages.add("You: $msg");
//     }
//   }
// }






import 'dart:convert';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class SocketController extends GetxController {
  late IOWebSocketChannel channel;
  final messages = <String>[].obs;   // 👈 still a List<String>

  final String channelName =
      "68977c850e8c0131d235e30768977c850e8c0131d235e307";
  final String senderId = "68aa1c7fd91aea4adaf13b90";

  @override
  void onInit() {
    super.onInit();
    connectToServer();
  }

  @override
  void onClose() {
    channel.sink.close(status.goingAway);
    super.onClose();
  }

  void connectToServer() {
    channel = IOWebSocketChannel.connect(
      "wss://heritage-despite-relaxation-became.trycloudflare.com",
    );

    channel.stream.listen((event) {
      try {
        print("📥 Raw incoming event: $event");
        final data = jsonDecode(event);
        print("📥 Decoded JSON: $data");

        if (data is Map && data["type"] == "message") {
          final msgObj = data["data"] ?? data;   // 👈 handles both formats
          final sender = msgObj["senderId"] ?? "Unknown";
          final message = msgObj["message"] ?? "";
          messages.add("$sender: $message");
        } else if (data is Map && data["type"] == "subscribe") {
          // ignore or handle subscribe ack
          print("✅ Subscribed successfully: $data");
        } else {
          messages.add(data.toString());
        }
      } catch (e) {
        print("❌ Parse error: $event");
        messages.add(event.toString());
      }
    });

    // subscribe
    final subscribePayload = {
      "type": "subscribe",
      "channelName": channelName,
      "senderId": senderId,
    };
    channel.sink.add(jsonEncode(subscribePayload));
    print("📡 Subscribed: $subscribePayload");
  }

  void sendMessage(String msg) {
    if (msg.isEmpty) return;

    final payload = {
      "type": "message",
      "channelName": channelName,
      "senderId": senderId,
      "message": msg,
      "files": []
    };
    channel.sink.add(jsonEncode(payload));
    messages.add("You: $msg");   // 👈 always String
    print("📤 Sent: $payload");
  }
}
