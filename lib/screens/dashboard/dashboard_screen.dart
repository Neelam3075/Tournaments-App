import 'package:bluestack_demo/custom_widget/sliver_shimmer_widget.dart';
import 'package:bluestack_demo/custom_widget/text_widget.dart';
import 'package:bluestack_demo/l10n/l10n.dart';
import 'package:bluestack_demo/l10n/translate.dart';
import 'package:bluestack_demo/resources%20/app_colors.dart';
import 'package:bluestack_demo/resources%20/app_images.dart';
import 'package:bluestack_demo/screens/dashboard/bloc/profile_bloc/profile_bloc.dart';
import 'package:bluestack_demo/screens/dashboard/bloc/tournaments_bloc/tournament_bloc.dart';
import 'package:bluestack_demo/screens/dashboard/models/get_tournaments_request.dart';
import 'package:bluestack_demo/screens/dashboard/models/get_tournaments_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ScrollController _mController = ScrollController();

  @override
  void initState() {
    super.initState();
    _mController = ScrollController()..addListener(_scrollListener);
    _callDashboardApi();
  }

  _scrollListener() async {
    if (_mController.offset >= _mController.position.maxScrollExtent &&
        !_mController.position.outOfRange) {
      context.read<TournamentBLoC>().add(GetTournamentsEvent(
          getTournamentsRequest: GetTournamentsRequest(), isScrollMore: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.white,
        centerTitle: true,
        title: TextWidget(
          text: Translate().l10n.flyingWolf,
          textSize: 20,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: AppColors.black,
        ),
      ),
      body: Container(
        color: AppColors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: CustomScrollView(
          controller: _mController,
          slivers: <Widget>[
            const SliverToBoxAdapter(
              child: SizedBox(
                child: ProfileWidget(),
              ),
            ),
            BlocBuilder<TournamentBLoC, TournamentState>(
              buildWhen: (previous, current) => current.isSuccess ?? false,
              builder: (context, state) {
                return state.tournamentList == null
                    ? const SliverShimmerWidget()
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            var tournaments = state.tournamentList?[index];

                            return TournamentItem(tournaments: tournaments);
                          },
                          childCount: state.tournamentList?.length ?? 0,
                        ),
                      );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomMessageBarWidget(retry: () {
        _callDashboardApi();
      }),
    );
  }

  void _callDashboardApi() {
    context.read<ProfileBLoC>().add(GetUserProfileEvent());
    context.read<TournamentBLoC>().add(
        GetTournamentsEvent(getTournamentsRequest: GetTournamentsRequest()));
  }
}

class BottomMessageBarWidget extends StatelessWidget {
  const BottomMessageBarWidget({Key? key, required this.retry})
      : super(key: key);
  final VoidCallback retry;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentBLoC, TournamentState>(
      builder: (context, state) {
        return BottomAppBar(
          elevation: 2.0,
          color: (state.isSuccess ?? true)
              ? AppColors.lightForestGreen
              : AppColors.darkRed,
          child: Visibility(
            visible: ((state.message != null && !(state.isSuccess ?? true)) ||
                (state.isLoading ?? false)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextWidget(
                    text: state.message ?? Translate().l10n.loading,
                    textSize: 14,
                    color: AppColors.white,
                  ),
                  Visibility(
                    visible: !(state.isSuccess ?? true),
                    child: InkWell(
                      child: const Icon(
                        Icons.refresh,
                      ),
                      onTap: retry,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBLoC, ProfileState>(
      builder: (context, state) {
        return state.profile == null
            ? Container()
            : Column(children: [
                Row(
                  children: [
                    ClipOval(
                      child: FadeInImage(
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                        placeholder: const AssetImage(AppImages.profile),
                        image: NetworkImage(
                          state.profile?.profile ?? "",
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            text: state.profile?.name ?? "",
                            textSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20, left: 16),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.blue, width: 2),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: TextWidget(
                              textAlign: TextAlign.start,
                              color: AppColors.blueDeFrance,
                              text: "2250 Elo rating",
                              textSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !(state.isSuccess ?? true),
                      child: IconButton(
                        icon: const Icon(
                          Icons.refresh,
                        ),
                        onPressed: () {
                          context
                              .read<ProfileBLoC>()
                              .add(GetUserProfileEvent());
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ProfileScoreCard(
                        title: state.profile?.tounamentPlay?.toString() ?? "0",
                        subtitle: Translate().l10n.tournamentsPlayed,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        lightColor: AppColors.lightYellow,
                        darkColor: AppColors.darkYellow,
                      ),
                    ),
                    Expanded(
                      child: ProfileScoreCard(
                        title: state.profile?.tournamentWon?.toString() ?? "0",
                        subtitle: Translate().l10n.tournamentsWon,
                        darkColor: AppColors.darkPurple,
                        lightColor: AppColors.lightPurple,
                      ),
                    ),
                    Expanded(
                      child: ProfileScoreCard(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        title: (state.profile?.getPercentage() ?? "") + "%",
                        subtitle: Translate().l10n.winningPer,
                        darkColor: AppColors.darkRed,
                        lightColor: AppColors.lightRed,
                      ),
                    ),
                  ],
                )
              ]);
      },
    );
  }
}

class TournamentItem extends StatelessWidget {
  const TournamentItem({
    Key? key,
    required this.tournaments,
  }) : super(key: key);

  final Tournaments? tournaments;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CachedNetworkImage(
            fit: BoxFit.fitWidth,
            imageUrl: tournaments?.coverUrl ?? "",
            height: MediaQuery.of(context).size.width * 0.25,
            placeholder: (context, url) {
              return Shimmer.fromColors(
                baseColor: AppColors.white,
                highlightColor: AppColors.grey,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                      color: AppColors.grey,
                      border: Border.all(
                        color: AppColors.grey,
                      ),
                      borderRadius: BorderRadius.circular(25)),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.35,
                ),
              );
            },
            errorWidget: (context, url, error) =>
                Image.asset(AppImages.gameTvLogo),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, top: 8, bottom: 4),
                      text: tournaments?.name ?? "",
                      textSize: 16,
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w500,
                    ),
                    TextWidget(
                      color: AppColors.grey,
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, top: 4, bottom: 12),
                      text: tournaments?.gameName ?? "",
                      textSize: 14,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right)
            ],
          )
        ],
      ),
    );
  }
}

class ProfileScoreCard extends StatelessWidget {
  final BorderRadius? borderRadius;

  final Color? lightColor;
  final Color? darkColor;
  final String? title;

  final String? subtitle;

  const ProfileScoreCard({
    this.borderRadius,
    this.darkColor,
    this.lightColor,
    this.title,
    this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 1),
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: LinearGradient(tileMode: TileMode.clamp, colors: [
              darkColor ?? AppColors.darkYellow,
              lightColor ?? AppColors.lightYellow
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
              text: title ?? '',
              textSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
            TextWidget(
              padding: const EdgeInsets.only(top: 4),
              text: subtitle ?? "",
              textAlign: TextAlign.center,
              textSize: 14,
              maxLines: 2,
              color: AppColors.white,
            ),
          ],
        ));
  }
}
