import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageCropScreen extends StatefulWidget {
  const ImageCropScreen({Key? key}) : super(key: key);

  @override
  State<ImageCropScreen> createState() => _ImageCropScreenState();
}

class _ImageCropScreenState extends State<ImageCropScreen> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;
  String title = "Image Crop";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: _mainView(),
      //body: _body(),
    );
  }

  Widget buildOld(BuildContext context) {
    return Scaffold(
      appBar: !kIsWeb ? AppBar(title: Text(title)) : null,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (kIsWeb)
            Padding(
              padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Theme.of(context).highlightColor),
              ),
            ),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _body() {
    if (_croppedFile != null || _pickedFile != null) {
      return _imageCard();
    } else {
      return _uploaderCard();
    }
  }

  Widget _imageCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kIsWeb ? 24.0 : 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
                child: _image(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          _menu(),
        ],
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _menu() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () {
            _deleteImage();
          },
          backgroundColor: Colors.redAccent,
          tooltip: 'Delete',
          child: const Icon(Icons.delete),
        ),
        if (_croppedFile == null)
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton(
              onPressed: () {
                _cropImage();
              },
              backgroundColor: const Color(0xFFBC764A),
              tooltip: 'Crop',
              child: const Icon(Icons.crop),
            ),
          )
      ],
    );
  }

  Widget _uploaderCard() {
    return Center(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: kIsWeb ? 380.0 : 320.0,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    radius: const Radius.circular(12.0),
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    color: Theme.of(context).highlightColor.withOpacity(0.4),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Theme.of(context).highlightColor,
                            size: 80.0,
                          ),
                          const SizedBox(height: 24.0),
                          Text(
                            'Upload an image to start',
                            style: kIsWeb
                                ? Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: Theme.of(context).highlightColor)
                                : Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color:
                                            Theme.of(context).highlightColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    _uploadImage();
                  },
                  child: const Text('Upload'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on _ImageCropScreenState {
  //Main body view
  Widget _mainView() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        children: [
          //Profile Image
          const Text("Profile Image",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          _imageUploadView(),
          const SizedBox(height: 40),
          //Upload Image
          InkWell(
              onTap: () {
                _uploadImage();
              },
              child: textIcon(
                  text: 'Upload Image', icon: Icons.add_a_photo_outlined)),
          const SizedBox(height: 40),
          //Menus
          Visibility(
            visible: _pickedFile != null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Crop
                InkWell(
                    onTap: () {
                      _cropImage();
                    },
                    child: iconView(icon: Icons.crop)),
                const SizedBox(width: 20),
                //Delete
                InkWell(
                    onTap: () {
                      _deleteImage();
                    },
                    child: iconView(icon: Icons.delete)),
              ],
            ),
          )
        ],
      ),
    );
  }

  //Upload image view
  Widget _imageUploadView() {
    return Stack(
      children: [
        //Upload image
        /*InkWell(
          onTap: () {
            _uploadImage();
          },
          child: const Positioned(
            left: 0,
            right: 00,
            top: 0,
            bottom: 0,
            child: Icon(
              Icons.add_a_photo_outlined,
              size: 60,
              color: Colors.grey,
            ),
          ),
        ),*/
        //Show image
        Container(
          height: 290,
          width: 290,
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: Colors.grey)),
          child: _showImageView(),
        ),
      ],
    );
  }

  //Show selected/cropped image
  Widget _showImageView() {
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return CircleAvatar(backgroundImage: Image.file(File(path)).image);
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return CircleAvatar(backgroundImage: Image.file(File(path)).image);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget textIcon({required String text, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 8.0),
          Text(text, style: const TextStyle(fontSize: 18.0))
        ],
      ),
    );
  }

  Widget iconView({required IconData icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(15.0)),
      child: Icon(icon),
    );
  }
}

extension on _ImageCropScreenState {
  //Upload Image
  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  //Delete Image
  void _deleteImage() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }

  //Crop Image
  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        cropStyle: CropStyle.circle,
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }
}
