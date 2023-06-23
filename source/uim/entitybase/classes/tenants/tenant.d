module uim.entitybase.tenants.tenant;

@safe:
import uim.entitybase;

class DEntityTenant {
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
version(test_uim_entitybase) {
  unittest {
      auto tenant = EntityTenant; 
      // TODO
      }}
  bool notNull() { return true; }

  void importTenant(DJBTenant jbTenant) {
    // debug writeln(moduleName!DEntityTenant, ":DEntityTenant::importTenant()");
    // debug writeln(jbTenant.collectionNames);

    if (jbTenant) foreach (name, jsCollection; jbTenant.collections)
      this.collection(name, EntityCollection(jsCollection));     
    }
version(test_uim_entitybase) {
  unittest {
      auto tenant = EntityTenant; 
      // TODO
      }}

  protected DEntityCollection[string] _collections;
  
  bool hasCollection(DEntity entity) {
    return entity ? hasCollection(entity.registerPath) : false; }
  bool hasCollection(string collectionName) {
    return collectionName in _collections ? true : false; }
version(test_uim_entitybase) {
  unittest {
      auto tenant = EntityTenant; 
      // TODO
      }}

  DEntityCollection collection(DEntity entity) {
    return entity ? collection(entity.registerPath) : null; }
  DEntityCollection collection(string collectionName) {
    return _collections.get(collectionName, EntityNullCollection); }
version(test_uim_entitybase) {
  unittest {
      auto tenant = EntityTenant; 
      // TODO
      }}

  // register collection with name
  O collection(this O)(DEntityCollection[string] newCollections) {
    foreach(name, value; newCollections) collections(name, value);
    return cast(O)this; }
version(test_uim_entitybase) {
  unittest {
      auto tenant = EntityTenant; 
      // TODO
      }}

  O collection(this O)(string collectionName, DEntityCollection newCollection) {
    // debug writeln("uim.entitybase.bases.base:DEntityTenant::collection("~collectionName~", newCollectio)");
    _collections[collectionName] = newCollection.tenant(this);
    return cast(O)this; }
version(test_uim_entitybase) {
  unittest {
      auto tenant = EntityTenant; 
      // TODO
      }}

  DEntityCollection opIndex(DEntity entity) {
    return collection(entity); }
  DEntityCollection opIndex(string collectionName) {
    return collection(collectionName);}

  version(test_uim_entitybase) {
    unittest {
      auto tenant = EntityTenant; 
      // TODO
      }}

  void opIndexAssign(DEntityCollection newCollection, string collectionName) {
    _collections[collectionName] = newCollection; }
version(test_uim_entitybase) {
  unittest {
      auto tenant = EntityTenant; 
      // TODO
      }}


  auto collectionNames() { return _collections.byKey.array; }

  // Number of Collection in a tenant
  size_t count() {
    return _collections.length; }
version(test_uim_entitybase) {
  unittest {
      auto tenant = EntityTenant; 
      // TODO
      }}
}
auto EntityTenant() { return new DEntityTenant; }
auto EntityTenant(DJBTenant jbTenant) { return new DEntityTenant(jbTenant); }
auto EntityTenant(Json options) { return new DEntityTenant(options); }
auto EntityTenant(DJBTenant jbTenant, Json options) { return new DEntityTenant(jbTenant, options); }

