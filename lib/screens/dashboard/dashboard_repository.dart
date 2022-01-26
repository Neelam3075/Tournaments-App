import 'package:bluestack_demo/l10n/l10n.dart';
import 'package:bluestack_demo/l10n/translate.dart';
import 'package:bluestack_demo/screens/apis/api_base_helper.dart';
import 'package:bluestack_demo/screens/apis/api_config.dart';
import 'package:bluestack_demo/screens/dashboard/models/get_tournaments_request.dart';
import 'package:bluestack_demo/screens/dashboard/models/get_tournaments_response.dart';
import 'package:bluestack_demo/screens/login/models/login_response.dart';
import 'package:bluestack_demo/utils/connectivity.dart';
import 'package:bluestack_demo/utils/pref_keys.dart';
import 'package:bluestack_demo/utils/prefs.dart';

class DashboardRepository {
  Future<GetTournamentsResponse> getTournaments(
      {GetTournamentsRequest? request,
      required Function(bool) isLoading}) async {
    var connected = await ConnectionStatus.getInstance().checkConnection();
    if (connected) {
      ApiBaseHelper apiBaseHelper = ApiBaseHelper();
      Map<String, dynamic>? getResponse = await apiBaseHelper.getApiCall(
          url: kBaseUrl+kTournamentsList,
          queryParameters: request?.toJson(),
          loading: isLoading,
          onFailure: (failure) {},
          onSuccess: (response) {},
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      if (getResponse != null) {
        GetTournamentsResponse getTournamentsResponse =
        GetTournamentsResponse.fromJson(getResponse);
        return getTournamentsResponse;
      } else {
        return GetTournamentsResponse(
            success: false,
            tournamentsDetail:
                TournamentDetails(error: Translate().l10n.somethingWentWrong));
      }
    }else{
      return GetTournamentsResponse(
          success: false,
          tournamentsDetail:
              TournamentDetails(error: Translate().l10n.noInternet));
    }

  }

  Future<LoginResponse> getProfile({required Function(bool) isLoading}) async {
    var connected = await ConnectionStatus.getInstance().checkConnection();
    if (connected) {
      ApiBaseHelper apiBaseHelper = ApiBaseHelper();
      String? userId = await Prefs.getString(PrefKeys.userInfo);
      Map<String, dynamic>? getResponse = await apiBaseHelper.getApiCall(
          url: kProfileServerBaseUrl + (userId ?? ""),
          loading: isLoading,
          onFailure: (failure) {},
          onSuccess: (response) {},
          headers: <String, String>{
            'x-apikey': kApiKey,
            'Content-Type': 'application/json',
          });
      if (getResponse != null) {
        LoginResponse response = LoginResponse.fromJson(getResponse);
        response.status = true;
        return response;
      } else {
        return LoginResponse(
            status: false, message: Translate().l10n.somethingWentWrong);
      }
    } else{
      return LoginResponse(status: false, message: Translate().l10n.noInternet);
    }


  }
}
