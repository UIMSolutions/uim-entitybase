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
    this(jbTenant)
      .options(options); 
  }

  void initialize(Json configSettings = Json(null)) {
    this
      .collectionContainer(EntityCollectionContainer);
  }

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

  void importTenant(DJBTenant jbTenant) {
    // debug writeln(moduleName!DEntityTenant, ":DEntityTenant::importTenant()");
    // debug writeln(jbTenant.collectionNames);

    if (jbTenant is null) return;

    foreach (name, jsCollection; jbTenant.collections) {
      this.collection(name, EntityCollection(jsCollection));
    }     
  }
}
auto EntityTenant() { return new DEntityTenant; }
auto EntityTenant(DJBTenant jbTenant) { return new DEntityTenant(jbTenant); }
auto EntityTenant(Json options) { return new DEntityTenant(options); }
auto EntityTenant(DJBTenant jbTenant, Json options) { return new DEntityTenant(jbTenant, options); }

