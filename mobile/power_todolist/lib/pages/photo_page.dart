import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:power_todolist/api/api_service.dart';
import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/config/keys.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/pages/all_page.dart';
import 'package:power_todolist/utils/shared_util.dart';
import 'package:power_todolist/widgets/all_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PhotoPage extends StatefulWidget {
  final String selectValue;

  const PhotoPage({Key key, @required this.selectValue}) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  List<PhotoPower> photos = [];
  String loadingErrorText = "";

  LoadingFlag loadingFlag = LoadingFlag.loading;
  RefreshController _refreshController;
  CancelToken cancelToken;

  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(MyLocalizations.of(context).netPicture),
      ),
      body: Container(
          child: loadingFlag == LoadingFlag.success || photos.isNotEmpty
              ? SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: false,
                  enablePullUp: true,
                  onLoading: loadMorePhoto,
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = Text(MyLocalizations.of(context).pullUpToLoadMore);
                      } else if (mode == LoadStatus.loading) {
                        body = CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                        );
                      } else if (mode == LoadStatus.failed) {
                        body = Text(MyLocalizations.of(context).loadingError);
                      } else {
                        body = Text(MyLocalizations.of(context).loadingEmpty);
                      }
                      return Container(
                        height: 55.0,
                        child: Center(child: body),
                      );
                    },
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(photos.length, (index) {
                      final url = photos[index].urls.regular;
                      final urls = photos.map((photoPower) => photoPower.urls.small).toList();
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
                            return ImagePage(
                              imageUrls: urls,
                              initialPageIndex: index,
                              onSelect: (current) {
                                final currentUrl = photos[current].urls.small;
                                SharedUtil.instance.saveString(Keys.currentNetPicUrl, currentUrl);
                                SharedUtil.instance.saveString(Keys.currentNavHeader, widget.selectValue);
                                globalModel.currentNetPicUrl = currentUrl;
                                globalModel.currentNavHeader = widget.selectValue;
                                globalModel.refresh();
                                Navigator.of(context).pop();
                              },
                            );
                          }));
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: Hero(
                              tag: "tag_${index}",
                              child: CachedNetworkImage(
                                imageUrl: url,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => new Container(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                  ),
                                ),
                                errorWidget: (context, url, error) => new Icon(
                                  Icons.error,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                )
              : LoadingWidget(
                  errorText: loadingErrorText,
                  flag: loadingFlag,
                  errorCallBack: () {
                    setState(() {
                      loadingFlag = LoadingFlag.loading;
                    });
                    getPhotos();
                  },
                )),
    );
  }

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: true);
    cancelToken = CancelToken();
    getPhotos(
      cancelToken: cancelToken,
    );
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    cancelToken?.cancel();
    super.dispose();
  }

  void loadMorePhoto() {
    getPhotos(
      page: (photos.length / 20).toInt() + 1,
      cancelToken: cancelToken,
    );
  }

  void getPhotos({
    int page = 1,
    int perPage = 20,
    CancelToken cancelToken,
  }) {
    ApiService.getInstance().getPhotos(
      success: (powers) {
        List<PhotoPower> datas = powers;
        if (datas.length == 0) {
          loadingFlag = LoadingFlag.empty;
          _refreshController.footerMode.value = LoadStatus.noMore;
        } else {
          loadingFlag = LoadingFlag.success;
          photos.addAll(datas);
          _refreshController.loadComplete();
        }
        refresh();
      },
      failed: (fail) {
        loadingFlag = LoadingFlag.error;
        _refreshController?.footerMode?.value = LoadStatus.failed;
        refresh();
      },
      error: (error) {
        debugPrint("错误:${error}");
        loadingFlag = LoadingFlag.error;
        _refreshController?.footerMode?.value = LoadStatus.failed;
        refresh();
      },
      params: {
        "client_id": "955536be586ee95d282613e8054784a889a618e42d8b9740acb7ac40edbca433",
        "page": "${page}",
        "per_page": "${perPage}"
      },
    );
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }
}
