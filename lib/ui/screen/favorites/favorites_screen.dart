import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:causewell/data/models/course/CourcesResponse.dart';
import 'package:causewell/main.dart';
import 'package:causewell/theme/theme.dart';
import 'package:causewell/ui/bloc/favorites/bloc.dart';
import 'package:causewell/ui/widgets/course_grid_item.dart';
import 'package:causewell/ui/widgets/drawer_menu.dart';
import 'package:causewell/ui/widgets/loading_error_widget.dart';
import 'package:causewell/ui/widgets/main_app_bar.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _FavoritesScreenWidget();
  }
}

class _FavoritesScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoritesScreenWidgetState();
  }
}

class _FavoritesScreenWidgetState extends State<_FavoritesScreenWidget> {
  int selectedId;
  FavoritesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<FavoritesBloc>(context)..add(FetchFavorites());
  }

  _buildEmptyList() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 150,
            height: 150,
            child: SvgPicture.asset(
              "assets/icons/empty_courses.svg",
            ),
          ),
          Text(
            localizations.getLocalization("no_user_favorites_screen_title"),
            textScaleFactor: 1.0,
            style: TextStyle(color: HexColor.fromHex("#D7DAE2"), fontSize: 18),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double heightScreen = mediaQueryData.size.height;

    return Scaffold(
        endDrawer: Container(
          width: 400.0,
          child: Drawer(
            child: DrawerMenu(),
          ),
        ),
        appBar: MainAppBar(
          title: localizations.getLocalization("favorites_title"),
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is EmptyFavoritesState) return _buildEmptyList();
            if (state is ErrorFavoritesState)
              return Center(
                child: LoadingErrorWidget(() {
                  _bloc.add(FetchFavorites());
                }),
              );
            if (state is LoadedFavoritesState) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  // I only need two card horizontally
                  padding: const EdgeInsets.all(2.0),
                  itemCount: state.favoriteCourses.length,
                  itemBuilder: (context, index) {
                    var item = state.favoriteCourses[index];
                    var itemId = item.id;
                    var itemState = CourseGridItemEditingState.primary;

                    if (selectedId == null) {
                      itemState = CourseGridItemEditingState.primary;
                    } else {
                      if (selectedId == itemId) {
                        itemState = CourseGridItemEditingState.selected;
                      } else {
                        itemState = CourseGridItemEditingState.shadowed;
                      }
                    }
                    var paddingTop = 0.0;
                    var paddingBottom = 0.0;
                    if (index < 2) paddingTop = 16.0;
                    if (index == state.favoriteCourses.length - 1)
                      paddingBottom = 16.0;
                    return Padding(
                      padding: EdgeInsets.only(
                          top: paddingTop, bottom: paddingBottom),
                      child: CourseGridItemSelectable(
                        coursesBean: item,
                        onTap: () {
                          if (selectedId != itemId) {
                            setState(() {
                              selectedId = null;
                            });
                          }
                        },
                        onDeletePressed: () {
                          setState(() {
                            selectedId = null;
                          });
                          _bloc.add(DeleteEvent(itemId));
                        },
                        onSelected: () {
                          setState(() {
                            setState(() {
                              selectedId = itemId;
                            });
                          });
                        },
                        itemState: itemState,
                      ),
                    );
                  },
                  //Here is the place that we are getting flexible/ dynamic card for various images
                  staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0, // add some space
                ),
              );
            }
            if (state is InitialFavoritesState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center();
          },
        ));
  }
}

enum CourseGridItemEditingState { primary, selected, shadowed }

class CourseGridItemSelectable extends StatelessWidget {
  final CoursesBean coursesBean;
  final VoidCallback onDeletePressed;
  final VoidCallback onSelected;
  final VoidCallback onTap;
  final CourseGridItemEditingState itemState;

  const CourseGridItemSelectable({
    @required this.coursesBean,
    @required this.onTap,
    @required this.onDeletePressed,
    @required this.onSelected,
    @required this.itemState,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: onSelected,
        onTap: onTap,
        child: Container(
          child: Stack(
            children: <Widget>[
              CourseGridItem(coursesBean),
              Visibility(
                visible: itemState == CourseGridItemEditingState.selected,
                child: Container(
                  height: 200,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: mainColor, width: 2)),
                ),
              ),
              Visibility(
                visible: itemState == CourseGridItemEditingState.selected,
                child: Positioned(
                  top: 1,
                  right: 1,
                  child: Container(
                    width: 40,
                    height: 40,
                    child: FloatingActionButton(
                      backgroundColor: mainColor,
                      child: Icon(Icons.close),
                      onPressed: onDeletePressed,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: itemState == CourseGridItemEditingState.shadowed,
                child: Container(
                  height: 200,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Colors.white.withOpacity(0.5)),
                ),
              ),
            ],
          ),
        ));
  }
}
