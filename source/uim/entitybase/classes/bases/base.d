module uim.entitybase.classes.bases.base;

@safe:
import uim.entitybase;

class DEntityBase : IEntityTenantManager {
  this() { 
    initialize; 
  }
  this(DJSBBase jsDatabase) {
    this()
      .importDatabase(jsDatabase); 
  }
  this(Json options) {
    this()
      .options(options); 
  }
  this(DJSBBase jsDatabase, Json options) {
    this(jsDatabase)
      .options(options); 
  }

  void initialize(Json configSettings = Json(null)) {
    this
      .entityTenantContainer(EntityTenantContainer);
  }

  mixin(OProperty!("IEntityBaseManager", "manager"));
  mixin EntityTenantContainerTemplate;
  mixin EntityTenantManagerTemplate;

  O importDatabase(this O)(DJSBBase jsDatabase) {
    debug writeln(__MODULE__~" - importDatabase(this O)(DJSBBase jsDatabase)"); 
/*     debug writeln(jsDatabase.tenantNames);

    if (jsDatabase) foreach (name, jsTenant; jsDatabase.tenants)
      this.addEntityTenant(name, EntityTenant(jsTenant)); 
 */
/*     // debug writeln("Tenants: ", _tenants.byValue.array.length);
    auto numberOfCollections = 0;
    foreach(name, myTenant; _tenants) {
      numberOfCollections += myTenant.collectionNames.length;
    } // debug writeln("Collections; ", numberOfCollections);
 */
    return cast(O)this; 
  }
version(test_uim_entitybase) {
  unittest {
      auto base = createTestDB("file");
      assert(base.hasEntityTenant("tenantA"));
      assert(base.hasEntityTenant("tenantB"));
      assert(base.entityTenant("tenantA").entityCollection("collectionA"));
      assert(base.entityTenant("tenantB").entityCollection("collectionC"));
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

  string uniqueName(string aTenantName, string collectionName, string firstName) {
    if (auto myTenant = entityTenant(aTenantName)) {
      if (auto myCollection = myTenant.entityCollection(collectionName)) {
        return myCollection.uniqueName(firstName); 
      }
    }

    return null;
  }
version(test_uim_entitybase) {
  unittest {
      auto base = createTestDB("file"); 
      // TODO 
      }}


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
