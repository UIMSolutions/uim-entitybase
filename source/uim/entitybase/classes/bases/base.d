module uim.entitybase.bases.base;

@safe:
import uim.entitybase;

class DEntityBase {
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
/*     // debug writeln("uim.entitybase.bases.base:DEntityase::importDatabase");
    // debug writeln(jsDatabase.tenantNames); */

    if (jsDatabase) foreach (name, jsTenant; jsDatabase.tenants)
      this.tenant(name, EntityTenant(jsTenant)); 

    // debug writeln("Tenants: ", _tenants.byValue.array.length);
    auto numberOfCollections = 0;
    _tenants.byValue.each!(tenant => numberOfCollections += tenant.collectionNames.length);
    // debug writeln("Collections; ", numberOfCollections);

    return cast(O)this; }
version(test_uim_entitybase) {
  unittest {
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
  protected DEntityTenant[string] _tenants;

  DEntityTenant tenant(string tenantName) {
    //// debug writeln(moduleName!DEntityBase~":DEntityase::tenant");
    return _tenants.get(tenantName, EntityNullTenant); }
version(test_uim_entitybase) {
  unittest  {
      auto base = createTestDB("file"); 
      base
        .createTenant("testA")
        .createTenant("testB")
        .createTenant("testC");  
      assert(base.tenant["testB"] && base.tenant["testC"] && base.tenant["testC"]);
      assert(!base.tenant["testC"].isNull);
      assert(base.tenant["testD"].isNull);
      }}

  DEntityTenant opIndex(DEntity entity) {
    // debug writeln(moduleName!DEntityBase~":DEntityase::opIndex");
    return tenant(entity ? entity.name : null); }

  DEntityTenant opIndex(string tenantName) {
    // debug writeln(moduleName!DEntityBase~":DEntityase::opIndex");
    return tenant(tenantName); }
version(test_uim_entitybase) {
  unittest {
      auto base = createTestDB("file"); 
      base
        .createTenant("testA")
        .createTenant("testB")
        .createTenant("testC");  
      assert(base["testB"] && base["testC"] && base["testC"]);
      assert(!base["testC"].isNull);
      assert(base["testD"].isNull);
      }}

  O tenant(this O)(string tenantName, DEntityTenant newTenant) {
    // debug writeln(moduleName!DEntityBase~":DEntityase::opIndexAssign");
    _tenants[tenantName] = newTenant;
    return cast(O)this; }
version(test_uim_entitybase) {
  unittest {
      auto base = createTestDB("file"); 
      base
        .createTenant("testA")
        .createTenant("testB")
        .createTenant("testC");
      assert(base["testB"] && base["testC"] && base["testC"]);
      }}

  O opIndexAssign(this O)(DEntityTenant newTenant, string tenantName) {
    // debug writeln(moduleName!DEntityBase~":DEntityase::opIndexAssign");
    tenant(tenantName, newTenant);
    return cast(O)this; }
version(test_uim_entitybase) {
  unittest {
      auto base = createTestDB("file"); 
      base
        .createTenant("testA")
        .createTenant("testB")
        .createTenant("testC");
      assert(base["testB"] && base["testC"] && base["testC"]);
      }}
  
  auto tenantNames() { return _tenants.byKey().array; }
version(test_uim_entitybase) {
  unittest {
      auto base = createTestDB("file"); 
      base
        .createTenant("testA")
        .createTenant("testB")
        .createTenant("testC");
      assert(base.tenantNames.sort.array == ["testA", "testB", "testC"]);
      }}

  O createTenant(this O)(string name, Json options = Json(null)) {
    if (name !in _tenants) {
      _tenants[name] = EntityTenant(options); }
    return cast(O)this; }
version(test_uim_entitybase) {
  unittest {
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
version(test_uim_entitybase) {
  unittest {
      auto base = createTestDB("file");
      assert(base.hasTenant("tenantA"));
      assert(base.hasTenant("tenantB"));
      assert(!base.hasTenant("tenantC"));
      }}

  auto collection(string tenantName, string colName) {
    return tenant(tenantName)[colName]; }
version(test_uim_entitybase) {
  unittest {
      auto base = createTestDB("file");
      assert(base["tenantA"]);
      assert(!base["tenantC"]);
      }}

  auto hasCollection(string tenantName, string colName) {
    return hasTenant(tenantName) && this[tenantName].hasCollection(colName); }
version(test_uim_entitybase) {
  unittest {
      auto base = createTestDB("file");
      assert(base["tenantA"]);
      assert(!base["tenantC"]);
      }}

  DEntityCollection opIndex(DEntity entity, string colName) {
    return collection(entity ? entity.name : null, colName);
  }
  
  DEntityCollection opIndex(string tenantName, string colName) {
    return collection(tenantName, colName); }
version(test_uim_entitybase) {
  unittest {
      auto base = createTestDB("file");
      assert(base["tenantA"]);
      assert(!base["tenantC"]);
      }}

  string uniqueName(string tenantName, string collectionName, string firstName) {
    return collection(tenantName, collectionName).uniqueName(firstName); }
version(test_uim_entitybase) {
  unittest {
      auto base = createTestDB("file"); 
      // TODO 
      }}

  // #region count
  // Count tenants
  size_t count() {
    return _tenants.length; }
version(test_uim_entitybase) {
  unittest {
      auto base = createTestDB("file");
      assert(base.count == 2);
      }}
}
auto EntityBase() { return new DEntityBase; }
auto EntityBase(DJSBBase jsBase) { return new DEntityBase(jsBase); }
auto EntityBase(Json options) { return new DEntityBase(options); }
auto EntityBase(DJSBBase jsBase, Json options) { return new DEntityBase(jsBase, options); }
