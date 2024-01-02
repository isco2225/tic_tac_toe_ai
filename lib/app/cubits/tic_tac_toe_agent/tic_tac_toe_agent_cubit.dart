import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'tic_tac_toe_agent_state.dart';

class TicTacToeAgentCubit extends Cubit<TicTacToeAgentState> {
  TicTacToeAgentCubit()
      : super(
          const TicTacToeAgentState(
            epsilonForX: 0.9,
            epsilonForY: 0.9, //epsilon değeri
            alphaForX: 0.1,
            alphaForY: 0.1,
            gammaForX: 0.9,
            gammaForY: 0.9,
            qTableForX: {},
            qTableForY: {},
            qTableValuesForX: [],
            qTableValuesForY: [],
          ),
        );
//bu fonksiyon oyun tahtasını temsil ediyor
  String? tabloAl(List<int> tahta) {
    final oyunTablosu = tahta.toString();

    return oyunTablosu;
  }
//oyun duruöunu q tablosuna ekler.
  void durumEkle(String oyunTablosu, int currentPlayer) {
    if (currentPlayer == 1) {
      final holdQTableValueForX = List<String>.from(state.qTableValuesForX);
      holdQTableValueForX.add(oyunTablosu);
      emit(state.copyWith(
        qTableValuesForX: holdQTableValueForX,
      ));
    }
    if (currentPlayer == -1) {
      final holdQTableValueForY = List<String>.from(state.qTableValuesForY);
      holdQTableValueForY.add(oyunTablosu);
      emit(state.copyWith(
        qTableValuesForY: holdQTableValueForY,
      ));
    }
  }
//oyuncunun o anki konumunda yapabileceği hamleyi seçer.
  int aksiyonSec(
    List<int> bosKonumlar,
    List<int> tahta,
    int oyuncuNumarasi,
  ) {
    double value;
    final random = Random();
    int? aksiyon;

    if (oyuncuNumarasi == 1) {
      if (random.nextDouble() <= state.epsilonForX) {
        aksiyon = bosKonumlar[random.nextInt(bosKonumlar.length)];
      } else {
        double maxDeger = -999;
        for (final konum in bosKonumlar) {
          List<int> sonrakiTahta = List<int>.from(tahta);
          sonrakiTahta[konum] = oyuncuNumarasi;

          final sonrakiOyunTablosu = tabloAl(sonrakiTahta);
          if (state.qTableForX[sonrakiOyunTablosu] == null) {
            value = 0.0;
          } else {
            value = state.qTableForX[sonrakiOyunTablosu]!; // Şupheli ve önemli
          }
          if (value >= maxDeger) {
            maxDeger = value;
            aksiyon = konum;
          }
        }
      }
    }
    if (oyuncuNumarasi == -1) {
      if (random.nextDouble() <= state.epsilonForY) {
        aksiyon = bosKonumlar[random.nextInt(bosKonumlar.length)];
      } else {
        double maxDeger = -999;
        for (final konum in bosKonumlar) {
          List<int> sonrakiTahta = List<int>.from(tahta);
          sonrakiTahta[konum] = oyuncuNumarasi;

          final sonrakiOyunTablosu = tabloAl(sonrakiTahta);
          if (state.qTableForY[sonrakiOyunTablosu] == null) {
            value = 0.0;
          } else {
            value = state.qTableForY[sonrakiOyunTablosu]!; // Şupheli ve önemli
          }
          if (value >= maxDeger) {
            maxDeger = value;
            aksiyon = konum;
          }
        }
      }
    }
    if (aksiyon == null) {
      bosKonumlar[random.nextInt(bosKonumlar.length)];
    }
   // aksiyon ??= bosKonumlar[random.nextInt(bosKonumlar.length)];

    return aksiyon!;
  }
//oyun sonunda oyuncunun aldığı ödüllere göre q tablosunu günceller.
  void feedReward({required double rewardForX, required double rewardForY}) {
    for (final reversedState in state.qTableValuesForX.reversed) {
      if (state.qTableForX[reversedState] == null) {
        final holdStatesValue = Map<String, double>.from(state.qTableForX);
        holdStatesValue[reversedState] = 0;
        emit(state.copyWith(qTableForX: holdStatesValue));
      }
      final holdStatesValue = Map<String, double>.from(state.qTableForX);

      holdStatesValue[reversedState] = state.qTableForX[reversedState]! +
          state.alphaForX *
              (state.gammaForX * rewardForX -
                  state.qTableForX[reversedState]!); //tehlike
      emit(state.copyWith(qTableForX: holdStatesValue));
      rewardForX = state.qTableForX[reversedState]!; //tehlike
    }
    for (final reversedState in state.qTableValuesForY.reversed) {
      if (state.qTableForY[reversedState] == null) {
        final holdStatesValue = Map<String, double>.from(state.qTableForY);
        holdStatesValue[reversedState] = 0;
        emit(state.copyWith(qTableForY: holdStatesValue));
      }
      final holdStatesValue = Map<String, double>.from(state.qTableForY);

      holdStatesValue[reversedState] = state.qTableForY[reversedState]! +
          state.alphaForY *
              (state.gammaForY * rewardForY -
                  state.qTableForY[reversedState]!); //tehlike
      emit(state.copyWith(qTableForY: holdStatesValue));
      rewardForY = state.qTableForY[reversedState]!; //tehlike
    }
  }

  void reset() {
    emit(state.copyWith(
      qTableValuesForX: [],
      qTableValuesForY: [],
    ));
  }
}