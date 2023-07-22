import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';

class RingtonePage extends StatefulWidget {
  const RingtonePage({super.key});

  @override
  State<RingtonePage> createState() => _RingtonePageState();
}

class _RingtonePageState extends State<RingtonePage> {
  bool showRingtones = true;
  List ringtones = [];
  FlutterSoundPlayer player = FlutterSoundPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ringtones"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (ringtones.isNotEmpty)
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    itemCount: ringtones.length,
                    itemBuilder: (_, index) {
                      final ringtone = ringtones[index];
                      return Card(
                        
                        child: ListTile(
                          // onTap: () async{
                          //   player = (await player.openAudioSession())!;
                          //   player.startPlayer(
                          //     fromURI: '/system/media/audio/ringtones/$ringtone.ogg',
                          //     codec: Codec.opusOGG,
                          //   );
                          // },
                          
                          title: Text(ringtone),
                        ),
                      );
                    }),
              ),
            ElevatedButton(
              onPressed: () async {
                const channel = MethodChannel("flutter_channel");
                ringtones = await channel.invokeMethod("getRingtones");
                setState(() {});
              },
              child: const Text(
                "Get Ringtones",
              ),
            )
          ],
        ),
      ),
    );
  }
}
