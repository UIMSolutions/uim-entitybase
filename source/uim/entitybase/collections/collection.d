module uim.entitybase.collections.collection;

@safe:
import uim.entitybase;

class DETBCollection {
  this() { this.jsCollection(JSBNullCollection); }
  this(DJSBCollection col) { 
    this();
    this.jsCollection(col); }
  this(Json options) {
    this(); 
    this.options(options); }
  this(DJSBCollection col, Json options) { 
    this(col); 
    this.options(options); }
  
  mixin(OProperty!("DJSBCollection", "jsCollection"));
  mixin(OProperty!("DETBTenant", "tenant"));
  mixin(OProperty!("string", "entityName"));

  O options(this O)(Json newOptions) {
    // TODO - OPtion handling
    return cast(O)this;
  }

  bool isNull() { return false; }

  bool has(Json entity, UUID id) {
    return "id" in entity ? entity["id"].get!string == id.toString : false; }

  bool has(Json entity, string name) {
    return "name" in entity ? entity["name"].get!string == name : false; }

  bool has(Json jsonData, size_t versionNumber = 0) {
    return (versionNumber != 0) && (jsonData["versionNumber"].get!size_t == versionNumber);
  }

  DOOPEntity[] toEntities(Json[] jsons) {
    debug writeln(moduleName!DETBCollection~":DETBCollection::toEntities(", jsons.length,")");
    auto one = jsons.map!(a => toEntity(a)).array;
    debug writeln(moduleName!DETBCollection~":DETBCollection::toEntities - 1:", one.length);
    auto two = one.filter!(a => a !is null).array;
    debug writeln(moduleName!DETBCollection~":DETBCollection::toEntities - 2:", two.length);
    return two; }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}
  DOOPEntity toEntity(Json json) {
    debug writeln("entity convert");
    return entityName in createEntities ? createEntities[entityName](json) : OOPEntity(json);
  }

  DOOPEntity create() { return create(Json(null)); }

  DOOPEntity create(Json json) {
    debug writeln("entity create");
    return entityName in createEntities ? createEntities[entityName](Json(null)) : OOPEntity(Json(null)); }

/*   Json lastVersion(string colName, UUID id) { return Json(null); }
  size_t lastVersionNumber(string colName, UUID id) { return 0; }
  
  DOOPEntity[] versions(string colName, UUID id) {
    return null;
  }
 */
/*   DOOPEntity[] versions(Json[size_t][UUID] col, UUID id) {
    if (id !in col) return null;
    return col[id].byValue.array; }

  DOOPEntity[] versions(Json[size_t] entity) { 
    return entity.byValue.array; } */

  string uniqueName(string firstName) {
    string tryName = firstName;
    while (count(["name":tryName]) > 0) {
      tryName = firstName~to!string(uniform(1, 1_000_000)); }
    return tryName; }

  /// Count all items in the collection with ids and versions.
  /// allVersion = true include versions; = false results in existing ids 
  size_t count(UUID[] ids, bool allVersions = false) {
    return jsCollection.count(ids, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}


  // #region Count 
  /// Count items in the collection with id and versions.
  /// allVersion = true include versions; = false results in existing id (1 if exists, 0 if none) 
  size_t count(UUID id, bool allVersions = false) {
    return jsCollection.count(id, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  /// Count all items in the collection with ids and versionNumber.
  /// allVersion = true include versions; = false results in existing ids 
  size_t count(UUID[] ids, size_t versionNumber) {
    return jsCollection.count(ids, versionNumber); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // Searching for existing id
  size_t count(UUID id, size_t versionNumber) {
    return jsCollection.count(id, versionNumber); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // Searching for existing selects
  size_t count(STRINGAA[] selects, bool allVersions = false) {
    return jsCollection.count(selects, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // Searching based on parameter "select":string[string]
  size_t count(STRINGAA select, bool allVersions = false) {
    return jsCollection.count(select, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // Searching for existing selects:doopentity[]
  size_t count(Json[] selects, bool allVersions = false) {
    return jsCollection.count(selects, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // Searching based on parameter "select":DOOPEntity[]
  size_t count(Json select, bool allVersions = false) {
    return jsCollection.count(select, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}
  // #endregion count

  // #region findMany
  // Searching in store
  DOOPEntity[] findMany(bool allVersions = false) {
    debug writeln(moduleName!DETBCollection~":DETBCollection::findMany(1)");
    auto jsons = jsCollection.findMany(allVersions);
    debug writeln(moduleName!DETBCollection~":DETBCollection::findMany(1) - Found jsons = ", jsons.length);
    return toEntities(jsons); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // Searching for existing ids
  DOOPEntity[] findMany(UUID[] ids, bool allVersions = false) {
    return toEntities(jsCollection.findMany(ids, allVersions)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // Searching for existing id
  DOOPEntity[] findMany(UUID id, bool allVersions = false) {
    return toEntities(jsCollection.findMany(id, allVersions)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}


  // Searching for existing ids & versionNumber
  DOOPEntity[] findMany(UUID[] ids, size_t versionNumber) {
    return toEntities(jsCollection.findMany(ids, versionNumber)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // Searching for existing selects
  DOOPEntity[] findMany(STRINGAA[] selects, bool allVersions = false) {
    return toEntities(jsCollection.findMany(selects, allVersions)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  /// Find all (many) items in a collection with select. allVersions:false = find last version, allVersion:true = find all versions
  DOOPEntity[] findMany(STRINGAA select, bool allVersions = false) {
    return toEntities(jsCollection.findMany(select, allVersions)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}
    
  // Searching for existing selects:doopentity[]
  DOOPEntity[] findMany(Json[] selects, bool allVersions = false) {
    return toEntities(jsCollection.findMany(selects, allVersions)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  /// Find all (many) items in a collection with select. allVersions:false = find last version, allVersion:true = find all versions
  DOOPEntity[] findMany(Json select, bool allVersions = false) {
    return toEntities(jsCollection.findMany(allVersions)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // #region findOne
  // Searching in store
  // Searching for existing ids
  DOOPEntity findOne(UUID[] ids, bool allVersions = false) {
    return toEntity(jsCollection.findOne(ids, allVersions)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // Searching for existing id
  DOOPEntity findOne(UUID id, bool allVersions = false) {
    return toEntity(jsCollection.findOne(id, allVersions)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  /// Searching for existing ids & versionNumber
  DOOPEntity findOne(UUID[] ids, size_t versionNumber) {
    return toEntity(jsCollection.findOne(ids, versionNumber)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  /// Searching for existing id & number
  DOOPEntity findOne(UUID id, size_t versionNumber) {
    return toEntity(jsCollection.findOne(id, versionNumber)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // Searching for existing selects
  DOOPEntity findOne(STRINGAA[] selects, bool allVersions = false) {
    return toEntity(jsCollection.findOne(selects, allVersions)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // Searching based on parameter "select":string[string]
  DOOPEntity findOne(STRINGAA select, bool allVersions = false) {
    return toEntity(jsCollection.findOne(select, allVersions)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // Searching for existing selects:doopentity[]
  DOOPEntity findOne(Json[] selects, bool allVersions = false) {
    return toEntity(jsCollection.findOne(selects, allVersions)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  /// Searching for one item with has parameters 
  DOOPEntity findOne(Json select, bool allVersions = false) {
    return toEntity(jsCollection.findOne(select, allVersions)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}
  // #endregion findOne

  // #region insertOne
  // Insert new entity or new version of an entity
  DOOPEntity insertOne(DOOPEntity entity) {
    return toEntity(jsCollection.insertOne(entity.toJson)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}
  // #endregion insertOne

  DOOPEntity insertOne(Json newData) {
    return toEntity(jsCollection.insertOne(newData)); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}
  // #endregion insertOne

  // #region updateMany
  size_t updateMany(STRINGAA select, STRINGAA updateData) { 
    return jsCollection.updateMany(select, updateData); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  size_t updateMany(STRINGAA select, Json updateData) {
    return jsCollection.updateMany(select, updateData); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  size_t updateMany(Json select, STRINGAA updateData) {
    return jsCollection.updateMany(select, updateData); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  size_t updateMany(Json select, Json updateData) {
    return jsCollection.updateMany(select, updateData); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}
  // #endregion updateMany

  // #region updateOne
  // Update entity
  bool updateOne(DOOPEntity entity) {
    return jsCollection.updateOne(entity.toJson(["id", "versionNumber"]), entity.toJson); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  bool updateOne(STRINGAA select, STRINGAA updateData) {
    return jsCollection.updateOne(select, updateData); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  bool updateOne(STRINGAA select, Json updateData) {
    return jsCollection.updateOne(select, updateData); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  bool updateOne(Json select, STRINGAA updateData) {
    return jsCollection.updateOne(select, updateData); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  bool updateOne(Json select, Json updateData) {
    return jsCollection.updateOne(select, updateData); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}
  // #endregion updateOne

  // #region removeMany
  // Remove entities 
  size_t removeMany(DOOPEntity[] entities, bool allVersions = false) {
    return entities.map!(a => removeMany(a, allVersions)).sum; }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // Remove entity 
  size_t removeMany(DOOPEntity entity, bool allVersions = false) {
    if (!entity) return 0;

    if (allVersions) return jsCollection.removeMany(entity.id, allVersions);
    else return jsCollection.removeMany(entity.id, entity.versionNumber); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // Remove entities with id
  size_t removeMany(UUID[] ids, bool allVersions = false) {
    return jsCollection.removeMany(ids, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  size_t removeMany(UUID id, bool allVersions = false) {
    return jsCollection.removeMany(id, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  size_t removeMany(UUID[] ids, size_t versionNumber) {
    return jsCollection.removeMany(ids, versionNumber); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  size_t removeMany(UUID id, size_t versionNumber) {
    return jsCollection.removeMany(id, versionNumber); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  size_t removeMany(STRINGAA[] selects, bool allVersions = false) {
    return jsCollection.removeMany(selects, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  size_t removeMany(STRINGAA select, bool allVersions = false) {
    return jsCollection.removeMany(select, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  size_t removeMany(Json[] selects, bool allVersions = false) {
    return jsCollection.removeMany(selects, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  size_t removeMany(Json select, bool allVersions = false) {
    return jsCollection.removeMany(select, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}
  // #region removeMany

  // #region removeOne
  bool removeOne(UUID[] ids, bool allVersions = false) {
    return jsCollection.removeOne(ids, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  // Remove entity from collection
  bool removeOne(DOOPEntity entity) {
    return removeOne(entity.id, entity.versionNumber); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  bool removeOne(UUID id, bool allVersions = false) {
    return jsCollection.removeOne(id, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  bool removeOne(UUID id, size_t versionNumber) {
    return jsCollection.removeOne(id, versionNumber); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  /// RemoveMany by select (string[string])
  bool removeOne(STRINGAA[] selects, bool allVersions = false) {
    return jsCollection.removeOne(selects, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  /// remove one selected item
  bool removeOne(STRINGAA select, bool allVersions = false) {
    return jsCollection.removeOne(select, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  /// remove first selected item from entities
  bool removeOne(DOOPEntity[] entities) {
    foreach(entity; entities) {
      if (removeOne(entity)) return true;
    }
    return false; }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  /// remove one selected item
  bool removeOne(Json[] selects, bool allVersions = false) {
    return jsCollection.removeOne(selects, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}

  /// remove one selected item
  bool removeOne(Json select, bool allVersions = false) {
    return jsCollection.removeOne(select, allVersions); }
  unittest {
    version(uim_entitybase) {
      // TODO
    }}
}
auto ETBCollection() { return new DETBCollection; }
auto ETBCollection(DJSBCollection col) { return new DETBCollection(col); }
auto ETBCollection(Json options) { return new DETBCollection(options); }
auto ETBCollection(DJSBCollection col, Json options) { return new DETBCollection(col, options); }

