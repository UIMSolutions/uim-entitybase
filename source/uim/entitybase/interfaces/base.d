module uim.entitybase.interfaces.base;

@safe:
import uim.entitybase;

interface IEntityBase : IEntityTenantManager {
  string name();

  IEntityCollection collection(string tenantName, string colName);
  bool hasCollection(string tenantName, string colName);

  IEntityCollection opIndex(DEntity entity, string colName);  
  IEntityCollection opIndex(string tenantName, string colName);

  string uniqueName(string tenantName, string collectionName, string firstName);
  size_t count();
}