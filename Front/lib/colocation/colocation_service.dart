import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:front/colocation/colocation.dart';
import 'package:front/utils/dio.dart';
import 'package:front/website/share/secure_storage.dart';
import 'package:latlong2/latlong.dart';

Future<List<Colocation>> fetchColocations() async {
  var headers = await addHeader();
  try {
    var userData = await decodeToken();

    var response = await dio.get('/colocations/user/${userData['user_id']}',
        options: Options(headers: headers));
    if (response.statusCode == 200) {
      List<dynamic> data = response.data['colocations'] ?? [];

      return data.map((coloc) => Colocation.fromJson(coloc)).toList();
    } else {
      throw Exception('Failed to load colocations 8');
    }
  } on DioException catch (e) {
    print('Dio error!');
    print('Response status: ${e.response!.statusCode}');
    print('Response data: ${e.response!.data}');
    throw Exception('Failed to load colocations');
  }
}

Future<Map<String, dynamic>> fetchColocation(int colocationId) async {
  var headers = await addHeader();
  try {
    var response = await dio.get('/colocations/$colocationId',
        options: Options(headers: headers));
    if (response.statusCode == 200) {
      return response.data["result"];
    } else {
      throw Exception('Failed to load colocation');
    }
  } on DioException catch (e) {
    log('Dio error!');
    log('Response status: ${e.response!.statusCode}');
    log('Response data: ${e.response!.data}');
    throw Exception('Failed to load colocation');
  }
}

Future<int> createColocation(String name, String description, bool isPermanent,
    LatLng coord, String location) async {
  var headers = await addHeader();
  try {
    var userData = await decodeToken();
    var response = await dio.post(
      '/colocations',
      data: {
        'name': name,
        'description': description,
        'isPermanent': isPermanent,
        "userId": userData['user_id'],
        "latitude": coord.latitude,
        "longitude": coord.longitude,
        "location": location
      },
      options: Options(headers: headers),
    );
    print(response.data);
    return response.statusCode!;
  } on DioException catch (e) {
    log('Dio error!');
    log('Response status: ${e.response!.statusCode}');
    log('Response data: ${e.response!.data}');
    return e.response?.statusCode ?? 500;
  }
}

Future<int> updateColocation(
    int colocationId, String name, String description, bool isPermanent) async {
  var headers = await addHeader();
  try {
    var response = await dio.patch(
      '/colocations/$colocationId',
      data: {
        'name': name,
        'description': description,
        'isPermanent': isPermanent,
      },
      options: Options(headers: headers),
    );
    return response.statusCode!;
  } on DioException catch (e) {
    print('Dio error!');
    print('Response status: ${e.response!.statusCode}');
    print('Response data: ${e.response!.data}');
    return e.response?.statusCode ?? 500;
  }
}

Future<int> deleteColocation(int colocationId) async {
  var headers = await addHeader();
  try {
    var response = await dio.delete(
      '/colocations/$colocationId',
      options: Options(headers: headers),
    );
    print(response.data);
    return response.statusCode!;
  } on DioException catch (e) {
    log('Dio error!');
    log('Response status: ${e.response!.statusCode}');
    log('Response data: ${e.response!.data}');
    return e.response?.statusCode ?? 500;
  }
}
