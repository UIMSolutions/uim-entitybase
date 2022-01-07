module uim.entitybase.collections.null_;

@safe:
import uim.entitybase;

class DETBNullCollection : DETBCollection {
  this() { super(); }

  override bool isNull() { return true; }
  override bool notNull() { return false; }

// #region FindMany
  alias findMany = DETBCollection.findMany;
  /// Find all (many) items in a collection. allVersions:false = find last versions, allVersion:true = find all versions
  override DOOPEntity[] findMany(bool allVersions = false) { return null; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;    
      // Results always null / []
      assert(!col.findMany); 
      assert(!col.findMany(true)); }}

  /// Find all (many) items in a collection with id. allVersions:false = find last version, allVersion:true = find all versions
  override DOOPEntity[] findMany(UUID id, bool allVersions = false) { return null; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(!col.findMany(randomUUID)); 
      assert(!col.findMany(randomUUID, true)); 
      // TODO 
      }}

  override DOOPEntity[] findMany(STRINGAA select, bool allVersions = false) { return null; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(!col.findMany(["name":"aName"])); 
      assert(!col.findMany(["name":"aName"], true)); 
      // TODO 
      }}

  override DOOPEntity[] findMany(Json select, bool allVersions = false) { return null; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(!col.findMany(toJson(["name":"aName"]))); 
      assert(!col.findMany(toJson(["name":"aName"]), true)); 
      // TODO 
      }}
  // #endregion findMany

  // #region findOne
  // introduce base class overload set
  alias findOne = DETBCollection.findOne;
  //
  override DOOPEntity findOne(UUID id, bool allVersions = false) { return null; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(!col.findOne(randomUUID));
      assert(!col.findOne(randomUUID, true)); 
      // TODO 
      }}

  override DOOPEntity findOne(UUID id, size_t versionNumber) { return null; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection;
      assert(!col.findOne(randomUUID, 1));
      // TODO 
      }}

  override DOOPEntity findOne(STRINGAA select, bool allVersions = false) { return null; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(!col.findOne(["name":"aName"]));
      assert(!col.findOne(["name":"aName"], true));
      // TODO 
      }}

  override DOOPEntity findOne(Json select, bool allVersions = false) { return null; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(!col.findOne(toJson(["name":"aName"])));
      assert(!col.findOne(toJson(["name":"aName"]), true));
      // TODO 
      }}
  // #endregion findOne

  // #region insertOne
  override DOOPEntity insertOne(Json newData) { return findOne(newData); }  
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(!col.insertOne(toJson(["name":"aName"])));
      // TODO 
      }}
  // #endregion insertOne

  // #region updateMany
  override size_t updateMany(Json select, Json updateData) { return 0; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(col.updateMany(toJson(["id":randomUUID.toString]), toJson(["name":"aName"])) == 0); 
      // TODO
      }}
  // #endregion updateMany

  // #region updateOne
  override bool updateOne(Json select, Json updateData) { return false; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(col.updateOne(toJson(["id":randomUUID.toString]), toJson(["name":"aName"])) == 0); 
      // TODO
      }}
  // #endregion updateOne

  // #region removeMany
  /// Remove items from collections
  alias removeMany = DETBCollection.removeMany;
  /// Remove items from collectionsby it. allVersions:false - remove lastVersion, allVersion:true / allVersions (complete)
  override size_t removeMany(UUID id, bool allVersions = false) { return 0; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(col.removeMany(randomUUID) == 0);
      assert(col.removeMany(randomUUID, true) == 0);
      // TODO
      }}

  override size_t removeMany(STRINGAA select, bool allVersions = false) { return 0; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(col.removeMany(["name":"aName"]) == 0);
      assert(col.removeMany(["name":"aName"], true) == 0);
      // TODO
      }}

  override size_t removeMany(Json select, bool allVersions = false) { return 0; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(col.removeMany(toJson(["name":"aName"])) == 0);
      assert(col.removeMany(toJson(["name":"aName"]), true) == 0);
      // TODO
      }}
  // #endregion removeMany

  /// Remove one item or one version from collection
  alias removeOne = DETBCollection.removeOne;
  /// Remove based on id - allVersions:true - remove all, remove lastVersion 
  override bool removeOne(UUID id, bool allVersions = false) { return false; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(!col.removeOne(randomUUID));
      assert(!col.removeOne(randomUUID, true));
      // TODO
      }}

  override bool removeOne(UUID id, size_t versionNumber) { return false; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(!col.removeOne(randomUUID, 1));
      // TODO
      }}

  override bool removeOne(STRINGAA select, bool allVersions = false) { return false; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(!col.removeOne(["name": "aName"]));
      assert(!col.removeOne(["name": "aName"], true));
      // TODO
      }}

  override bool removeOne(Json select, bool allVersions = false) { return false; }
  unittest {
    version(test_uim_entitybase) {
      auto col = ETBNullCollection ;
      assert(!col.removeOne(toJson(["name": "aName"])));
      assert(!col.removeOne(toJson(["name": "aName"]), true));
      // TODO
      }}
}
auto ETBNullCollection() { return new DETBNullCollection; }