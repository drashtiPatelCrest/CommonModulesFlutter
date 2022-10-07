import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modules_flutter/base_classes/base_text.dart';
import 'package:modules_flutter/utils/colors_utils.dart';
import 'package:modules_flutter/utils/dimensions_utils.dart';

class MultipleImagesScreen extends StatefulWidget {
  final String title;

  const MultipleImagesScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<MultipleImagesScreen> createState() => _MultipleImagesScreenState();
}

class _MultipleImagesScreenState extends State<MultipleImagesScreen> {
  List<File> _pickedFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          automaticallyImplyLeading: true,
          centerTitle: true),
      body: _mainView(),
    );
  }
}

extension on _MultipleImagesScreenState {
//Main body view
  Widget _mainView() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        children: [
          //Pick images button
          MaterialButton(
            color: ColorsUtils.colorBase,
            textColor: ColorsUtils.colorWhite,
            onPressed: () {
              _pickImages();
            },
            child: const Text("Pick Multiple Images"),
          ),
          const SizedBox(height: 20),
          GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0),
              shrinkWrap: true,
              itemCount: _pickedFiles.length,
              itemBuilder: (context, index) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      _pickedFiles[index],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          color: Colors.red,
                          padding: const EdgeInsets.all(dim20),
                          child: BaseText(text: "Failed to load image"),
                        );
                      },
                    ),
                    //Remove image
                    Positioned(
                        right: 4,
                        top: 4,
                        child: InkWell(
                          onTap: () {
                            _pickedFiles.removeAt(index);
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                        )),
                  ],
                );
              })
        ],
      ),
    );
  }
}

extension on _MultipleImagesScreenState {
  //Pick Multiple Images
  Future<void> _pickImages() async {
    List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      for (var element in pickedFiles) {
        if (_pickedFiles.contains(File(element.path))) {
          debugPrint("Already added");
        } else {
          _pickedFiles.add(File(element.path));
        }
        debugPrint("File => ${element.name}");
      }
      setState(() {});
    }
  }
}
