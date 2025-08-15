import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorsMapper {
  static Actor castEntity(Cast cast) => Actor(
    id: cast.id,
    name: cast.name,
    profilePath: cast.profilePath != null
        ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
        : 'https://wallpapers.com/images/hd/cool-profile-picture-paper-bag-head-4co57dtwk64fb7lv.jpg',
    character: cast.character,
  );
}
