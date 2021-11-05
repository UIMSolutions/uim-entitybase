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
    version(uim_entitybase) {
      auto tenant = ETBTenant; 
      // TODO
      }}

  void importTenant(DJBTenant jbTenant) {
    debug writeln("uim.entitybase.bases.base:DETBTenant::importTenant()");
    debug writeln(jbTenant.collectionNames);

    if (jbTenant) foreach (name, jsCollection; jbTenant.collections)
      this.collection(name, ETBCollection(jsCollection));     
    }
  unittest {
    version(uim_entitybase) {
      auto tenant = ETBTenant; 
      // TODO
      }}

  private DETBCollection[string] _collections;
  DETBCollection collection(string collectionName) {
    return _collections.get(collectionName, ETBNullCollection); }
  unittest {
    version(uim_entitybase) {
      auto tenant = ETBTenant; 
      // TODO
      }}

  // register collection with name
  O collection(this O)(DETBCollection[string] newCollections) {
    foreach(name, value; newCollections) collections(name, value);
    return cast(O)this; }
  unittest {
    version(uim_entitybase) {
      auto tenant = ETBTenant; 
      // TODO
      }}

  O collection(this O)(string collectionName, DETBCollection newCollection) {
    debug writeln("uim.entitybase.bases.base:DETBTenant::collection("~collectionName~", newCollectio)");
    _collections[collectionName] = newCollection.tenant(this);
    return cast(O)this; }
  unittest {
    version(uim_entitybase) {
      auto tenant = ETBTenant; 
      // TODO
      }}

  DETBCollection opIndex(string collectionName) {
    return collection(collectionName); }
  unittest {
    version(uim_entitybase) {
      auto tenant = ETBTenant; 
      // TODO
      }}

  auto collectionNames() { return _collections.byKey.array; }

  // Number of Collection in a tenant
  size_t count() {
    return _collections.length; }
  unittest {
    version(uim_entitybase) {
      auto tenant = ETBTenant; 
      // TODO
      }}
}
auto ETBTenant() { return new DETBTenant; }
auto ETBTenant(DJBTenant jbTenant) { return new DETBTenant(jbTenant); }
auto ETBTenant(Json options) { return new DETBTenant(options); }
auto ETBTenant(DJBTenant jbTenant, Json options) { return new DETBTenant(jbTenant, options); }

