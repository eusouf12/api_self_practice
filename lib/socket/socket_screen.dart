import 'package:api_practice_app/socket/socket_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocketScreen extends StatelessWidget {
  SocketScreen({super.key});
  final SocketController controller = Get.put(SocketController());
  final TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(title: const Text("Socket.IO Chat Inbox")),
      body: SafeArea(
        child: Column(
          children: [
            /// Chat list
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    String msg = controller.messages[index];
                    bool isMe = msg.startsWith("You:");

                    if (isMe) {
                      msg = msg.replaceFirst("You:", "").trim();
                    }

                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          isMe ?CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.blue,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 16,
                              ),
                            ):SizedBox(),

                          SizedBox(width: 5,),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.all(12),
                            constraints: BoxConstraints(
                              maxWidth:
                              MediaQuery.of(context).size.width * 0.7,
                            ),
                            decoration: BoxDecoration(
                              color:
                              isMe ? Colors.blue[400] : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(msg,
                              style: TextStyle(color: isMe ? Colors.white : Colors.black87, fontSize: 16,),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),


            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: msgController,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: IconButton(
                      onPressed: () {
                        controller.sendMessage(msgController.text);
                        msgController.clear();
                      },
                      icon: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
