import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:new_wallpaper/Component/DetailIcon.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownloadWidget extends StatefulWidget {
  final url;

  FileDownloadWidget({this.url});

  _FileDownloadWidgetState createState() => _FileDownloadWidgetState();
}

class _FileDownloadWidgetState extends State<FileDownloadWidget> {
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    _downloadListener();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  _downloadListener() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if (status.toString() == "DownloadTaskStatus(3)" && progress == 100) {
        String query = "SELECT * FROM task WHERE task_id='" + id + "'";
        var tasks = FlutterDownloader.loadTasksWithRawQuery(query: query);
        //if the task exists, open it
        FlutterDownloader.open(taskId: id);
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  void _download() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      String _localPath = (await findLocalPath()) +
          Platform.pathSeparator +
          'Example_Downloads';
      final savedDir = Directory(_localPath);
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }
      await FlutterDownloader.enqueue(
        url: widget.url,
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true,
      );
    }
  }

  Future<String> findLocalPath() async {
    final directory = await getExternalStorageDirectory();
    return directory!.path;
  }

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return DetailIcon(
      onTap: _download,
      text: language.words['download'],
      icon: Icon(
        Icons.download_sharp,
        size: 30,
        color: Colors.grey[300],
      ),
      bgColor: Colors.grey,
    );
  }
}
