import 'package:example/state/root_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../platform_dector/platform_dector.dart';
import 'edit_markdown_page.dart';

class MarkdownPage extends StatefulWidget {
  final String? assetsPath;
  final String? markdownData;

  const MarkdownPage({Key? key, this.assetsPath, this.markdownData})
      : assert(assetsPath != null || markdownData != null),
        super(key: key);

  @override
  _MarkdownPageState createState() => _MarkdownPageState();
}

class _MarkdownPageState extends State<MarkdownPage> {
  ///key: [isEnglish] , value: data
  Map<bool, String> dataMap = {};
  String? data;
  final TocController controller = TocController();
  bool isEnglish = true;

  @override
  void initState() {
    if (widget.assetsPath != null) {
      loadData(widget.assetsPath!);
    } else {
      this.data = widget.markdownData!;
    }
    super.initState();
  }

  void loadData(String assetsPath) {
    if (dataMap[isEnglish] != null) {
      data = dataMap[isEnglish]!;
      refresh();
      return;
    }
    rootBundle.loadString(assetsPath).then((data) {
      dataMap[isEnglish] = data;
      this.data = data;
      refresh();
    });
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  bool get isDarkNow =>
      rootStore.state.themeState.brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    bool isMobile = PlatformDetector.isMobile || PlatformDetector.isWebMobile;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              title: Text('Markdown Page'),
              elevation: 0.0,
              backgroundColor: Colors.black,
              actions: <Widget>[
                buildThemeButton(),
              ],
            )
          : null,
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : (isMobile ? buildMobileBody() : buildWebBody()),
      floatingActionButtonLocation: isMobile
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: widget.assetsPath != null
          ? Row(
              mainAxisAlignment: isMobile
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.end,
              children: <Widget>[
                isMobile
                    ? FloatingActionButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (ctx) => buildTocList());
                        },
                        child: Icon(Icons.format_list_bulleted),
                        heroTag: 'list',
                      )
                    : SizedBox(),
                isMobile ? SizedBox() : buildThemeButton(),
                FloatingActionButton(
                  onPressed: () {
                    isEnglish = !isEnglish;
                    loadData(
                        isEnglish ? 'assets/demo_en.md' : 'assets/demo_zh.md');
                  },
                  child: Text(isEnglish ? '简中' : 'EN'),
                  heroTag: 'language',
                ),
              ],
            )
          : null,
    );
  }

  IconButton buildThemeButton() {
    Brightness brightness = rootStore.state.themeState.brightness;
    bool isDarkNow = brightness == Brightness.dark;
    return IconButton(
        icon: Icon(isDarkNow ? Icons.brightness_7 : Icons.brightness_2),
        onPressed: () {
          rootStore.dispatch(new ChangeThemeEvent());
        });
  }

  Widget buildTocList() => TocListWidget(
        controller: controller,
        key: ValueKey(controller),
      );

  Widget buildMarkdown() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: MarkdownWidget(
        data: data!,
        controller: controller,
        styleConfig: StyleConfig(
            pConfig: PConfig(
                linkGesture: (linkChild, url) {
                  return GestureDetector(
                    child: linkChild,
                    onTap: () => launchURL(url),
                  );
                },
                selectable: false),
            preConfig: PreConfig(
              preWrapper: (child, text) =>
                  buildCodeBlock(child, text, isEnglish),
            ),
            tableConfig: TableConfig(
              defaultColumnWidth: FixedColumnWidth(50),
              headChildWrapper: (child) => Container(
                margin: EdgeInsets.all(10.0),
                child: child,
                alignment: Alignment.center,
              ),
              bodyChildWrapper: (child) => Container(
                margin: EdgeInsets.all(10.0),
                child: child,
                alignment: Alignment.center,
              ),
            ),
            markdownTheme:
                isDarkNow ? MarkdownTheme.darkTheme : MarkdownTheme.lightTheme),
      ),
    );
  }

  Widget buildCodeBlock(Widget child, String text, bool isEnglish) {
    return Stack(
      children: <Widget>[
        child,
        Container(
          margin: EdgeInsets.only(top: 5, right: 5),
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: text));
              Widget toastWidget = Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 50),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff006EDF), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(
                        4,
                      )),
                      color: Color(0xff007FFF)),
                  width: 150,
                  height: 40,
                  child: Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        isEnglish ? 'Copy successful' : '复制成功',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
              ToastWidget().showToast(context, toastWidget, 500);
            },
            icon: Icon(
              Icons.content_copy,
              size: 10,
            ),
          ),
        )
      ],
    );
  }

  Widget buildMobileBody() {
    return buildMarkdown();
  }

  Widget buildWebBody() {
    return Row(
      children: <Widget>[
        Expanded(child: buildTocList()),
        Expanded(
          child: buildMarkdown(),
          flex: 3,
        )
      ],
    );
  }
}

class ToastWidget {
  ToastWidget._internal();

  static ToastWidget? _instance;

  factory ToastWidget() {
    _instance ??= ToastWidget._internal();
    return _instance!;
  }

  bool isShowing = false;

  void showToast(BuildContext context, Widget widget, int milliseconds) {
    if (!isShowing) {
      isShowing = true;
      FullScreenDialog.getInstance().showDialog(
        context,
        widget,
      );
      Future.delayed(
          Duration(
            milliseconds: milliseconds,
          ), () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
          isShowing = false;
        } else {
          isShowing = false;
        }
      });
    }
  }
}

class FullScreenDialog {
  static FullScreenDialog? _instance;

  static FullScreenDialog getInstance() {
    if (_instance == null) {
      _instance = FullScreenDialog._internal();
    }
    return _instance!;
  }

  FullScreenDialog._internal();

  void showDialog(BuildContext context, Widget child) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (ctx, anm1, anm2) {
          return child;
        }));
  }
}
