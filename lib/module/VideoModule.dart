
class VideosModule {
  List<Videos> videos=[];

  VideosModule({required this.videos});

  VideosModule.fromJson(Map<String, dynamic> json) {
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos.add(new Videos.fromJson(v));
      });
    }
  }
}

class Videos {
  List<VideoFiles>? videoFiles;
  List<VideoPictures>? videoPictures;
  String ? image;

  Videos({required this.videoFiles, required this.videoPictures});

  Videos.fromJson(Map<String, dynamic> json) {

    if (json['video_files'] != null) {
      videoFiles = <VideoFiles>[];
      json['video_files'].forEach((v) {
        videoFiles!.add(new VideoFiles.fromJson(v));
      });
    }
    image= json['image'];
    if (json['video_pictures'] != null) {
      videoPictures = <VideoPictures>[];
      json['video_pictures'].forEach((v) {
        videoPictures!.add(new VideoPictures.fromJson(v));
      });
    }
  }
}

class VideoFiles {
  String? link;

  VideoFiles({required this.link});

  VideoFiles.fromJson(Map<String, dynamic> json) {
    link = json['link'];
  }
}

class VideoPictures {
  String? picture;

  VideoPictures({required this.picture});

  VideoPictures.fromJson(Map<String, dynamic> json) {
    picture = json['picture'];
  }


// // class VideoModule{
// //   var page;
// //   var duration;
// //   String ?videoFile;
// //  String ?image;
// //
// //   VideoModule(
// //       {
// //         required this.page,
// //       required this.image,
// //       required this.duration,
// //       required this.videoFile});
// //
// //   VideoModule.fromJson(Map <String, dynamic> json) {
// //     page=json['page'];
// //     duration=json['videos'][0]['duration'];
// //     videoFile=json['videos'][0]['video_files'][2]['link'];
// //     image=json['videos'][0]['video_pictures'][6]['picture'];
// //   }
// // }
//
//
}

