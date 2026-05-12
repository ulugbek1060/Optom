import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(ProductDetailInitial());
}
