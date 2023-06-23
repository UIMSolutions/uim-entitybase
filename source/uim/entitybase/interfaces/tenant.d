module uim.entitybase.interfaces.tenant;

@safe:
import uim.entitybase;

interface IEntityTenant {
  bool isNull();
  
  bool hasCollection(DEntity entity);
  bool hasCollection(string collectionName);

  DETBCollection collection(DEntity entity);
  DETBCollection collection(string collectionName);

  // register collection with name
  O collection(this O)(DETBCollection[string] newCollections);
  O collection(this O)(string collectionName, DETBCollection newCollection);

  DETBCollection opIndex(DEntity entity);
  DETBCollection opIndex(string collectionName);

  void opIndexAssign(DETBCollection newCollection, string collectionName);

  auto collectionNames();

  // Number of Collection in a tenant
  size_t count();
}