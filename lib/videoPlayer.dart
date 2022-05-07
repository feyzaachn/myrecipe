import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoItems extends StatefulWidget{
final VideoPlayerController videoPlayerController;


  const VideoItems({Key? key, required this.videoPlayerController}) : super(key: key);

  @override
  _VideoItemsState createState() => _VideoItemsState();
}
@override
class _VideoItemsState extends State<VideoItems>{
  ChewieController? _chewieController;

  @override
  initState(){
    super.initState();
    _chewieController= ChewieController(videoPlayerController: widget.videoPlayerController,
    aspectRatio: 5/8,
      autoInitialize: true,
      autoPlay: false,
        errorBuilder: (context,errorMesaage){
      return Center(child: Text(errorMesaage),);
    }
    );
  }

  @override
  dispose(){
    super.dispose();
    _chewieController!.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Padding(padding: const EdgeInsets.all(8),
    child: Chewie(controller: _chewieController!,

    ),);
  }
}