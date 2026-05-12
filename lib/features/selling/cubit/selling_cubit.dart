import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:optom/domain/selling/selling_repository.dart';
import 'package:optom/features/selling/cubit/selling_state.dart';

@injectable
class SellingCubit extends Cubit<SellingState> {
  final SellingRepository _sellingRepository;
  SellingCubit(this._sellingRepository) : super(SellingState());

  void getAllProducts(){}
}
