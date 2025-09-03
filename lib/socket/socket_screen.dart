// import 'package:api_practice_app/socket/socket_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class SocketScreen extends StatelessWidget {
//   SocketScreen({super.key});
//   final SocketController controller = Get.put(SocketController());
//   final TextEditingController msgController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.cyanAccent,
//       appBar: AppBar(title: const Text("Socket Chat Inbox")),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: Obx(()=> ListView.builder(
//                 padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                 itemCount: controller.messages.length,
//                 itemBuilder: (context,index) {
//                   String msg = controller.messages[index];
//                   bool isMe = msg.startsWith("You");
//                   if (isMe) {
//                     msg = msg.replaceFirst("You:", "").trim();
//                   }
//                   return Align(
//                     alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         !isMe ? CircleAvatar(
//                           radius: 14,backgroundColor: Colors.grey,
//                           child:  Icon(Icons.person,color: Colors.white,size: 16),
//                         ):SizedBox(),
//                         SizedBox(width: 5,),
//                         Container(
//                           margin:  EdgeInsets.symmetric(vertical: 4),
//                           padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                           decoration: BoxDecoration(
//                             color: isMe ? Colors.blue[400] : Colors.grey[300],
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Text(msg , style: TextStyle(
//                             color:  Colors.white ,
//                             fontSize: 16,
//                           ),),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               )),
//             ),
//             Padding(
//               padding:
//               const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: msgController,
//                       decoration: InputDecoration(
//                         hintText: "Type a message",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         contentPadding:  EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 10,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 5),
//                   CircleAvatar(
//                     backgroundColor: Colors.blue,
//                     child: IconButton(
//                       onPressed: () {
//                         controller.sendMessage(msgController.text);
//                         msgController.clear();
//                       },
//                       icon: const Icon(Icons.send, color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



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
      appBar: AppBar(title: const Text("Socket Chat Inbox")),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  String msg = controller.messages[index];
                  bool isMe = msg.startsWith("You");
                  if (isMe) {
                    msg = msg.replaceFirst("You:", "").trim();
                  }
                  else{
                    msg = msg.replaceFirst("You:", "").trim();
                  }
                  return Align(
                    alignment:
                    isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!isMe)
                          const CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person,
                                color: Colors.white, size: 16),
                          ),
                        const SizedBox(width: 5),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: isMe
                                ? Colors.blue[400]
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            msg,
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
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
