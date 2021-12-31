module uim.entitybase.bases.base;

@safe:
import uim.entitybase;

class DETBBase {
  this() {}
  this(DJSBBase jsDatabase) {
    this();
    this.importDatabase(jsDatabase); }
  this(Json options) {
    this();
    this.options(options); }
  this(DJSBBase jsDatabase, Json options) {
    this(jsDatabase);
    this.options(options); }

  O importDatabase(this O)(DJSBBase jsDatabase) {
    debug writeln("uim.entitybase.bases.base:DETBase::importDatabase");
    debug writeln(jsDatabase.tenantNames);

    if (jsDatabase) foreach (name, jsTenant; jsDatabase.tenants)
      this.tenant(name, ETBTenant(jsTenant)); 

    debug writeln("Tenants: ", _tenants.byValue.array.length);
    auto numberOfCollections = 0;
    foreach(t; _tenants.byValue) numberOfCollections += t.collectionNames.length;
    debug writeln("Collections; ", numberOfCollections);

    return cast(O)this; }
  unittest {
    version(uim_entitybase) {
      auto base = createTestDB("file");
      assert(base.hasTenant("tenantA"));
      assert(base.hasTenant("tenantB"));
      assert(base.tenant("tenantA").collection("collectionA"));
      assert(base.tenant("tenantB").collection("collectionC"));
      }}

  O options(this O)(Json newOptions) {
    // TODO - Option handling
    return cast(O)this;
  }
  protected DETBTenant[string] _tenants;

  DETBTenant tenant(string tenantName) {
    debug writeln(moduleName!DETBBase~":DETBase::tenant");
    return _tenants.get(tenantName, ETBNullTenant); }
  unittest {
    version(uim_entitybase) {
      auto base = createTestDB("file"); 
      base
        .createTenant("testA")
        .createTenant("testB")
        .createTenant("testC");  
      assert(base.tenant["testB"] && base.tenant["testC"] && base.tenant["testC"]);
      assert(!base.tenant["testC"].isNull);
      assert(base.tenant["testD"].isNull);
      }}

  DETBTenant opIndex(string tenantName) {
    debug writeln(moduleName!DETBBase~":DETBase::opIndex");
    return tenant(tenantName); }
  unittest {
    version(uim_entitybase) {
      auto base = createTestDB("file"); 
      base
        .createTenant("testA")
        .createTenant("testB")
        .createTenant("testC");  
      assert(base["testB"] && base["testC"] && base["testC"]);
      assert(!base["testC"].isNull);
      assert(base["testD"].isNull);
      }}

  O tenant(this O)(string tenantName, DETBTenant newTenant) {
    debug writeln(moduleName!DETBBase~":DETBase::opIndexAssign");
    _tenants[tenantName] = newTenant;
    return cast(O)this; }
  unittest {
    version(uim_entitybase) {
      auto base = createTestDB("file"); 
      base
        .createTenant("testA")
        .createTenant("testB")
        .createTenant("testC");
      assert(base["testB"] && base["testC"] && base["testC"]);
      }}

  O opIndexAssign(this O)(DETBTenant newTenant, string tenantName) {
    debug writeln(moduleName!DETBBase~":DETBase::opIndexAssign");
    tenant(tenantName, newTenant);
    return cast(O)this; }
  unittest {
    version(uim_entitybase) {
      auto base = createTestDB("file"); 
      base
        .createTenant("testA")
        .createTenant("testB")
        .createTenant("testC");
      assert(base["testB"] && base["testC"] && base["testC"]);
      }}
  
  auto tenantNames() { return _tenants.byKey().array; }
  unittest {
    version(uim_entitybase) {
      auto base = createTestDB("file"); 
      base
        .createTenant("testA")
        .createTenant("testB")
        .createTenant("testC");
      assert(base.tenantNames.sort.array == ["testA", "testB", "testC"]);
      }}

  O createTenant(this O)(string name, Json options = Json(null)) {
    if (name !in _tenants) {
      _tenants[name] = ETBTenant(options); }
    return cast(O)this; }
  unittest {
    version(uim_entitybase) {
      auto base = createTestDB("file"); 
      base.createTenant("testA");
      assert(base.tenant("testA"));
      base
        .createTenant("testB")
        .createTenant("testC");
      assert(base.tenant("testB") && base.tenant("testC"));
      assert(base.tenant("testA") && base.tenant("testB") && base.tenant("testC"));

      // TODO: Tests with options(Json)
      }}

  bool hasTenant(string name) {
    return name in _tenants ? true : false; }
  unittest {
    version(uim_entitybase) {
      auto base = createTestDB("file");
      assert(base.hasTenant("tenantA"));
      assert(base.hasTenant("tenantB"));
      assert(!base.hasTenant("tenantC"));
      }}

  auto collection(string tenantName, string colName) {
    return tenant(tenantName)[colName]; }
  unittest {
    version(uim_entitybase) {
      auto base = createTestDB("file");
      assert(base["tenantA"]);
      assert(!base["tenantC"]);
      }}

  auto hasCollection(string tenantName, string colName) {
    return hasTenant(tenantName) && this[tenantName].hasCollection(colName); }
  unittest {
    version(uim_entitybase) {
      auto base = createTestDB("file");
      assert(base["tenantA"]);
      assert(!base["tenantC"]);
      }}

  DETBCollection opIndex(string tenantName, string colName) {
    return collection(tenantName, colName); }
  unittest {
    version(uim_entitybase) {
      auto base = createTestDB("file");
      assert(base["tenantA"]);
      assert(!base["tenantC"]);
      }}

  string uniqueName(string tenantName, string collectionName, string firstName) {
    return collection(tenantName, collectionName).uniqueName(firstName); }
  unittest {
    version(uim_entitybase) {
      auto base = createTestDB("file"); 
      // TODO 
      }}

  // #region count
  // Count tenants
  size_t count() {
    return _tenants.length; }
  unittest {
    version(uim_entitybase) {
      auto base = createTestDB("file");
      assert(base.count == 2);
      }}
}
auto ETBBase() { return new DETBBase; }
auto ETBBase(DJSBBase jsBase) { return new DETBBase(jsBase); }
auto ETBBase(Json options) { return new DETBBase(options); }
auto ETBBase(DJSBBase jsBase, Json options) { return new DETBBase(jsBase, options); }
