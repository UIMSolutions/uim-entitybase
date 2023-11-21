module uim.entitybase.classes.tenants.tenant;

import uim.entitybase;

@safe:
class DEntityTenant : IEntityTenant, IEntityCollectionManager {
  this() {
    initialize; 
  }
  this(IJsonTenant jbTenant) {
    this();
    importTenant(jbTenant); }
  this(Json options) {
    this();
    // TODO option handling
  }
  this(IJsonTenant jbTenant, Json options) {
    this(jbTenant)
      .options(options); 
  }

  void initialize(Json configSettings = Json(null)) {
    this
      .entityCollectionContainer(EntityCollectionContainer);
  }

  mixin(OProperty!("IEntityTenantManager", "manager"));

  mixin EntityCollectionContainerTemplate;
  mixin EntityCollectionManagerTemplate;

  mixin(OProperty!("string", "name"));

   O options(this O)(Json newOptions) {
    // TODO - Option handling
    return cast(O)this;
  }

  bool isNull() {
    return false; 
  }
  
  bool notNull() { return true; }

  void importTenant(IJsonTenant jbTenant) {
    // debug writeln(moduleName!DEntityTenant, ":DEntityTenant::importTenant()");
    // debug writeln(jbTenant.collectionNames);

    if (jbTenant.isNull) return;

    jbTenant.collections.byKeyValue
      .each!(kv => this.addEntityCollection(kv.key, EntityCollection(kv.value)));
  }
}
auto EntityTenant() { return new DEntityTenant; }
auto EntityTenant(IJsonTenant jbTenant) { return new DEntityTenant(jbTenant); }
auto EntityTenant(Json options) { return new DEntityTenant(options); }
auto EntityTenant(IJsonTenant jbTenant, Json options) { return new DEntityTenant(jbTenant, options); }

