module uim.entitybase.classes.bases.base;

@safe:
import uim.entitybase;

class DEntityBase : IEntityTenantManager {
  this() {}
  this(DJSBBase jsDatabase) {
    this().importDatabase(jsDatabase); }
  this(Json options) {
    this();
    this.options(options); }
  this(DJSBBase jsDatabase, Json options) {
    this(jsDatabase);
    this.options(options); }

  mixin EntityTenantManagerTemplate;

  O importDatabase(this O)(DJSBBase jsDatabase) {
/*     // debug writeln("uim.entitybase.classes.bases.base:DEntityase::importDatabase");
    // debug writeln(jsDatabase.tenantNames); */

    if (jsDatabase) foreach (name, jsTenant; jsDatabase.tenants)
      this.entityTenant(name, EntityTenant(jsTenant)); 

/*     // debug writeln("Tenants: ", _tenants.byValue.array.length);
    auto numberOfCollections = 0;
    foreach(name, myTenant; _tenants) {
      numberOfCollections += myTenant.collectionNames.length;
    } // debug writeln("Collections; ", numberOfCollections);
 */
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
/* 
  auto collection(string tenantName, string colName) {
    return tenant(tenantName)[colName]; }
version(test_uim_entitybase) {
  unittest {
      auto base = createTestDB("file");
      assert(base["tenantA"]);
      assert(!base["tenantC"]);
      }}

  auto hasCollection(string tenantName, string colName) {
    return hasTenant(tenantName) && this[tenantName].hasEntityCollection(colName); }
version(test_uim_entitybase) {
  unittest {
      auto base = createTestDB("file");
      assert(base["tenantA"]);
      assert(!base["tenantC"]);
      }} */

/*   DEntityCollection opIndex(DEntity entity, string colName) {
    return entityCollection(entity ? entity.name : null, colName);
  } */
  
/*   DEntityCollection opIndex(string tenantName, string colName) {
    auto myTenant = E

    return collection(tenantName, colName); }
version(test_uim_entitybase) {
  unittest {
      auto base = createTestDB("file");
      assert(base["tenantA"]);
      assert(!base["tenantC"]);
      }} */

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
