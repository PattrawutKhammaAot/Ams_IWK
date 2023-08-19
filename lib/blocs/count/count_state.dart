part of 'count_bloc.dart';

class CountState extends Equatable {
  const CountState();

  @override
  List<Object> get props => [];
}

class CountInitial extends CountState {}

class GetListCountPlanLoadingState extends CountState {
  const GetListCountPlanLoadingState();
  @override
  List<Object> get props => [];
}

class GetListCountPlanLoadedState extends CountState {
  const GetListCountPlanLoadedState(this.item);
  final List<CountPlanModel> item;

  @override
  List<Object> get props => [item];
}

class GetListCountPlanErrorState extends CountState {
  const GetListCountPlanErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

///All

class CheckAllLoadingState extends CountState {
  const CheckAllLoadingState();
  @override
  List<Object> get props => [];
}

class CheckAllLoadedState extends CountState {
  const CheckAllLoadedState(this.item);
  final ResponseModel item;

  @override
  List<Object> get props => [item];
}

class CheckAllErrorState extends CountState {
  const CheckAllErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

// UnCheck
class CheckUncheckLoadingState extends CountState {
  const CheckUncheckLoadingState();
  @override
  List<Object> get props => [];
}

class CheckUncheckLoadedState extends CountState {
  const CheckUncheckLoadedState(this.item);
  final ResponseModel item;

  @override
  List<Object> get props => [item];
}

class CheckUncheckErrorState extends CountState {
  const CheckUncheckErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

///Check Total
class CheckTotalLoadingState extends CountState {
  const CheckTotalLoadingState();
  @override
  List<Object> get props => [];
}

class CheckTotalLoadedState extends CountState {
  const CheckTotalLoadedState(this.item);
  final ResponseModel item;

  @override
  List<Object> get props => [item];
}

class CheckTotalErrorState extends CountState {
  const CheckTotalErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
