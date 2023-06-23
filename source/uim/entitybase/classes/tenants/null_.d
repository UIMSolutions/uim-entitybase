module uim.entitybase.tenants.null_;

@safe:
import uim.entitybase;

class DETBNullTenant : DETBTenant {
  this() {}

  override DETBCollection collection(string collectionName) {
    return ETBNullCollection; }
version(test_uim_entitybase) {
  unittest {
      auto base = ETBBase; 
      // TODO 
      }}

  override bool isNull() {
    return true; }
version(test_uim_entitybase) {
  unittest {
      auto tenant = ETBTenant; 
      // TODO
      }}
  override bool notNull() { return false; }
  
  override bool hasCollection(string collectionName) {
    return false; }
version(test_uim_entitybase) {
  unittest {
      auto tenant = ETBTenant; 
      // TODO
      }}


  // Number of Collection in a tenant
  override size_t count() {
    return 0; }
version(test_uim_entitybase) {
  unittest {
      auto tenant = ETBTenant; 
      // TODO
      }}
  
  override DETBCollection opIndex(string collectionName) {
    return ETBNullCollection; }
version(test_uim_entitybase) {
  unittest {
      auto tenant = ETBTenant; 
      // TODO
      }}
}
auto ETBNullTenant() { return new DETBNullTenant; }