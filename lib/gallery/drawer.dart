import 'dart:math' as math;
import 'package:flutter/foundation.dart' show defaultTargetPlatform,required;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme.dart';

class LinkTextSpan extends TextSpan{

  LinkTextSpan({TextStyle style,String url,String text }):super(
    style:style,
      text:text ?? url,
      recognizer:new TapGestureRecognizer()
      ..onTap=(){
        launch(url,forceSafariVC: false);
      }
  );

}


class GalleryDrawerHeader extends StatefulWidget{
  final bool light;

  const GalleryDrawerHeader({Key key,this.light}):super(key:key);

  @override
  _GalleryDrawerHeaderState createState() =>new _GalleryDrawerHeaderState();
}


class _GalleryDrawerHeaderState extends State<GalleryDrawerHeader>{
  bool _logoHasName=true;
  bool _logoHorizontal=true;
  MaterialColor _logoColor=Colors.blue;

  @override
  Widget build(BuildContext context) {

    final double systemTopPadding=MediaQuery.of(context).padding.top;
    return new Semantics(
      label: 'Flutter',
      child: new DrawerHeader(
        decoration: new FlutterLogoDecoration(
          margin: new EdgeInsets.fromLTRB(12.0, 12.0+systemTopPadding,12.0, 12.0),
          style: _logoHasName?_logoHorizontal?FlutterLogoStyle.horizontal
              :FlutterLogoStyle.stacked
              :FlutterLogoStyle.markOnly,
          lightColor: _logoColor.shade400,
          darkColor: _logoColor.shade900,
          textColor: widget.light?const Color(0xff616161):const Color(0xff9e9e9e)
        ),
          duration: const Duration(milliseconds: 750),
          child: new GestureDetector(
            onLongPress: (){
              setState(() {
                _logoHorizontal=!_logoHorizontal;
                if(!_logoHasName) _logoHasName=true;
              });
            },
            onTap: (){
              setState(() {
                _logoHasName=!_logoHasName;
              });
            },
            onDoubleTap: (){
              setState(() {
                final List<MaterialColor> options=[];
                if(_logoColor!=Colors.blue)
                  options.addAll([Colors.blue,Colors.blue,Colors.blue,Colors.blue,]);
                if (_logoColor != Colors.amber)
                  options.addAll(<MaterialColor>[Colors.amber, Colors.amber, Colors.amber]);
                if (_logoColor != Colors.red)
                  options.addAll(<MaterialColor>[Colors.red, Colors.red, Colors.red]);
                if (_logoColor != Colors.indigo)
                  options.addAll(<MaterialColor>[Colors.indigo, Colors.indigo, Colors.indigo]);
                if (_logoColor != Colors.pink)
                  options.addAll(<MaterialColor>[Colors.pink]);
                if (_logoColor != Colors.purple)
                  options.addAll(<MaterialColor>[Colors.purple]);
                if (_logoColor != Colors.cyan)
                  options.addAll(<MaterialColor>[Colors.cyan]);
                _logoColor=options[new math.Random().nextInt(options.length)];
              });
            },
          )
      ),
    );
  }

}


class GalleryDrawer extends StatelessWidget{

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

  const GalleryDrawer({
  Key key,
  this.galleryTheme,
    @required this.onThemeChanged,
    this.timeDilation,
    @required this.onTimeDilationChanged,
    this.textScaleFactor,
    this.onTextScaleFactorChanged,
    this.showPerformanceOverlay,
    this.onShowPerformanceOverlayChanged,
    this.checkerboardRasterCacheImages,
    this.onCheckerboardRasterCacheImagesChanged,
    this.checkerboardOffscreenLayers,
    this.onCheckerboardOffscreenLayersChanged,
    this.onPlatformChanged,
    this.overrideDirection: TextDirection.ltr,
    this.onOverrideDirectionChanged,
    this.onSendFeedback,
  }) : assert(onThemeChanged != null),
        assert(onTimeDilationChanged != null),
        super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData=Theme.of(context);
    final TextStyle aboutTextStyle=themeData.textTheme.body2;
    final TextStyle linkStyle=themeData.textTheme.body2.copyWith(color: themeData.accentColor);
    
    final List<Widget> themeItems=kAllGalleryThemes.map((GalleryTheme theme){
      
      return new RadioListTile(
        title: new Text(theme.name),
          secondary: new Icon(theme.icon),
          value: theme, 
          groupValue: galleryTheme, 
          onChanged: onThemeChanged,
      selected: galleryTheme==theme,
      );
    }).toList();
    
    final Widget mountainViewItem=new RadioListTile<TargetPlatform>(
      secondary: new Icon(defaultTargetPlatform==TargetPlatform.iOS?Icons.star:Icons.phone_android),
        title: new Text(defaultTargetPlatform==TargetPlatform.iOS?'Mountain View':'android'),
        value: TargetPlatform.android,
        groupValue: ,
        onChanged: null);
    return null;
  }
}