
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';


import '../../../controllers/components/receving_container.dart';
import '../../../controllers/components/sending_container.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late GoogleMapController mapController;
  final LatLng _initialPosition = LatLng(37.7749, -122.4194);
  TextEditingController messageController = TextEditingController();
  final List<Message> chatMessages = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          /// Map container
          Container(
            height: height * 0.25,
            width: width,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 12.0,
              ),
              zoomControlsEnabled: false,
              myLocationEnabled: true,
            ),
          ),

          /// Chat screen container
          Padding(
            padding: EdgeInsets.only(top: height * 0.19),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  /// Chat Messages List
                  Expanded(
                    flex: 81,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      itemCount: chatMessages.length,
                      itemBuilder: (context, index) {
                        var message = chatMessages[index];
                        return message.isSender
                            ? SendingContainer(text: message.text)
                            : RecevingContainer(text: message.text);
                      },
                    ),
                  ),

                  /// Message Input Row
                  Expanded(
                    flex: 16,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 80,
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                hintText: 'Message your driver',
                                suffixIcon: Icon(Icons.insert_link_rounded),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.01),
                          Expanded(
                            flex: 20,
                            child: InkWell(
                              onTap: _sendMessage,
                              child: CircleAvatar(
                                radius: width * 0.06,
                                child: Icon(Icons.send, color: Colors.white),
                                backgroundColor: Appcolor.yellow,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Back Button Positioned
          Positioned(
            left: width * 0.88,
            top: height * 0.13,
            child: InkWell(
            onTap: (){Navigator.pop(context);},
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.background,
              child:ImageIcon(AssetImage(Appimages.exit),color: Theme.of(context).colorScheme.secondary,)
            ),
          ),)
        ],
      ),
    );
  }

  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        chatMessages.add(Message(text: messageController.text, isSender: true));
      });
      messageController.clear();
    }
  }
}

class Message {
  final String text;
  final bool isSender;
  Message({required this.text, required this.isSender});
}



// import 'package:flutter/cupertino.dart';
// import 'package:ryde/src/controllers/components/receving_container.dart';
// import 'package:ryde/src/controllers/components/sending_container.dart';
// import 'package:ryde/src/controllers/constants/linker.dart';
//
// class ChatView extends StatefulWidget {
//   const ChatView({super.key});
//
//   @override
//   State<ChatView> createState() => _ChatViewState();
// }
//
// class _ChatViewState extends State<ChatView> {
//   late GoogleMapController mapController;
//   final LatLng _initialPosition=  LatLng(37.7749, -122.4194);
//   TextEditingController messageController=TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final width=MediaQuery.sizeOf(context).width;
//     final height=MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       body: Stack(children: [
//         ///===============================>>Container For maps
//         Container(
//           height:height*.25,
//           width: width*1,
//           child: GoogleMap(
//             onMapCreated: (GoogleMapController controller) {
//               mapController = controller;
//             },
//             initialCameraPosition: CameraPosition(
//               target: _initialPosition,
//               zoom: 12.0,
//             ),
//             zoomControlsEnabled: false, // Hides zoom controls
//             myLocationEnabled: true,   // Enables user's location
//           ),
//         ),
//         ///===============================>>Chat screen
//         Padding(
//           padding: EdgeInsets.only(top: height*.19),
//           child: Container(
//             height:height*1,
//             width: width*1,
//             decoration: BoxDecoration(
//                 color:Theme.of(context).colorScheme.background,
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(20),
//                   topLeft: Radius.circular(20),
//                 )
//             ),
//            child: Column(children: [
//              ///===============================>> 1st Expended usr fo chat Screen
//              Expanded(
//                flex: 81,
//                  child: Container(
//                    child: SingleChildScrollView(
//                      child: Padding(
//                        padding:  EdgeInsets.symmetric(horizontal: width*.05),
//                        child: SingleChildScrollView(
//                          child: Column(children: [
//                            SendingContainer(text: 'Lorem Ipsum is simply dummy text of the '
//                                'printing and typesetting industry. Lorem '
//                                "Ipsum has been the industry's standard"
//                                "dummy text ever since the 1500s"),
//
//                            RecevingContainer(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
//
//                            SendingContainer(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
//                          ],),
//                        ),
//                      ),
//                    ),
//              )),
//              ///===============================>> 2nd Expended usr fo Text fields
//              Expanded(
//                flex: 16,
//                  child: Container(
//                    child: SingleChildScrollView(
//                      child: Padding(
//                        padding: EdgeInsets.symmetric(horizontal: width*.03),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: [
//                            Row(
//                              children: [
//                                Expanded(
//                                  flex:85,
//                                  child: TextFormFieldIconButton(
//                                      onTap: (){},
//                                      hintText: 'Message your driver',
//                                      controller: messageController,
//                                      iconData: Icons.insert_link_rounded,
//                                  ),
//                                ),
//                                SizedBox(width: width*.01,),
//                                Expanded(
//                                   flex: 15,
//                                    child: InkWell(
//                                      onTap: (){},
//                                      child: CircleAvatar(
//                                        radius: width*.06,
//                                       child: ImageIcon(AssetImage(Appimages.send)),
//                                                                     ),
//                                    ))
//                              ],
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//              ))
//            ],),
//           ),
//         ),
//         ///===============================>> Positioned Used Back Button
//         Positioned(
//           left: width*.88,top: height*.13,
//           child: InkWell(
//             onTap: (){Navigator.pop(context);},
//             child: CircleAvatar(
//               backgroundColor: Theme.of(context).colorScheme.background,
//               child:ImageIcon(AssetImage(Appimages.exit),color: Theme.of(context).colorScheme.secondary,)
//             ),
//           ),
//         )
//       ],),
//     );
//   }
// }
