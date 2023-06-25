module uim.entitybase.classes.tenants.tenant;

@safe:
import uim.entitybase;

class DEntityTenant : IEntityTenant, IEntityCollectionManager {
  this() {
    initialize; 
  }
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

  void initialize() {
    this
      .entityCollectionContainer(EntityCollectionContainer);
  }

  mixin(OProperty!("string", "name"));

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
      this.entityCollection(name, EntityCollection(jsCollection));     
    }
version(test_uim_entitybase) {
  unittest {
      auto tenant = EntityTenant; 
      // TODO
      }}

  mixin EntityCollectionManagerTemplate;
}
auto EntityTenant() { return new DEntityTenant; }
auto EntityTenant(DJBTenant jbTenant) { return new DEntityTenant(jbTenant); }
auto EntityTenant(Json options) { return new DEntityTenant(options); }
auto EntityTenant(DJBTenant jbTenant, Json options) { return new DEntityTenant(jbTenant, options); }

