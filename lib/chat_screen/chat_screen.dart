import 'package:audioplayers/audioplayers.dart';
import 'package:chat_screen/model/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}



class _ChatScreenState extends State<ChatScreen> {
  List<Message> messages = [
    Message(
        text: 'jhdci1',
        date: DateTime.now().subtract(Duration(minutes: 1)),
        isSent: false),
    Message(
        audioUrl: 'https://github.com/shyamexe/qmake/raw/master/lib/sample-9s.mp3',
        date: DateTime.now().subtract(Duration(minutes: 2)),
        isSent: true),
    Message(
        text: 'jhsdci',
        date: DateTime.now().subtract(Duration(minutes: 2)),
        isSent: false),
    Message(
        text: 'jcsdhi',
        date: DateTime.now().subtract(Duration(days: 2)),
        isSent: true),
    Message(
        imageUrl:
            'https://user-images.githubusercontent.com/93277108/175243443-9cca07d3-90cd-4c0f-94f6-facc7e247083.jpg',
        date: DateTime.now().subtract(Duration(days: 2)),
        isSent: false),
    Message(
        text: 'jdschi',
        date: DateTime.now().subtract(Duration(days: 63)),
        isSent: false),
    Message(
        text: 'jdchi',
        date: DateTime.now().subtract(Duration(days: 63)),
        isSent: true),
  ];

  final audioPlayer =AudioPlayer();
  bool isplaying =false;
  Duration duration = Duration.zero;
  Duration position =Duration.zero;

  @override
  void initState() {
    audioPlayer.setSourceUrl('https://github.com/shyamexe/qmake/raw/master/lib/sample-9s.mp3');

    audioPlayer.onPlayerStateChanged.listen((state) {
      isplaying=state==PlayerState.playing;
    });

    audioPlayer.onDurationChanged.listen((newduration) {
      setState(() {
        duration=newduration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) { 
      setState(() {
        position=newPosition;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],
        iconTheme: IconThemeData(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Text(
                  'Online',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                )),
            Text('Shantik Lunia', style: TextStyle(color: Colors.black))
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
              padding: EdgeInsets.all(20),
              reverse: true,
              order: GroupedListOrder.DESC,
              elements: messages,
              groupBy: (message) => DateTime(
                  message.date.year, message.date.month, message.date.day),
              groupHeaderBuilder: (Message message) => SizedBox(
                height: 40,
                width: double.maxFinite,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                      )),
                      Text(DateFormat.yMMMd().format(message.date)),
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                      )),
                    ],
                  ),
                ),
              ),
              itemBuilder: (context, Message message) => Align(
                alignment: message.isSent
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft:
                        !message.isSent ? Radius.zero : Radius.circular(10),
                    bottomRight:
                        message.isSent ? Radius.zero : Radius.circular(10),
                  )),
                  child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          if (message.imageUrl != null)
                            SizedBox(
                                height: 150,
                                width: 229,
                                child: Image.network(
                                  message.imageUrl!,
                                  fit: BoxFit.cover,
                                )),
                          if (message.text != null) Text(message.text!),
                          if(message.audioUrl!=null)Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Color(0xff2F80ED)
                            ),
                            width: 139,
                            height:37,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                              InkWell(
                                onTap: ()async{
                                    if(isplaying){
                                      await audioPlayer.pause();
                                    }else{
                                      await audioPlayer.resume();
                                    }
                                  },
                                child: Icon(
                                      isplaying?Icons.pause:Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                              ),
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      color: Colors.white,
                                      value: position.inSeconds.toDouble(),
                                    ),
                                  ),
                                  SizedBox(width: 2,)
                                  // Slider(
                                  //   min: 0,
                                  //   max: duration.inSeconds.toDouble(),
                                  //   value: position.inSeconds.toDouble(), 
                                  //   onChanged: (val)async{
                                  //     final postion=Duration(seconds: val.toInt());
                                  //     await audioPlayer.seek(postion);

                                  //     audioPlayer.resume();
                                  //   })
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            height: 56,
            width: double.maxFinite,
            color: Color(0XFFEAF2FD),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: Color(0xff2F80ED),
                    )),
                Expanded(
                    child: TextField(
                  onSubmitted: (val) {
                    setState(() {
                      messages.add(Message(
                          date: DateTime.now(), text: val, isSent: true));
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.mic_none,
                      color: Color(0xff2F80ED),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
