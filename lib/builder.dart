import 'package:build/build.dart';

import 'example.dart';

Builder copyBuilder(BuilderOptions options) => CopyBuilder();

Builder resolvingBuilder(BuilderOptions options) => ResolvingBuilder();

Builder cssBuilder(BuilderOptions options) => CssBuilder();

Builder textBuilder(BuilderOptions options) => TextBuilder();
