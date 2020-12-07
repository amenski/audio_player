/// A field is equivalent to a getter/setter pair.
/// A final field is equivalent to a getter.
/// Change this pattern only(to add getters/setters) if additionally logic is required (e.g. validation)
class Version {
  int id;
  int version;

  Version(this.version);

  factory Version.fromJson(Map<String, dynamic> json) {
    return new Version(json["version"]);
  }
}