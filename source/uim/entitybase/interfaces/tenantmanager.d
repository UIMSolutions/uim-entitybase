module uim.entitybase.interfaces.tenantmanager;

@safe:
import uim.entitybase;

interface IEntityTenantManager {
  void entityTenants(DEntityTenantContainer aContainer);
  DEntityTenantContainer entityTenants();

  IEntityTenant entityTenant(string[string] options);
  IEntityTenant entityTenant(string aName);

  bool existsEntityTenant(IEntityTenant aTenant);
  bool existsEntityTenant(string aName);

  void addEntityTenant(IEntityTenant aTenant);
  void addEntityTenant(string aName, IEntityTenant aTenant);

  // Update existing entitytenant
  void updateEntityTenant(IEntityTenant aTenant);
  void updateEntityTenant(string aName, IEntityTenant aTenant);

  // Remove existing entitytenant
  void removeEntityTenant(IEntityTenant aTenant);
  void removeEntityTenant(string aName);
}