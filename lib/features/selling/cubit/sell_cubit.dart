import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sell_state.dart';

class SellCubit extends Cubit<SellState> {
  SellCubit() : super(SellInitial());
}
