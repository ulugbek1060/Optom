import 'package:optom/domain/products/prosuct_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_product_state.freezed.dart';

@freezed
class CreateProductState with _$CreateProductState {
  const factory CreateProductState({
    @Default(false) bool isLoading,
    @Default(null) Product? product,
    @Default(null) String? errorMessage,
  }) = _CreateProductState;
}
