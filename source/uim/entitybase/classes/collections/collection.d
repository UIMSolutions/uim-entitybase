module uim.entitybase.classes.collections.collection;

@safe:
import uim.entitybase;

version(testUimEntitybase) { 
  unittest {
    debug writeln("\n", __MODULE__~":"~__PRETTY_FUNCTION__); 
  }
}

class DEntityCollection : IEntityCollection {
  this() { this.jsCollection(JSBNullCollection); }
  this(IJsonCollection col) { 
    this();
    this.jsCollection(col); }
  this(Json options) {
    this(); 
    this.options(options); }
  this(IJsonCollection col, Json options) { 
    this(col); 
    this.options(options); }
  
  mixin(OProperty!("IJsonCollection", "jsCollection"));
  mixin(OProperty!("IEntityCollectionManager", "manager"));
  mixin(OProperty!("string", "name"));

  protected DEntity _entityTemplate;
  @property DEntity entityTemplate() {
    return _entityTemplate;
  }
  @property O entityTemplate(this O)(DEntity newEntityTemplate) {
    _entityTemplate = (newEntityTemplate ? newEntityTemplate : Entity).collection(this);
    return cast(O)this;
  }

  O options(this O)(Json newOptions) {
    // TODO - OPtion handling
    return cast(O)this;
  }

  bool isNull() { return false; }
  bool notNull() { return true; }

  bool has(Json entity, UUID id) {
    return "id" in entity ? entity["id"].get!string == id.toString : false; }

  bool has(Json entity, string name) {
    return "name" in entity ? entity["name"].get!string == name : false; }

  bool has(Json jsonData, size_t versionNumber = 0) {
    return (versionNumber != 0) && (jsonData["versionNumber"].get!size_t == versionNumber); }

  DEntity createFromTemplate() {
    return cast(DEntity)(entityTemplate ? entityTemplate.create : null); }
    
  DEntity cloneFromTemplate() {
    return cast(DEntity)(entityTemplate ? entityTemplate.clone : null); }  

  DEntity[] toEntities(Json[] jsons) {
    // debug writeln(moduleName!DEntityCollection~":DEntityCollection::toEntities(", jsons.length,")");
    auto one = jsons.map!(a => toEntity(a)).array;
    // debug writeln(moduleName!DEntityCollection~":DEntityCollection::toEntities - 1:", one.length, );
    auto two = one.filter!(a => a !is null).array;
    // debug writeln(moduleName!DEntityCollection~":DEntityCollection::toEntities - 2:", two.length);
    return two; }

  DEntity toEntity(Json json) {
    if (entityTemplate) {
      auto result = cast(DEntity)entityTemplate.clone(json);
      result.collection(this);
      return result; } 
    return null; }

/*   Json lastVersion(string colName, UUID id) { return Json(null); }
  size_t lastVersionNumber(string colName, UUID id) { return 0; }
  
  DEntity[] versions(string colName, UUID id) {
    return null;
  }
 */
/*   DEntity[] versions(Json[size_t][UUID] col, UUID id) {
    if (id !in col) return null;
    return col[id].byValue.array; }

  DEntity[] versions(Json[size_t] entity) { 
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

  // #region Count 
    /// Count items in the collection with id and versions.
    /// allVersion = true include versions; = false results in existing id (1 if exists, 0 if none) 
    size_t count(bool allVersions = false) {
      return jsCollection.count(allVersions); }

    size_t count(UUID id, bool allVersions = false) {
      return jsCollection.count(id, allVersions); }

    /// Count all items in the collection with ids and versionNumber.
    /// allVersion = true include versions; = false results in existing ids 
    size_t count(UUID[] ids, size_t versionNumber) {
      return jsCollection.count(ids, versionNumber); 
    }

    // Searching for existing id
    size_t count(UUID id, size_t versionNumber) {
      return jsCollection.count(id, versionNumber); 
    }

    // Searching for existing selects
    size_t count(STRINGAA[] selects, bool allVersions = false) {
      return jsCollection.count(selects, allVersions); 
    }

    // Searching based on parameter "select":STRINGAA
    size_t count(STRINGAA select, bool allVersions = false) {
      return jsCollection.count(select, allVersions); 
    }

    // Searching for existing selects:dEntity[]
    size_t count(Json[] selects, bool allVersions = false) {
      return jsCollection.count(selects, allVersions);
    }

    // Searching based on parameter "select":DEntity[]
    size_t count(Json select, bool allVersions = false) {
      return 0; // jsCollection.count(select, allVersions); 
    }
  // #endregion count

  // #region findMany
    // Searching in store
    DEntity[] findMany(bool allVersions = false) {
      // debug writeln(moduleName!DEntityCollection~":DEntityCollection::findMany(1)");
      auto jsons = jsCollection.findMany(allVersions);
      // debug writeln(moduleName!DEntityCollection~":DEntityCollection::findMany(1) - Found jsons = ", jsons.length);
      return toEntities(jsons); }

    // Searching for existing ids
    DEntity[] findMany(UUID[] ids, bool allVersions = false) {
      return toEntities(jsCollection.findMany(ids, allVersions)); }

    // Searching for existing id
    DEntity[] findMany(UUID id, bool allVersions = false) {
      return toEntities(jsCollection.findMany(id, allVersions)); }

    // Searching for existing ids & versionNumber
    DEntity[] findMany(UUID[] ids, size_t versionNumber) {
      return toEntities(jsCollection.findMany(ids, versionNumber)); }

    // Searching for existing selects
    DEntity[] findMany(STRINGAA[] selects, bool allVersions = false) {
      return toEntities(jsCollection.findMany(selects, allVersions)); }

    /// Find all (many) items in a collection with select. allVersions:false = find last version, allVersion:true = find all versions
    DEntity[] findMany(STRINGAA select, bool allVersions = false) {
      return toEntities(jsCollection.findMany(select, allVersions)); }
      
    // Searching for existing selects:dEntity[]
    DEntity[] findMany(Json[] selects, bool allVersions = false) {
      return toEntities(jsCollection.findMany(selects, allVersions)); }

    /// Find all (many) items in a collection with select. allVersions:false = find last version, allVersion:true = find all versions
    DEntity[] findMany(Json select, bool allVersions = false) {
      return toEntities(jsCollection.findMany(allVersions)); }
  // #endregion findMany 

  // #region findOne
    // Searching in store
    // Searching for existing ids
    DEntity findOne(UUID[] ids, bool allVersions = false) {
      return toEntity(jsCollection.findOne(ids, allVersions)); }

    // Searching for existing id
    DEntity findOne(UUID id, bool allVersions = false) {
      return toEntity(jsCollection.findOne(id, allVersions)); }

    /// Searching for existing ids & versionNumber
    DEntity findOne(UUID[] ids, size_t versionNumber) {
      return toEntity(jsCollection.findOne(ids, versionNumber)); }

    /// Searching for existing id & number
    DEntity findOne(UUID id, size_t versionNumber) {
      return toEntity(jsCollection.findOne(id, versionNumber)); }

    // Searching for existing selects
    DEntity findOne(STRINGAA[] selects, bool allVersions = false) {
      return toEntity(jsCollection.findOne(selects, allVersions)); }

    // Searching based on parameter "select":STRINGAA
    DEntity findOne(STRINGAA select, bool allVersions = false) {
      return toEntity(jsCollection.findOne(select, allVersions)); }

    // Searching for existing selects:dEntity[]
    DEntity findOne(Json[] selects, bool allVersions = false) {
      return toEntity(jsCollection.findOne(selects, allVersions)); }

    /// Searching for one item with has parameters 
    DEntity findOne(Json select, bool allVersions = false) {
      return toEntity(jsCollection.findOne(select, allVersions)); }
  // #endregion findOne

  // #region insertOne
    // Insert new entity or new version of an entity
    DEntity insertOne(DEntity entity) {
      return toEntity(jsCollection.insertOne(entity.toJson)); }

    DEntity insertOne(Json newData) {
      return toEntity(jsCollection.insertOne(newData)); }

  // #endregion insertOne

  // #region updateMany
    size_t updateMany(STRINGAA select, STRINGAA updateData) { 
      return jsCollection.updateMany(select, updateData); }

    size_t updateMany(STRINGAA select, Json updateData) {
      return jsCollection.updateMany(select, updateData); }

    size_t updateMany(Json select, STRINGAA updateData) {
      return jsCollection.updateMany(select, updateData); }

    size_t updateMany(Json select, Json updateData) {
      return jsCollection.updateMany(select, updateData); }
  // #endregion updateMany

  // #region updateOne
    // Update entity
    bool updateOne(DEntity entity) {
      return jsCollection.updateOne(entity.toJson(["id", "versionNumber"]), entity.toJson); }

    bool updateOne(STRINGAA select, STRINGAA updateData) {
      return jsCollection.updateOne(select, updateData); }

    bool updateOne(STRINGAA select, Json updateData) {
      return jsCollection.updateOne(select, updateData); }

    bool updateOne(Json select, STRINGAA updateData) {
      return jsCollection.updateOne(select, updateData); }

    bool updateOne(Json select, Json updateData) {
      return jsCollection.updateOne(select, updateData); }
  // #endregion updateOne

  // #region removeMany
    // Remove entities 
    size_t removeMany(DEntity[] entities, bool allVersions = false) {
      return entities.map!(a => removeMany(a, allVersions)).sum; }

    // Remove entity 
    size_t removeMany(DEntity entity, bool allVersions = false) {
      if (!entity) return 0;

      if (allVersions) return jsCollection.removeMany(entity.id, allVersions);
      else return jsCollection.removeMany(entity.id, entity.versionNumber); }
    // Remove entities with id
    size_t removeMany(UUID[] ids, bool allVersions = false) {
      return jsCollection.removeMany(ids, allVersions); }


    size_t removeMany(UUID id, bool allVersions = false) {
      return jsCollection.removeMany(id, allVersions); }

    size_t removeMany(UUID[] ids, size_t versionNumber) {
      return jsCollection.removeMany(ids, versionNumber); }

    size_t removeMany(UUID id, size_t versionNumber) {
      return jsCollection.removeMany(id, versionNumber); }

    size_t removeMany(STRINGAA[] selects, bool allVersions = false) {
      return jsCollection.removeMany(selects, allVersions); }

    size_t removeMany(STRINGAA select, bool allVersions = false) {
      return jsCollection.removeMany(select, allVersions); }

    size_t removeMany(Json[] selects, bool allVersions = false) {
      return jsCollection.removeMany(selects, allVersions); }

    size_t removeMany(Json select, bool allVersions = false) {
      return jsCollection.removeMany(select, allVersions); }
  // #region removeMany

  // #region removeOne
    bool removeOne(UUID[] ids, bool allVersions = false) {
      return jsCollection.removeOne(ids, allVersions); }

    // Remove entity from collection
    bool removeOne(DEntity entity) {
      return removeOne(entity.id, entity.versionNumber); }

    bool removeOne(UUID id, bool allVersions = false) {
      return jsCollection.removeOne(id, allVersions); }

    bool removeOne(UUID id, size_t versionNumber) {
      return jsCollection.removeOne(id, versionNumber); }

    /// RemoveMany by select (STRINGAA)
    bool removeOne(STRINGAA[] selects, bool allVersions = false) {
      return jsCollection.removeOne(selects, allVersions); }

    /// remove one selected item
    bool removeOne(STRINGAA select, bool allVersions = false) {
      return jsCollection.removeOne(select, allVersions); }

    /// remove first selected item from entities
    bool removeOne(DEntity[] entities) {
      foreach(entity; entities) {
        if (removeOne(entity)) { return true; }
      }
      return false; }

    /// remove one selected item
    bool removeOne(Json[] selects, bool allVersions = false) {
      return jsCollection.removeOne(selects, allVersions); }

    /// remove one selected item
    bool removeOne(Json select, bool allVersions = false) {
      return jsCollection.removeOne(select, allVersions); }
  // #endregion removeOne
}
auto EntityCollection() { return new DEntityCollection; }
auto EntityCollection(IJsonCollection col) { return new DEntityCollection(col); }
auto EntityCollection(Json options) { return new DEntityCollection(options); }
auto EntityCollection(IJsonCollection col, Json options) { return new DEntityCollection(col, options); }

