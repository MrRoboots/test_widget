/*
class DgEntity {
  final String? eye;
  final String? game;
  final String? pc;
  final bool? phone;
  final String? medal;
  final String? weishi;
  final String? safe;
  final String? qzone;
  final String? walk;

  DgEntity({
    this.eye,
    this.game,
    this.pc,
    this.phone,
    this.medal,
    this.weishi,
    this.safe,
    this.qzone,
    this.walk,
  });

  factory DgEntity.fromJson(Map<String, dynamic> json) {
    return DgEntity(
      eye: json['eye'],
      game: json['game'],
      pc: json['pc'],
      phone: json['phone'],
      medal: json['medal'],
      weishi: json['weishi'],
      safe: json['safe'],
      qzone: json['qzone'],
      walk: json['walk'],
    );
  }

  Map<String, dynamic> toJson() => {
        'eye': eye,
        'game': game,
        'pc': pc,
        'phone': phone,
        'medal': medal,
        'weishi': weishi,
        'safe': safe,
        'qzone': qzone,
        'walk': walk,
      };
}

class InfoEntity {
  final String? todayNum;
  final DgEntity? dg;
  final String? level;
  final String? vipYear;
  final num? threeCrownDay;
  final String? levelNum;
  final num? twoCrownDay;
  final String? todaySpeed;
  final String? nexLevelDay;
  final num? oneCrownDay;
  final String? nickname;
  final String? vipLevel;
  final String? logo;
  final num? uin;
  final num? fourCrownDay;
  final String? vip;
  final String? svip;

  InfoEntity({
    this.todayNum,
    this.dg,
    this.level,
    this.vipYear,
    this.threeCrownDay,
    this.levelNum,
    this.twoCrownDay,
    this.todaySpeed,
    this.nexLevelDay,
    this.oneCrownDay,
    this.nickname,
    this.vipLevel,
    this.logo,
    this.uin,
    this.fourCrownDay,
    this.vip,
    this.svip,
  });

  factory InfoEntity.fromJson(Map<String, dynamic> json) {
    return InfoEntity(
      todayNum: json['today-num'],
      dg: json['dg'] == null ? null : DgEntity.fromJson(json['dg']),
      level: json['level'],
      vipYear: json['vip-year'],
      threeCrownDay: json['three-crown-day'],
      levelNum: json['level-num'],
      twoCrownDay: json['two-crown-day'],
      todaySpeed: json['today-speed'],
      nexLevelDay: json['nex-level-day'],
      oneCrownDay: json['one-crown-day'],
      nickname: json['nickname'],
      vipLevel: json['vip-level'],
      logo: json['logo'],
      uin: json['uin'],
      fourCrownDay: json['four-crown-day'],
      vip: json['vip'],
      svip: json['svip'],
    );
  }

  Map<String, dynamic> toJson() => {
        'todayNum': todayNum,
        'dg': dg,
        'level': level,
        'vipYear': vipYear,
        'threeCrownDay': threeCrownDay,
        'levelNum': levelNum,
        'twoCrownDay': twoCrownDay,
        'todaySpeed': todaySpeed,
        'nexLevelDay': nexLevelDay,
        'oneCrownDay': oneCrownDay,
        'nickname': nickname,
        'vipLevel': vipLevel,
        'logo': logo,
        'uin': uin,
        'fourCrownDay': fourCrownDay,
        'vip': vip,
        'svip': svip,
      };
}

class MyModel {
  final num? code;
  final InfoEntity? info;

  MyModel({
    this.code,
    this.info,
  });

  factory MyModel.fromJson(Map<String, dynamic> json) {
    return MyModel(
      code: json['code'],
      info: json['info'] == null ? null : InfoEntity.fromJson(json['info']),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'info': info,
      };
}
*/
