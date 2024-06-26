part of 'product_bloc.dart';

class ProductState extends Equatable {
  final bool isLoading;
  final List<dynamic> dataList;
  final String? error;

  const ProductState({
    required this.isLoading,
    required this.dataList,
    this.error,
  });

  ProductState copyWith({
    bool? isLoading,
    List<dynamic>? dataList,
    String? error,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      dataList: dataList ?? this.dataList,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, dataList, error];
}
