import 'package:equatable/equatable.dart';

class WalletCoinEntity extends Equatable {
  final String name;
  double count;
  double value;

  WalletCoinEntity({
    required this.name,
    this.count = 0,
    this.value = 0,
  });

  double get sum => count * value;

  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[name];
}
