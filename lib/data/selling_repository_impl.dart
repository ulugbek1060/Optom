import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:optom/core/exceptions/exceptions.dart';
import 'package:optom/domain/selling/product_filter.dart';
import 'package:optom/domain/selling/selling_repository.dart';

@Injectable(as: SellingRepository)
class SellingRepositoryImpl implements SellingRepository {
  @override
  Future<Either<Failure, Unit>> getAllProducts(FilterType filter) {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }
}
