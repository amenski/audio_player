/// A field is equivalent to a getter/setter pair.
/// A final field is equivalent to a getter.
/// Change this pattern only(to add getters/setters) if additionally logic is required (e.g. validation)
class Version {
  int id;
  int version;
  //BE
  String type;
  String objectId; // an id associated with the Post or Category

  Version({
      this.id,
      this.version,
      this.type,
      this.objectId
    });

  Version.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.version = map["version"];
  }

  factory Version.fromJson(Map<String, dynamic> parsedJson){
    return Version(
        version: parsedJson['versionNumber'],
        type : parsedJson['objectType'],
        objectId : parsedJson ['objectId']
    );
  }
}