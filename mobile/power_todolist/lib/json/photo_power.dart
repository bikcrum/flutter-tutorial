class PhotoPower {

  /**
   * id : "aH8tRjQG4XM"
   * created_at : "2019-07-18T06:20:04-04:00"
   * updated_at : "2019-07-18T06:55:09-04:00"
   * color : "#C68E7A"
   * sponsored : false
   * liked_by_user : false
   * width : 2254
   * height : 2817
   * likes : 35
   * links : {"self":"https://api.unsplash.com/photos/aH8tRjQG4XM","html":"https://unsplash.com/photos/aH8tRjQG4XM","download":"https://unsplash.com/photos/aH8tRjQG4XM/download","download_location":"https://api.unsplash.com/photos/aH8tRjQG4XM/download"}
   * urls : {"raw":"https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjgxNjY3fQ","full":"https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjgxNjY3fQ","regular":"https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjgxNjY3fQ","small":"https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjgxNjY3fQ","thumb":"https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjgxNjY3fQ"}
   * user : {"id":"hHQGJB9ZejE","updated_at":"2019-07-18T07:57:50-04:00","username":"rotaalternativa","name":"Rota Alternativa","first_name":"Rota","last_name":"Alternativa","twitter_username":null,"portfolio_url":"https://www.instagram.com/rotaalternativarv/","bio":"We are exploring the nomad and simple life the road has to offer. Living in our 1992 Fiat Talento motorhome.","location":null,"links":{"self":"https://api.unsplash.com/users/rotaalternativa","html":"https://unsplash.com/@rotaalternativa","photos":"https://api.unsplash.com/users/rotaalternativa/photos","likes":"https://api.unsplash.com/users/rotaalternativa/likes","portfolio":"https://api.unsplash.com/users/rotaalternativa/portfolio","following":"https://api.unsplash.com/users/rotaalternativa/following","followers":"https://api.unsplash.com/users/rotaalternativa/followers"},"profile_image":{"small":"https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32","medium":"https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64","large":"https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128"},"instagram_username":"rotaalternativarv","total_collections":0,"total_likes":1,"total_photos":72,"accepted_tos":true}
   */

  String id;
  String created_at;
  String updated_at;
  String color;
  bool sponsored;
  bool liked_by_user;
  int width;
  int height;
  int likes;
  LinksPower links;
  UrlsPower urls;
  UserPower user;

  static PhotoPower fromMap(Map<String, dynamic> map) {
    PhotoPower photo_power = new PhotoPower();
    photo_power.id = map['id'];
    photo_power.created_at = map['created_at'];
    photo_power.updated_at = map['updated_at'];
    photo_power.color = map['color'];
    photo_power.sponsored = map['sponsored'];
    photo_power.liked_by_user = map['liked_by_user'];
    photo_power.width = map['width'];
    photo_power.height = map['height'];
    photo_power.likes = map['likes'];
    photo_power.links = LinksPower.fromMap(map['links']);
    photo_power.urls = UrlsPower.fromMap(map['urls']);
    photo_power.user = UserPower.fromMap(map['user']);
    return photo_power;
  }

  static List<PhotoPower> fromMapList(dynamic mapList) {
    List<PhotoPower> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}

class LinksPower {

  /**
   * self : "https://api.unsplash.com/users/rotaalternativa"
   * html : "https://unsplash.com/@rotaalternativa"
   * photos : "https://api.unsplash.com/users/rotaalternativa/photos"
   * likes : "https://api.unsplash.com/users/rotaalternativa/likes"
   * portfolio : "https://api.unsplash.com/users/rotaalternativa/portfolio"
   * following : "https://api.unsplash.com/users/rotaalternativa/following"
   * followers : "https://api.unsplash.com/users/rotaalternativa/followers"
   */

  String self;
  String html;
  String photos;
  String likes;
  String portfolio;
  String following;
  String followers;

  static LinksPower fromMap(Map<String, dynamic> map) {
    LinksPower linksPower = new LinksPower();
    linksPower.self = map['self'];
    linksPower.html = map['html'];
    linksPower.photos = map['photos'];
    linksPower.likes = map['likes'];
    linksPower.portfolio = map['portfolio'];
    linksPower.following = map['following'];
    linksPower.followers = map['followers'];
    return linksPower;
  }

  static List<LinksPower> fromMapList(dynamic mapList) {
    List<LinksPower> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class UrlsPower {

  /**
   * raw : "https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjgxNjY3fQ"
   * full : "https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjgxNjY3fQ"
   * regular : "https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjgxNjY3fQ"
   * small : "https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjgxNjY3fQ"
   * thumb : "https://images.unsplash.com/photo-1563445192071-fb5b2fa4ad62?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjgxNjY3fQ"
   */

  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  static UrlsPower fromMap(Map<String, dynamic> map) {
    UrlsPower urlsPower = new UrlsPower();
    urlsPower.raw = map['raw'];
    urlsPower.full = map['full'];
    urlsPower.regular = map['regular'];
    urlsPower.small = map['small'];
    urlsPower.thumb = map['thumb'];
    return urlsPower;
  }

  static List<UrlsPower> fromMapList(dynamic mapList) {
    List<UrlsPower> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class UserPower {

  /**
   * id : "hHQGJB9ZejE"
   * updated_at : "2019-07-18T07:57:50-04:00"
   * username : "rotaalternativa"
   * name : "Rota Alternativa"
   * first_name : "Rota"
   * last_name : "Alternativa"
   * portfolio_url : "https://www.instagram.com/rotaalternativarv/"
   * bio : "We are exploring the nomad and simple life the road has to offer. Living in our 1992 Fiat Talento motorhome."
   * instagram_username : "rotaalternativarv"
   * accepted_tos : true
   * total_collections : 0
   * total_likes : 1
   * total_photos : 72
   * links : {"self":"https://api.unsplash.com/users/rotaalternativa","html":"https://unsplash.com/@rotaalternativa","photos":"https://api.unsplash.com/users/rotaalternativa/photos","likes":"https://api.unsplash.com/users/rotaalternativa/likes","portfolio":"https://api.unsplash.com/users/rotaalternativa/portfolio","following":"https://api.unsplash.com/users/rotaalternativa/following","followers":"https://api.unsplash.com/users/rotaalternativa/followers"}
   * profile_image : {"small":"https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32","medium":"https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64","large":"https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128"}
   */

  String id;
  String updated_at;
  String username;
  String name;
  String first_name;
  String last_name;
  String portfolio_url;
  String bio;
  String instagram_username;
  bool accepted_tos;
  int total_collections;
  int total_likes;
  int total_photos;
  LinksPower links;
  Profile_imagePower profile_image;

  static UserPower fromMap(Map<String, dynamic> map) {
    UserPower userPower = new UserPower();
    userPower.id = map['id'];
    userPower.updated_at = map['updated_at'];
    userPower.username = map['username'];
    userPower.name = map['name'];
    userPower.first_name = map['first_name'];
    userPower.last_name = map['last_name'];
    userPower.portfolio_url = map['portfolio_url'];
    userPower.bio = map['bio'];
    userPower.instagram_username = map['instagram_username'];
    userPower.accepted_tos = map['accepted_tos'];
    userPower.total_collections = map['total_collections'];
    userPower.total_likes = map['total_likes'];
    userPower.total_photos = map['total_photos'];
    userPower.links = LinksPower.fromMap(map['links']);
    userPower.profile_image = Profile_imagePower.fromMap(map['profile_image']);
    return userPower;
  }

  static List<UserPower> fromMapList(dynamic mapList) {
    List<UserPower> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class Profile_imagePower {

  /**
   * small : "https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32"
   * medium : "https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64"
   * large : "https://images.unsplash.com/profile-1550700203074-81551f41d6fe?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128"
   */

  String small;
  String medium;
  String large;

  static Profile_imagePower fromMap(Map<String, dynamic> map) {
    Profile_imagePower profile_imagePower = new Profile_imagePower();
    profile_imagePower.small = map['small'];
    profile_imagePower.medium = map['medium'];
    profile_imagePower.large = map['large'];
    return profile_imagePower;
  }

  static List<Profile_imagePower> fromMapList(dynamic mapList) {
    List<Profile_imagePower> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
