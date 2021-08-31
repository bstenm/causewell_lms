import 'package:inject/inject.dart';
import 'package:causewell/data/models/InstructorsResponse.dart';
import 'package:causewell/data/network/api_provider.dart';
import 'package:causewell/data/utils.dart';

enum InstructorsSort { rating }

abstract class InstructorsRepository {
  Future<List<InstructorBean>> getInstructors(InstructorsSort sort,
      {int page, int perPage});
}

@provide
class InstructorsRepositoryImpl extends InstructorsRepository {
  final UserApiProvider apiProvider;

  InstructorsRepositoryImpl(this.apiProvider);

  @override
  Future<List<InstructorBean>> getInstructors(InstructorsSort sort,
      {int page, int perPage}) async {
    Map<String, dynamic> query = Map();

    switch (sort) {
      case InstructorsSort.rating:
        query.addParam("sort", "rating");
        break;
    }

    return (await apiProvider.getInstructors(query)).data;
  }
}
