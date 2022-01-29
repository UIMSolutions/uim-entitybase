module uim.entitybase.tenants.tenant;

@safe:
import uim.entitybase;

class DETBTenant {
  this() {}
  this(DJBTenant jbTenant) {
    this();
    importTenant(jbTenant); }
  this(Json options) {
    this();
    // TODO option handling
  }
  this(DJBTenant jbTenant, Json options) {
    this(jbTenant);
    this.options(options); 
  }

   O options(this O)(Json newOptions) {
    // TODO - Option handling
    return cast(O)this;
  }

  bool isNull() {
    return false; }
  unittest {
    version(test_uim_entitybase) {
      auto tenant = ETBTenant; 
      // TODO
      }}
  bool notNull() { return true; }

  void importTenant(DJBTenant jbTenant) {
    debug writeln(moduleName!DETBTenant, ":DETBTenant::importTenant()");
    debug writeln(jbTenant.collectionNames);

    if (jbTenant) foreach (name, jsCollection; jbTenant.collections)
      this.collection(name, ETBCollection(jsCollection));     
    }
  unittest {
    version(test_uim_entitybase) {
      auto tenant = ETBTenant; 
      // TODO
      }}

  protected DETBCollection[string] _collections;
  
  bool hasCollection(string collectionName) {
    return collectionName in _collections ? true : false; }
  unittest {
    version(test_uim_entitybase) {
      auto tenant = ETBTenant; 
      // TODO
      }}

  DETBCollection collection(string collectionName) {
    return _collections.get(collectionName, ETBNullCollection); }
  unittest {
    version(test_uim_entitybase) {
      auto tenant = ETBTenant; 
      // TODO
      }}

  // register collection with name
  O collection(this O)(DETBCollection[string] newCollections) {
    foreach(name, value; newCollections) collections(name, value);
    return cast(O)this; }
  unittest {
    version(test_uim_entitybase) {
      auto tenant = ETBTenant; 
      // TODO
      }}

  O collection(this O)(string collectionName, DETBCollection newCollection) {
    debug writeln("uim.entitybase.bases.base:DETBTenant::collection("~collectionName~", newCollectio)");
    _collections[collectionName] = newCollection.tenant(this);
    return cast(O)this; }
  unittest {
    version(test_uim_entitybase) {
      auto tenant = ETBTenant; 
      // TODO
      }}

  DETBCollection opIndex(string collectionName) {
    return collection(collectionName); 
  }

  version(test_uim_entitybase) {
    unittest {
      auto tenant = ETBTenant; 
      // TODO
      }}

  void opIndexAssign(DETBCollection newCollection, string collectionName) {
    _collections[collectionName] = newCollection; 
  }
  unittest {
    version(test_uim_entitybase) {
      auto tenant = ETBTenant; 
      // TODO
      }}


  auto collectionNames() { return _collections.byKey.array; }

  // Number of Collection in a tenant
  size_t count() {
    return _collections.length; }
  unittest {
    version(test_uim_entitybase) {
      auto tenant = ETBTenant; 
      // TODO
      }}
}
auto ETBTenant() { return new DETBTenant; }
auto ETBTenant(DJBTenant jbTenant) { return new DETBTenant(jbTenant); }
auto ETBTenant(Json options) { return new DETBTenant(options); }
auto ETBTenant(DJBTenant jbTenant, Json options) { return new DETBTenant(jbTenant, options); }

