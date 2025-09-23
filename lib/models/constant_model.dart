class ConstantModel {
  final String symbol;
  final String name;
  final String value;

  ConstantModel({
    required this.symbol,
    required this.name,
    required this.value,
  });

  factory ConstantModel.fromJson(Map<String, dynamic> json) {
    return ConstantModel(
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'value': value,
    };
  }
}
