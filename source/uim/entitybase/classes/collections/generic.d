module uim.entitybase.collections.generic;

@safe:
import uim.entitybase;

class DEntityGenericCollection(T) : DEntityCollection {
  this() { }
  
  auto findMany(STRINGAA select, bool allVersions = false) {
    auto jsons = jsCollection.findMany(select, allVersions);
    if (jsons) return jsons.map!(a => new T(a)).array;
    return null;
  }

  auto findMany(Json select, bool allVersions = false) {
    auto jsons = jsCollection.findMany(select, allVersions);
    if (jsons) return jsons.map!(a => new T(a)).array;
    return null;
  }

  DEntity findOne(UUID id, size_t versionId = 0) {
    auto json = jsCollection.findOne(id, versionId);
    if (json != Json(null)) return new T(json);
    return null;
  }

  DEntity findOne(STRINGAA select, bool allVersions = false) {
    auto json = jsCollection.findOne(select, allVersions);
    if (json != Json(null)) return new T(json);
    return null;
  }

  DEntity findOne(Json select, bool allVersions = false) {
    auto json = jsCollection.findOne(select, allVersions);
    if (json != Json(null)) return new T(json);
    return null;
  }

  O insertOne(this O)(DEntity newEntity) {
    if (jsCollection) jsCollection.insertOne(newEntity.toJson);
    return cast(O)this;
  }
}
auto EntityCollection() { return new DEntityCollection; }