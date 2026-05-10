import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:optom/features/products/viwemodel/create_product_state.dart';

@injectable
class CreateProductCubit extends Cubit<CreateProductState> {
  // final ProductRepository _productRepository;

  CreateProductCubit(
    // this._productRepository
  ) : super(CreateProductState());
}
