import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

import '../../constans/utils.dart';

Future<ImageLabeler> getModel ()async{
  const path = 'assets/ml/model.tflite';
  final modelPath = await getAssetPath(path);
  final options = LocalLabelerOptions(
    modelPath: modelPath,
    confidenceThreshold: 0.1,
  );
  return ImageLabeler(options: options);

}