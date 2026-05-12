import 'package:dartz/dartz.dart';
import 'package:optom/core/exceptions/exceptions.dart';
import 'package:optom/domain/selling/product_filter.dart';

abstract class SellingRepository {
  Future<Either<Failure, Unit>> getAllProducts(FilterType filter);
}
