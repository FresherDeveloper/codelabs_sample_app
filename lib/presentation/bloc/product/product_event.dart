part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchDataRequested extends ProductEvent {}
class FetchImageDetailsRequested extends ProductEvent {
  final String categoryId;

  const FetchImageDetailsRequested(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
