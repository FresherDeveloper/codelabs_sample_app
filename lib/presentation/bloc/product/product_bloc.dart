import 'package:coinone_sample_app/domain/use_cases/sign_in_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final SignInUseCase signInUseCase;

  ProductBloc(this.signInUseCase)
      : super(const ProductState(isLoading: false, dataList: [])) {
    on<FetchDataRequested>(_onFetchDataRequested);
     on<FetchImageDetailsRequested>(_onFetchImageDetailsRequested);
  }

  Future<void> _onFetchDataRequested(
      FetchDataRequested event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final dataList = await signInUseCase.fetchData();
      emit(state.copyWith(isLoading: false, dataList: dataList));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onFetchImageDetailsRequested(
      FetchImageDetailsRequested event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final imageDetails = await signInUseCase.fetchImageDetails(event.categoryId);
      emit(state.copyWith(isLoading: false, dataList: imageDetails));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
