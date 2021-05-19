import 'package:flutter/material.dart';

class Participant {
  num id;
  String display;
  bool setup;
  bool muted;
  bool talking;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  Participant({
    @required this.id,
    @required this.display,
    @required this.setup,
    this.muted,
    this.talking,
  });

  Participant copyWith({
    num id,
    String display,
    bool setup,
    bool muted,
    bool talking,
  }) {
    return new Participant(
      id: id ?? this.id,
      display: display ?? this.display,
      setup: setup ?? this.setup,
      muted: muted ?? this.muted,
      talking: talking ?? this.talking,
    );
  }

  @override
  String toString() {
    return 'Participant{id: $id, display: $display, setup: $setup, muted: $muted, talking: $talking}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Participant &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          display == other.display &&
          setup == other.setup &&
          muted == other.muted &&
          talking == other.talking);

  @override
  int get hashCode =>
      id.hashCode ^
      display.hashCode ^
      setup.hashCode ^
      muted.hashCode ^
      talking.hashCode;

  factory Participant.fromMap(Map<String, dynamic> map) {
    return new Participant(
      id: map['id'] as num,
      display: map['display'] as String,
      setup: map['setup'] as bool,
      muted: map['muted'] as bool,
      talking: map['talking'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'display': this.display,
      'setup': this.setup,
      'muted': this.muted,
      'talking': this.talking,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
