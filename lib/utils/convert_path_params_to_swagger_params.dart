///user/:id/:name to /user/{id}/{name}
String convertPathParamsToSwaggerParams(String path) {
  // Regex ile ':' karakteriyle başlayan bölümleri '{parametre_adi}' formatına çevirir.
  return path.replaceAllMapped(RegExp(r':(\w+)'), (match) {
    return '{${match.group(1)}}';
  });
}
