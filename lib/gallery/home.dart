import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'item.dart';
import 'theme.dart';

const double _kFlexibleSpaceMaxHeight = 256.0;
const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class _BackgroundLayer {
  final String assetName;
  final String assetPackage;
  final Tween<double> parallaxTween;

  _BackgroundLayer({int level, double parallax})
      : assetName = "appbar/appbar_background_layer$level.png",
        assetPackage = _kGalleryAssetsPackage,
        parallaxTween = new Tween<double>(begin: 0.0, end: parallax);
}

final List<_BackgroundLayer> _kBackgroundLayers = <_BackgroundLayer>[
  new _BackgroundLayer(level: 0, parallax: _kFlexibleSpaceMaxHeight),
  new _BackgroundLayer(level: 1, parallax: _kFlexibleSpaceMaxHeight),
  new _BackgroundLayer(level: 2, parallax: _kFlexibleSpaceMaxHeight / 2.0),
  new _BackgroundLayer(level: 3, parallax: _kFlexibleSpaceMaxHeight / 4.0),
  new _BackgroundLayer(level: 4, parallax: _kFlexibleSpaceMaxHeight / 2.0),
  new _BackgroundLayer(level: 5, parallax: _kFlexibleSpaceMaxHeight),
];

class _AppBarBackground extends StatelessWidget {
  final Animation<double> animation;

  const _AppBarBackground({Key key, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return new Stack(
              children: _kBackgroundLayers.map((_BackgroundLayer layer) {
            return new Positioned(
                top: -layer.parallaxTween.evaluate(animation),
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: new Image.asset(
                  layer.assetName,
                  package: layer.assetPackage,
                  fit: BoxFit.cover,
                  height: _kFlexibleSpaceMaxHeight,
                ));
          }).toList());
        });
  }
}

class GalleryHome extends StatefulWidget {
  static bool showPreviewBanner = true;

  final GalleryTheme galleryTheme;
  final ValueChanged<GalleryTheme> onThemeChanged;

  final double timeDilation;
  final ValueChanged<double> onTimeDilationChanged;

  final double textScaleFactor;
  final ValueChanged<double> onTextScaleFactorChanged;

  final bool showPerformanceOverlay;
  final ValueChanged<bool> onShowPerformanceOverlayChanged;

  final bool checkerboardRasterCacheImages;
  final ValueChanged<bool> onCheckerboardRasterCacheImagesChanged;

  final bool checkerboardOffscreenLayers;
  final ValueChanged<bool> onCheckerboardOffscreenLayersChanged;

  final ValueChanged<TargetPlatform> onPlatformChanged;

  final TextDirection overrideDirection;
  final ValueChanged<TextDirection> onOverrideDirectionChanged;

  final VoidCallback onSendFeedback;

  @override
  State<StatefulWidget> createState() {
    return new GalleryHomeState();
  }
}

class GalleryHomeState extends State<GalleryHome>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 600),
        debugLabel: 'preview banner',
        vsync: this)
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _galleryListItems() {
    final List<Widget> listItems = <Widget>[];
    final ThemeData themeData = Theme.of(context);
    final TextStyle headerStyle =
        themeData.textTheme.body2.copyWith(color: themeData.accentColor);
    String category;
    for (GalleryItem galleryItem in kAllGalleryItems) {
      if (category != galleryItem.category) {
        if (category != null) listItems.add(const Divider());
        listItems.add(new MergeSemantics(
          child: new Container(
            height: 48.0,
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            alignment: AlignmentDirectional.centerStart,
            child: new SafeArea(
                top: false,
                bottom: false,
                child: new Semantics(
                  header: true,
                  child: new Text(
                    galleryItem.category,
                    style: headerStyle,
                  ),
                )),
          ),
        ));

        category = galleryItem.category;
      }

      listItems.add(galleryItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget home=new Scaffold(
      key: _scaffoldKey,
      drawer: new Gall,
    )
  }
}
