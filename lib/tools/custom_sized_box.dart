import 'package:flutter/cupertino.dart';

extension CustomSizedBox on num {
  Widget get wd => SizedBox(
    width: toDouble(),
  );
  Widget get hg => SizedBox(
    height: toDouble(),
  );
}