
import 'package:optom/domain/selling/product_filter.dart';

class SellingState {
  final bool isLoading;
  final String? error;
  final FilterType selectedFilter;

  SellingState({
    this.isLoading = false,
    this.error,
    this.selectedFilter = FilterType.all,
  });
}
