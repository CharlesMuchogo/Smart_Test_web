import 'package:flutter/material.dart';

import '../../Utils/utils.dart';

class AppImage extends StatelessWidget {
  const AppImage({super.key, required this.image, required this.onClick});

  final String image;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {

    String imageUrl = image.startsWith("http") ? image : "$baseUrl$image";

    return image.isNotEmpty
        ? GestureDetector(
            onTap: onClick,
            child: SizedBox(
              width: 50,
              height: 50,
              child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error){
                      print("loading image error $imageUrl");
                      return const Center(
                        child: Icon(
                          Icons.image,
                          size: 30,
                        ),
                      );
                    },
                  )
                  ),
            ),
          )
        : const Text("N/A");
  }
}
