part of 'tic_tac_toe_agent_cubit.dart';

class TicTacToeAgentState extends Equatable {
  const TicTacToeAgentState({
//0-1 arası değer alır. epsilon değeri yüksek olduğu sürece ajan daha fazla rastgele adım atar.
    required this.epsilonForX,
    required this.epsilonForY,
//0-1 arası değer alır. Bu değer, ajanın her adımda ne kadar öğrenmesi gerektiğini kontrol eder
    required this.alphaForX, 
    required this.alphaForY,
//0-1 arası değer alır. Bu değer, ajanın gelecekteki ödüllerin şu anki ödürlere göre ne kadar önemli olduğunu kontrol eder. 
    required this.gammaForX, 
    required this.gammaForY, 
//Ajan bu tabloları kullanarak her durum için en iyi aksiyonu seçmeye çalışır
    required this.qTableForX,
    required this.qTableForY,
// Bu listeler ajanın geçmiş oyunlarını tutar
    required this.qTableValuesForX,
    required this.qTableValuesForY,
  });
  final double epsilonForX;
  final double epsilonForY;
  final double alphaForX;
  final double alphaForY;
  final double gammaForX;
  final double gammaForY;
  final Map<String, double> qTableForX;
  final Map<String, double> qTableForY;
  final List<String> qTableValuesForX;
  final List<String> qTableValuesForY;

  TicTacToeAgentState copyWith({
    double? epsilonForX,
    double? epsilonForY,
    double? alphaForX,
    double? alphaForY,
    double? gammaForX,
    double? gammaForY,
    Map<String, double>? qTableForX,
    Map<String, double>? qTableForY,
    List<String>? qTableValuesForX,
    List<String>? qTableValuesForY,
  }) {
    return TicTacToeAgentState(
      epsilonForX: epsilonForX ?? this.epsilonForX,
      epsilonForY: epsilonForY ?? this.epsilonForY,
      alphaForX: alphaForX ?? this.alphaForX,
      alphaForY: alphaForY ?? this.alphaForY,
      gammaForX: gammaForX ?? this.gammaForX,
      gammaForY: gammaForY ?? this.gammaForY,
      qTableForX: qTableForX ?? this.qTableForX,
      qTableForY: qTableForY ?? this.qTableForY,
      qTableValuesForX: qTableValuesForX ?? this.qTableValuesForX,
      qTableValuesForY: qTableValuesForY ?? this.qTableValuesForY,
    );
  }

  @override
  List<Object?> get props => [
        epsilonForX,
        epsilonForY,
        alphaForX,
        alphaForY,
        gammaForX,
        gammaForY,
        qTableForX,
        qTableForY,
        qTableValuesForX,
        qTableValuesForY,
      ];
}
