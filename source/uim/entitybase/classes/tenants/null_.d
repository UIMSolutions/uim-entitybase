module uim.entitybase.classes.tenants.null_;

import uim.entitybase;

version(testUimEntitybase) { 
  unittest {
    debug writeln("\n", __MODULE__~":"~__PRETTY_FUNCTION__); 
  }
}

@safe:
/* class DEntityNullTenant : DEntityTenant {
  this() {}

  override DEntityCollection collection(string collectionName) {
    return EntityNullCollection; }
version(test_uim_entitybase) {
  unittest {
      auto base = EntityBase; 
      // TODO 
      }}

  override bool isNull() {
    return true; }
version(test_uim_entitybase) {
  unittest {
      auto tenant = EntityTenant; 
      // TODO
      }}
  override bool notNull() { return false; }
  
  override bool hasCollection(string collectionName) {
    return false; }
version(test_uim_entitybase) {
  unittest {
      auto tenant = EntityTenant; 
      // TODO
      }}


  // Number of Collection in a tenant
  override size_t count() {
    return 0; }
version(test_uim_entitybase) {
  unittest {
      auto tenant = EntityTenant; 
      // TODO
      }}
  
  override DEntityCollection opIndex(string collectionName) {
    return EntityNullCollection; }
version(test_uim_entitybase) {
  unittest {
      auto tenant = EntityTenant; 
      // TODO
      }}
}
auto EntityNullTenant() { return new DEntityNullTenant; } */