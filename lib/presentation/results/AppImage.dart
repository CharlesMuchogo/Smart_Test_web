import 'package:flutter/material.dart';

import '../../Utils/utils.dart';

class AppImage extends StatelessWidget {
  const AppImage({super.key, required this.image, required this.onClick});

  final String image;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return image.isNotEmpty
        ? GestureDetector(
            onTap: onClick,
            child: SizedBox(
              width: 50,
              height: 50,
              child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    "$baseUrl$image",
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error) => const Center(
                      child: Icon(
                        Icons.image,
                        size: 30,
                      ),
                    ),
                  )

                  /*CachedNetworkImage(
                  httpHeaders: const {
                    'crossOrigin': 'anonymous',
                  },
                  imageUrl: "$baseUrl$image",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(
                      Icons.image,
                      size: 30,
                    ),
                  ),
                ),*/
                  ),
            ),
          )
        : const Text("N/A");
  }
}
