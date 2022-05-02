// ignore: file_names
class MovieModel {
  String rankIndex = '';
  String alias = '';
  String year = '';
  String originalName = '';
  String doubanRating = '';
  MovieDesModel movieModel = MovieDesModel.fromMap({
    'poster': '',
    'name': '',
    'genre': '',
    'description': '',
    'shareImage': ''
  });
  MovieModel.fromJson(Map<String, dynamic> element) {
    alias = element['alias'];
    year = element['year'];
    originalName = element['originalName'];
    doubanRating = element['doubanRating'];
    year = element['year'];
    if ((element['data'] as List).isNotEmpty) {
      movieModel = MovieDesModel.fromMap(element['data'][0]);
    }
  }
}

class MovieDesModel {
  String poster = '';
  String name = '';
  String genre = '';
  String description = '';
  String shareImage = '';

  MovieDesModel.fromMap(Map<String, dynamic> element) {
    poster = element['poster'];
    name = element['name'];
    genre = element['genre'];
    description = element['description'];
    shareImage = element['shareImage'] ?? '';
  }
}
