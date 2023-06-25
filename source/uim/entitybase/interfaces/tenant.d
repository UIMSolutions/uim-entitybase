module uim.entitybase.interfaces.tenant;

@safe:
import uim.entitybase;

interface IEntityTenant : IEntityCollectionManager {
  string name();
/*   bool isNull();
  
  bool hasCollection(DEntity entity);
  bool hasCollection(string collectionName);

  DEntityCollection collection(DEntity entity);
  DEntityCollection collection(string collectionName);

  // register collection with name
  O collection(this O)(DEntityCollection[string] newCollections);
  O collection(this O)(string collectionName, DEntityCollection newCollection);

  DEntityCollection opIndex(DEntity entity);
  DEntityCollection opIndex(string collectionName);

  void opIndexAssign(DEntityCollection newCollection, string collectionName);

  auto collectionNames();

  // Number of Collection in a tenant
  size_t count(); */
}