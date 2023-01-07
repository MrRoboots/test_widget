import 'package:flutter/foundation.dart';

extension DoubleExtension on double {
  bool get isZero => abs() < precisionErrorTolerance;

  int compare(double other, {double precision = precisionErrorTolerance}) {
    if (isNaN || other.isNaN) {
      throw UnsupportedError('Compared with Infinity or NaN');
    }
    final double n = this - other;
    if (n.abs() < precision) {
      return 0;
    }
    return n < 0 ? -1 : 1;
  }

  bool greaterThan(double other, {double precision = precisionErrorTolerance}) {
    return compare(other, precision: precision) > 0;
  }

  bool lessThan(double other, {double precision = precisionErrorTolerance}) {
    return compare(other, precision: precision) < 0;
  }

  bool equalTo(double other, {double precision = precisionErrorTolerance}) {
    return compare(other, precision: precision) == 0;
  }

  bool greaterThanOrEqualTo(double other, {double precision = precisionErrorTolerance}) {
    return compare(other, precision: precision) >= 0;
  }

  bool lessThanOrEqualTo(double other, {double precision = precisionErrorTolerance}) {
    return compare(other, precision: precision) <= 0;
  }
}
